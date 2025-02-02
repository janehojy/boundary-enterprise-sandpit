resource "boundary_auth_method_password" "password" {
  scope_id              = boundary_scope.global.id
  description           = "Password authenticate method"
  min_login_name_length = 5
  min_password_length   = 8
}

resource "boundary_auth_method_oidc" "auth0_oidc" {
  scope_id             = boundary_scope.org[local.digital_channel_org].id
  name                 = "Auth0"
  description          = "OIDC auth method for Digital Channels"
  type                 = "oidc"
  issuer               = "https://${var.auth0_domain}/"
  client_id            = var.client_id
  client_secret        = var.client_secret
  callback_url         = "https://${var.boundary_cluster_url}/v1/auth-methods/oidc:authenticate:callback"
  api_url_prefix       = "https://${var.boundary_cluster_url}"
  signing_algorithms   = ["RS256"]
  claims_scopes        = ["profile", "email", "groups"]
  is_primary_for_scope = false
  max_age              = 0
}

resource "boundary_auth_method_oidc" "azure_oidc" {
  scope_id             = boundary_scope.org[local.digital_channel_org].id
  name                 = "Azure"
  description          = "Azure OIDC auth method for Digital Channels"
  type                 = "oidc"
  issuer               = "https://login.microsoftonline.com/${var.az_ad_tenant_id}/v2.0"
  client_id            = var.az_ad_client_id
  client_secret        = var.az_ad_client_secret
  callback_url         = "https://${var.boundary_cluster_url}/v1/auth-methods/oidc:authenticate:callback"
  api_url_prefix       = "https://${var.boundary_cluster_url}"
  signing_algorithms   = ["RS256"]
  claims_scopes        = ["profile", "email"]
  is_primary_for_scope = true
  max_age              = 10
}

resource "boundary_auth_method_oidc" "okta_oidc" {
  scope_id             = boundary_scope.org[local.middleware_org].id
  name                 = "Okta"
  description          = "OKta OIDC auth method for Middleware"
  type                 = "oidc"
  issuer               = "https://${var.okta_domain}"
  client_id            = var.okta_client_id
  client_secret        = var.okta_client_secret
  callback_url         = "https://${var.boundary_cluster_url}/v1/auth-methods/oidc:authenticate:callback"
  api_url_prefix       = "https://${var.boundary_cluster_url}"
  signing_algorithms   = ["RS256"]
  claims_scopes        = ["profile", "email", "groups"]
  is_primary_for_scope = true
  max_age = 0
}
