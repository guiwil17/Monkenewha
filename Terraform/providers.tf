# AWS - Data Buckets & Lambdas
provider "aws" {
  region = "eu-west-3"

<<<<<<< HEAD
  profile = "Monkenewha"
=======
  profile             = "Monkenewha"
  allowed_account_ids = ["840917235618"]

>>>>>>> edf2e7d1243a7fa6e9677b7464d4fd3934338dc7
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

