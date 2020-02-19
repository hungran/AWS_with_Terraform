provider "aws" {
  shared_credentials_file = ".aws/Cred/accessKeys.csv"
  region                  = "ap-southeast-1"
}
// define random-id
resource "random_id" "my-random-id" {
  byte_length = 2
}
// define bucket
resource "aws_s3_bucket" "hung-bucket" {
    bucket = "${var.s3_bucket_name}-${random_id.my-random-id.dec}"
    acl = "private"
    versioning {
        enabled = true
    }
/*    logging {
        target_bucket ="${aws_s3_bucket.hung-bucket.id}"
        target_prefix = "log/"
    }*/
    lifecycle_rule {
        enabled = true
        transition {
            storage_class = "GLACIER"
            days = 2
        }  
        expiration {
            days = 3
        }
    }    
    tags = {
        Name = "hung_tag_s3"
    }
}
