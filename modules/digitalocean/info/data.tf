data "http" "images" {
  count = 4
  url   = "https://api.digitalocean.com/v2/images?type=distribution&page=${count.index}"

  request_headers {
    "Authorization" = "Bearer ${var.api_key}"
  }
}
# coreos-stable
