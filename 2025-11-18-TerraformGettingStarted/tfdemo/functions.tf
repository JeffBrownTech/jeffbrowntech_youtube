# # Using conditional and fileexists()
resource "local_file" "data1" {
  filename = fileexists("${path.module}/data/data1") ? "${path.module}/data/data1_v2" : "${path.module}/data/data1"
  content  = "data1 version 2"
}

# # Using timestamp
resource "local_file" "timestamp_file" {
  filename = "${path.module}/files/timestamp"
  content  = timestamp()

  lifecycle {
    ignore_changes = [ content ]
  }
}

# # Using jsonencode
resource "local_file" "jsonencode_file" {
  filename = "${path.module}/files/jsonencoded.json"
  content = jsonencode(
    {
      "hello" = "world"
      "name"  = "Jeff"
    }
  )
}
