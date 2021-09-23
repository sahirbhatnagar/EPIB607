# see https://github.com/jennybc/send-email-with-r
# I set up a project for FALL 2018 called EPIB607

pacman::p_load(gmailr)

# did this once only
# gmailr::clear_token()
# gm_auth_configure(key = "956861284344-mavn6a7n6i1qsnckdi65s4rbtrm58m1a.apps.googleusercontent.com",
#                   path = "~/Downloads/client_secret_956861284344-mavn6a7n6i1qsnckdi65s4rbtrm58m1a.apps.googleusercontent.com.json")
pacman::p_load(dplyr)
# pacman::p_load(purrr)

# stored on local laptop only for security reasons
emails <- read.csv("~/Downloads/epib607.csv",
                   stringsAsFactors = FALSE)
dim(emails)

# add column of indices used to sample from the "population" file
# for each student
emails <- emails %>%
  mutate(I_5_start = 1L,
         I_5_end = 1L,
         I_20_start = 1L,
         I_20_end = 1L)

N.r <- nrow(emails)

OffsetAll    = 0; # sequential, from very top (optional)
OffsetDepths = 0;
OffsetLand   = 0;

# add start and stop indices for each student
for (i in 1:N.r) {

  for (n in c(5,20) ) {
    I <- OffsetAll + 1:n
    OffsetAll <- OffsetAll + n

    if (n == 5) {
      emails[i, "I_5_start"] <- min(I)
      emails[i, "I_5_end"] <- max(I)
    } else {
      emails[i, "I_20_start"] <- min(I)
      emails[i, "I_20_end"] <- max(I)
    }
  }
}


# function to generate separate reports for each students
renderMyDocument <- function(email, id, name, ind5, ind20) {
  rmarkdown::render(input = "/home/sahir/git_repositories/epib607/inst/labs/003-ocean-depths/water_exercise_epib607.Rmd",
                    output_file = sprintf("%s_water_exercise_epib607.pdf", id),
                    output_dir = "/home/sahir/git_repositories/epib607/inst/labs/003-ocean-depths/students/",
                    params = list(
                      email = email,
                      name = name,
                      ind5 = ind5,
                      ind20 = ind20
                      ))
}


names(emails)
emails[87,]
BODY <- paste("Hello!\n
              See attached pdf for your randomly sampled latitudes and longitudes for the in-class exercise we will do on sampling distributions for means and proportions.\n
              Note that these latitudes and longitudes have been randomly sampled for each student in the class.\n
              This means that each student has a unique pdf with unique latitudes and longitudes.\n
              Sahir")

# first run the renderMyDocument to get all the pdfs, then comment that code and
# run the gmail code

# for (i in 1:nrow(emails)) {
for(i in 1:nrow(emails)) {
  # renderMyDocument(email = emails[i, "Email"],
  #                  id = emails[i,"ID"],
  #                  name = paste(emails[i, "First.Name"], emails[i, "Last.Name"]),
  #                  ind5 = emails[i, "I_5_start"]:emails[i, "I_5_end"],
  #                  ind20 = emails[i, "I_20_start"]:emails[i, "I_20_end"])
  # system(sprintf("rm /home/sahir/git_repositories/epib607/inst/labs/003-ocean-depths/students/%s_water_exercise_epib607.tex", emails[i,"ID"]))

  BODY <- sprintf("Hi %s\nSee attached pdf for your randomly sampled latitudes and longitudes for the in-class exercise we will do on sampling distributions for means and proportions.\nNote that these latitudes and longitudes have been randomly sampled for each student in the class.\nThis means that each student has a unique pdf with unique latitudes and longitudes.\nSahir", emails[i,"Student.Name"])

  test_email <-
    gm_mime() %>%
    # gm_to("sahir.bhatnagar@mcgill.ca") %>%
    gm_to(emails[i, "Email"]) %>%
    gm_from("sahir.bhatnagar@gmail.com") %>%
    gm_subject("[Fall 2021 - EPIB-607-001 - Inferential Statistics]: In-class exercise on sampling distributions") %>%
    gm_text_body(BODY) %>%
    gm_attach_file(sprintf("/home/sahir/git_repositories/epib607/inst/labs/003-ocean-depths/students/%s_water_exercise_epib607.pdf", emails[i,"ID"]))
  # gm_attach_file(sprintf("/home/sahir/git_repositories/epib607/inst/labs/003-ocean-depths/students/%s_water_exercise_epib607.pdf", emails[1,"ID"]))


  gm_send_message(test_email)
  base::message(sprintf("%s, %s", emails[i,"Student.Name"], emails[i,"ID"]))
}

# emails[86,]
# allLocations[2126:2130,]
#
# recipient = c("sahir.bhatnagar@mcgill.ca")
# id = "260194225"
# BODY <- paste("See attached pdf for your randomly sampled latitudes and longitudes")
# N.r <- length(recipient)
# renderMyDocument(email = "sahir.bhatnagar@mcgill.ca",
#                  id = "260194225",
#                  ind = 11:20)
#
# i = 1
# MIME = gmailr::mime(from="sahir.bhatnagar@gmail.com",
#                     to=recipient[i],
#                     subject="[Fall 2018 - EPIB-607-001 - Inferential Statistics]: In-class exercise on sampling distributions",
#                     body=BODY)
#
# att <- attach_file(mime = MIME, filename = sprintf("exercises/water/%s_water_exercise_epib607.pdf", id))
# MIME$body
# send_message(att)
#
# msg_body <- print(xtable(mtcars), type="html")
#
# msg <-
#   mime() %>%
#   to(recipient[i]) %>%
#   from("sahir.bhatnagar@gmail.com") %>%
#   html_body(BODY) %>%
#   attach_part(BODY) %>%
#   attach_file(sprintf("exercises/water/%s_water_exercise_epib607.pdf", id))
#
# send_message(msg)
