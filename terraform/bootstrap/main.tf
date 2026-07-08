resource "aws_s3_bucket" "s3_bucket" {
  bucket = "mustafa-devopsv2-tfstate"

  tags = {
    Name = "My S3 bucket"
  }
}


resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}