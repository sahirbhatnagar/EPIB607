#' Function to get landed in water or not and depths given an index vector this
#' function does not require external packages
#' @param sampling_factor this factor is multiplied by the number of depths
#'   needed to ensure enough rows have been sampled to get depths < 0. Only used
#'   when type="depth"
#' @param start_sampling_from what row to start sampling from. Default is 84
#'   students, and 20 + 5 samples per have already been used
#' @param index vector of indices provided to each student
#' @param student_id student id number used to set the seed when more samples
#'   are needed for type="depth"
#' @examples automate_water_task(1:50, student_id = 222333444, type = "depth")


automate_water_task <- function(index, student_id, type = c("water", "depth"),
                                start_sampling_from = 94 * 25 + 1,
                                sampling_factor = 10) {
  type <- match.arg(type)
  sample_size <- length(index)

  allLocations <- read.csv("https://raw.githubusercontent.com/sahirbhatnagar/epib607/master/inst/labs/003-ocean-depths/earth-locations-20180914.csv")
  # allLocations <- read.csv("~/git_repositories/EPIB607/labs/003-ocean-depths/earth-locations-20180914.csv")
  allLocations$water <- 1 * (allLocations$alt < 0)

  subset_locations <- allLocations[index, , drop = FALSE]

  if (type == "water") return(subset_locations$water)

  if (type == "depth") {

    subset_locations_water <- subset_locations[subset_locations$water == 1, , drop = FALSE]
    n.R.water <- nrow(subset_locations_water)
    n.R.needed <- sample_size - n.R.water

    set.seed(student_id)
    while (n.R.water < sample_size) {
      sampled_ind <- base::sample(start_sampling_from:nrow(allLocations),
                                  size = n.R.needed * sampling_factor)
      sampled_locations <- allLocations[sampled_ind, , drop = FALSE]
      newly_sampled <- sampled_locations[sampled_locations$water == 1, , drop = FALSE][1:(min(n.R.needed,nrow(sampled_locations[sampled_locations$water == 1, , drop = FALSE]))), , drop = FALSE]
      subset_locations_water <- rbind(subset_locations_water, newly_sampled)
      n.R.water <- nrow(subset_locations_water)
    }

    if (any(subset_locations_water$alt * -1 < 0)) warning("Some depths are negative. Try increasing sampling_factor.")
    subset_locations_water$alt <- subset_locations_water$alt * -1
    return(subset_locations_water)
  }
}



