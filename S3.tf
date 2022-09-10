#BUCKET S3
resource "aws_s3_bucket" "s3-top-top-top" {
  bucket = "s3-top-top-top"
}

resource "aws_s3_bucket_acl" "s3-top-top-top-acl" {
  bucket = aws_s3_bucket.s3-top-top-top.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "s3-top-top-top-versioning" {
  bucket = aws_s3_bucket.s3-top-top-top.id
  versioning_configuration {
    status = "Enabled"
  }
}

# STATIC SITE
resource "aws_s3_bucket_website_configuration" "s3-top-top-top-static-site" {
  bucket = aws_s3_bucket.s3-top-top-top.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# S3 BUCKET OBJECTS
resource "aws_s3_bucket_object" "s3-top-top-top-object" {
    bucket   = aws_s3_bucket.s3-top-top-top.id
    for_each = fileset("data/", "*")
    key      = each.value
    source   = "data/${each.value}"
    acl      = "public-read"
}