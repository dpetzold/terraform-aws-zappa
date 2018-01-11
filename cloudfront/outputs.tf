output "aws_cloudfront_distributions" {
  value = ["${aws_cloudfront_distribution.cf_distribution.*.etag}"]
}

/*
output "aws_cloudfront_urls" {
  value = ["https://${aws_cloudfront_distribution.cf_distribution.*.domain_name}/"]
}
*/

output "aws_cloudfront_domains" {
  value = ["${aws_cloudfront_distribution.cf_distribution.*.domain_name}"]
}

output "aws_lambda_bucket_name" {
  value = "${aws_s3_bucket.lambda_bucket.bucket}"
}
