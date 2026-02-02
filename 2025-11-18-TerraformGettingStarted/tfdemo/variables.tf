variable "filename1" {
  type        = string
  description = "The is the filename for filename1."
  default     = "mydefaultfile"
}

variable "data_filenames" {
  type        = list(string)
  description = "List of data file names"
}

variable "data_objects_map" {
  type = map(object({
    content = string
  }))
  description = "Map of data file objects"
}
