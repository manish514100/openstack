terraform {
    backend "s3" {
        endpoint = "https://minbucket.tritec.in" # Minio endpoint
        key = "magnumk8ssetup.tfstate"        # Name of the tfstate file


        region = "main"                     # Region validation will be skipped
        skip_credentials_validation = true  # Skip AWS related checks and validations
        skip_metadata_api_check = true
        skip_region_validation = true
        force_path_style = true             # Enable path-style S3 URLs (https://<HOST>/<BUCKET> https://www.terraform.io/language/settings/backends/s3#force_path_style
    }

}