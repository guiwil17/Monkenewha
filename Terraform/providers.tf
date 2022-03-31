# AWS - Data Buckets & Lambdas
provider "aws" {
  region = "eu-west-3"

  profile             = "Monkenewha"
  allowed_account_ids = ["840917235618"]

}


# AWS - Cloudfront Certificate 
# (MUST be in us-east-1)
provider "aws" {
  region = "us-east-1"
  alias  = "virginia"

  profile             = "Monkenewha"
  allowed_account_ids = ["840917235618"]


}

# AWS - Ses
provider "aws" {
  region = "eu-west-1"
  alias  = "ireland"

  profile = "Monkenewha"

  allowed_account_ids = ["840917235618"]

}

provider "local" {
}

