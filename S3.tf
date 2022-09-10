#BUCKET S3
resource "aws_s3_bucket" "s3-top-top-top" {
  bucket = "s3-top-top-top"
}

# ACL S3
resource "aws_s3_bucket_acl" "s3-top-top-top-acl" {
  bucket = aws_s3_bucket.s3-top-top-top.id
  acl    = "public-read"
}

# POLICY S3
resource "aws_s3_bucket_policy" "s3-top-top-top-policy" {
  bucket = aws_s3_bucket.s3-top-top-top.id

  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::s3-top-top-top/*",
      }
    ]
	})
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
    content_type = "text/html"
}

