terraform {
  backend "gcs" {
    bucket = "google-group-tfstate"
    prefix = "PROJECT_NAME" # TODO: Change to your project name.
  }
}
