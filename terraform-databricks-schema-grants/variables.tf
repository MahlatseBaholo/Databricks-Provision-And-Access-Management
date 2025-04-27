variable "schema_access" {
  description = "Access grants at schema level."
  type        = map(map(list(string)))
}
