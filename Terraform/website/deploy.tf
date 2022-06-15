// Fichier de mise en place de l'infrastructure pour le website

provider "aws" {
  region = "eu-west-3"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "monkenewha.com"
  acl    = "private"
  # Add specefic S3 policy in the s3-policy.json on the same directory
  #policy = file("s3-policy.json")

  versioning {
    enabled = false
  }

  website {
    index_document = "index.html"
    error_document = "index.html"

    # Add routing rules if required
    #routing_rules = <<EOF
    #                [{
    #                    "Condition": {
    #                        "KeyPrefixEquals": "docs/"
    #                    },
    #                    "Redirect": {
    #                        "ReplaceKeyPrefixWith": "documents/"
    #                    }
    #                }]
    #                EOF
  }

  tags = {
    Environment = "development"
    Name        = "my-tag"
  }

}


locals {
  s3_origin_id = "monkenewha.com"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "monkenewha.com"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.mybucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "my-cloudfront"
  default_root_object = "index.html"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Configure logging here if required 	
  #logging_config {
  #  include_cookies = false
  #  bucket          = "mylogs.s3.amazonaws.com"
  #  prefix          = "myprefix"
  #}

  # If you have domain configured use it here 
  #aliases = ["mywebsite.example.com", "s3-static-web-dev.example.com"]

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    compress = true

    // This needs to match the `origin_id` above.
    target_origin_id = local.s3_origin_id
    min_ttl          = 0
    default_ttl      = 3600
    max_ttl          = 7200
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    compress               = true
    min_ttl                = 0
    default_ttl            = 120
    max_ttl                = 120
    viewer_protocol_policy = "redirect-to-https"

  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/index.html"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    compress               = true
    min_ttl                = 0
    default_ttl            = 120
    max_ttl                = 120
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  tags = {
    Environment = "development"
    Name        = "my-tag"
  }


  wait_for_deployment = false

  viewer_certificate {
    cloudfront_default_certificate = true
    ssl_support_method             = "sni-only"

  }
}

# to get the Cloud front URL if doamin/alias is not configured
output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid     = "AllowObjectsInWebsiteBucket"
    effect  = "Allow"
    actions = ["s3:GetObject", "s3:PutObject"]
    resources = [aws_s3_bucket.mybucket.arn,
    "${aws_s3_bucket.mybucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_s3_bucket_public_access_block" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "website_deployer" {
  statement {
    sid    = "AllowObjectsInWebsiteBucket"
    effect = "Allow"

    actions = [
      "s3:DeleteObject",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.mybucket.arn,
      "${aws_s3_bucket.mybucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "website_deployer" {
  name        = "MonkenewhaDeployWebsite"
  description = "Permet le déploiement de monkenewha"
  policy      = data.aws_iam_policy_document.website_deployer.json
}

resource "aws_iam_user" "website_deployer" {
  name = "_machine.gitlab_ucesorh_deploy"
}

resource "aws_iam_user_policy_attachment" "website_deployer" {
  user       = aws_iam_user.website_deployer.name
  policy_arn = aws_iam_policy.website_deployer.arn
}

resource "aws_iam_access_key" "website_deployer" {
  user = aws_iam_user.website_deployer.name
}

