
resource "google_service_account" "service_account_one" {
  account_id   = "terraform-sa-one"
  display_name = "Terraform SA One"
  project      = var.project_id
}


resource "google_service_account_iam_binding" "admin-account-iam" {
  service_account_id = google_service_account.service_account_one.name
  role               = "roles/${google_project_iam_custom_role.my-sv-role.role_id}"

  members = [
    "allUsers",
  ]
}

