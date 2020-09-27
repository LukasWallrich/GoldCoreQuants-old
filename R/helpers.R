get_link <- function(pattern, name = "click here", rename = TRUE) {
  file <- list.files("./files/", pattern = pattern)
  if(length(file) == 0) stop("No matching file found in ./files/")
  if(length(file) > 1) {
    stop("Multiple files found - adjust pattern to refer to unique file. Currently matches:\n", paste(file, collapse = "\n"))
  }
  file_name <-  gsub("[^A-Za-z0-9._-]","_",file)
  file.rename(paste0("./files/", file), paste0("./files/", file_name))
  
  out <- paste0('<a href="./files/', file_name, '">', name, '</a>')
  cat(out)
  invisible(out)
}
