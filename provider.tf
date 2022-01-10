# Specify the provider (GCP, AWS, Azure)
provider "google" {
  credentials = "${file("credentials.json")}"
  project     = "bri-tcd-playground"
  region      = "asia-southeast1"
}

data "google_compute_zones" "available" {}