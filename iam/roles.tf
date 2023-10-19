resource "google_project_iam_custom_role" "my-sv-role" {
  role_id     = "service_account_one_custom_role"
  title       = "My Custom Role for Service Account One "
  description = " This is a custom role for service account one to allow it to create and delete resources"
  permissions = ["compute.*" , "storage.*"  , "artifactregistry.*" , "container.*" ]
}