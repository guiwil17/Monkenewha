resource "aws_s3_bucket" "monkenewha" {
  bucket = "monkenewha"
}

resource "aws_s3_bucket_acl" "monkenewha" {
  bucket = aws_s3_bucket.monkenewha.id
  acl    = "private"
}
resource "aws_s3_bucket_versioning" "monkenewha" {
  bucket = aws_s3_bucket.monkenewha.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_public_access_block" "monkenewha" {
  bucket                  = aws_s3_bucket.monkenewha.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
