# book-specific code to include on every page

video <- function(url) {
  paste('<iframe src="', url, '" allowfullscreen width=80% height=350></iframe>')
}

video_code <- function(code) {
  video(paste0("https://www.youtube.com/embed/", code, "?rel=0"))
}

if (!require("pacman")) install.packages("pacman")
