# count examples
resource "local_file" "countfiles" {
  count = 3

  filename = "${path.module}/data/count${count.index}"
  content  = "File created using count"
}

# for_each examples
resource "local_file" "datafiles" {
  for_each = toset(var.data_filenames)

  filename = "${path.module}/data/${each.value}"
  content  = "This is the content for ${each.value}"
}

resource "local_file" "datamap" {
  for_each = var.data_objects_map

  filename = "${path.module}/data/${each.key}"
  content  = each.value.content
}
