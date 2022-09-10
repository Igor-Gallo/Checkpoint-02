# BUCKET S3
resource "aws_s3_bucket" "s3-toptoptop" {
  bucket = "s3-toptoptop"
}

# POLICY S3
resource "aws_s3_bucket_policy" "s3-toptoptop" {
  bucket = aws_s3_bucket.s3-toptoptop.id

  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::s3-toptoptop/*",
      }
    ]
	})
}

# VERSIONING S3 BUCKET
resource "aws_s3_bucket_versioning" "s3-toptoptop" {
  bucket = aws_s3_bucket.s3-toptoptop.id
  versioning_configuration {
    status = "Enabled"
  }
}

# STATIC SITE
resource "aws_s3_bucket_website_configuration" "s3-toptoptop" {
  bucket = aws_s3_bucket.s3-toptoptop.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# S3 BUCKET OBJECTS
resource "aws_s3_bucket_object" "s3-toptoptop" {
    bucket   = aws_s3_bucket.s3-toptoptop.id
    for_each = fileset("data/", "*")
    key      = each.value
    source   = "data/${each.value}"
    content_type = "text/html"
}
