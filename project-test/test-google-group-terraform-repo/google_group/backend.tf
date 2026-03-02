terraform {
  backend "gcs" {
    bucket = "google-group-tfstate"
    prefix = "project-test"
  }
}
