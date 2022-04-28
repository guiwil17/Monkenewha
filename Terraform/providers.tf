# AWS - Data Buckets & Lambdas
provider "aws" {
  region = "eu-west-3"

  profile = "Monkenewha"

}


# AWS - Cloudfront Certificate 
# (MUST be in us-east-1)
provider "aws" {
  region = "us-east-1"
  alias  = "virginia"

  profile = "Monkenewha"


}

# AWS - Ses
provider "aws" {
  region = "eu-west-1"
  alias  = "ireland"

  profile = "Monkenewha"

}

provider "local" {
}

