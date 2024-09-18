
#' Estimate Statistical Parameters from Limited Data
#'
#' This function estimates the mean, standard deviation, and variance from the given median, minimum, maximum, and sample size using established statistical methods.
#'
#' The function provides an approximation of the sample's mean, standard deviation, and variance when only the median, minimum, maximum, and sample size are known.
#'
#' @param median A numeric value representing the median of the sample.
#' @param minimum A numeric value representing the minimum observed value in the sample.
#' @param maximum A numeric value representing the maximum observed value in the sample.
#' @param sample_size A positive numeric value representing the size of the sample.
#'
#' @details
#' - For larger sample sizes, the mean is assumed to be equal to the median.
#' - For smaller sample sizes, adjustments are made to the mean using the minimum, maximum, and sample size.
#' - The standard deviation is calculated differently depending on the sample size, with more reliable estimates for larger samples.
#'
#' If the minimum and maximum are equal, the function assumes no variability in the data, returning a standard deviation and variance of zero.
#'
#' @return A list with three named elements:
#' * \code{mean}: The estimated mean of the sample.
#' * \code{sd}: The estimated standard deviation of the sample.
#' * \code{variance}: The estimated variance of the sample, calculated as the square of the standard deviation.
#'
#' @seealso \link[stats]{median}, \link[stats]{sd}, \link[stats]{var}
#'
#' @references
#' Hozo, S. P., Djulbegovic, B., & Hozo, I. (2005). Estimating the mean and variance from the median, range, and the size of a sample. *BMC Medical Research Methodology*, 5(13).
#'
#' @examples
#' # A typical case with median 10, minimum 5, maximum 15, and sample size 30
#' estimate_stats(median = 10, minimum = 5, maximum = 15, sample_size = 30)
#'
#' # Edge case where minimum equals maximum
#' estimate_stats(median = 20, minimum = 20, maximum = 20, sample_size = 10)
#'
#' @export



estimate_stats <- function(median, minimum, maximum, sample_size) {
  # Validate inputs

  # Check if sample_size is numeric and positive
  if (!is.numeric(sample_size)) {
    stop('Sample size must be a numeric value.', call. = FALSE)
  }
  if (sample_size <= 0) {
    stop('Sample size must be a positive numeric value greater than 0.', call. = FALSE)
  }

  # Check if median, minimum, and maximum are numeric
  if (!is.numeric(median)) {
    stop('The median must be a numeric value. Please ensure that the median is a number.', call. = FALSE)
  }
  if (!is.numeric(minimum)) {
    stop('The minimum value must be numeric. Please ensure that the minimum is a number.', call. = FALSE)
  }
  if (!is.numeric(maximum)) {
    stop('The maximum value must be numeric. Please ensure that the maximum is a number.', call. = FALSE)
  }

  # Check logical consistency of minimum, median, and maximum
  if (minimum > median) {
    stop('The minimum value cannot be greater than the median. Please check your input values.', call. = FALSE)
  }
  if (maximum < median) {
    stop('The maximum value cannot be less than the median. Please check your input values.', call. = FALSE)
  }
  if (minimum > maximum) {
    stop('The minimum value cannot be greater than the maximum value. Please check your input values.', call. = FALSE)
  }

  # Provide a suggestion if sample size is very small
  if (sample_size < 5) {
    warning('The sample size is very small. Estimates might be unreliable. Consider increasing the sample size for better accuracy.')
  }

  # Handle edge case where minimum == maximum
  if (minimum == maximum) {
    warning('Minimum and maximum are equal, implying no variability in the data. Standard deviation and variance will be zero.')
    estimated_mean <- median  # Set the mean to the median in this case
    estimated_sd <- 0
    estimated_variance <- 0
  } else {
    # Mean estimation
    estimated_mean <- if (sample_size > 25) {
      median
    } else {
      weighted_median <- 0.5 * median + 0.5 * (minimum + maximum) / 2
      adjustment <- (minimum - 2 * median + maximum) / (4 * sample_size)
      weighted_median + adjustment
    }

    # Standard deviation estimation
    estimated_sd <- if (sample_size > 70) {
      (maximum - minimum) / 6
    } else if (sample_size > 15) {
      (maximum - minimum) / 4
    } else if (sample_size >= 5) {
      (maximum - minimum) / (2 + log(sample_size))
    } else {
      warning('Sample size too small to estimate standard deviation reliably. Standard deviation estimate set to NA.')
      estimated_sd <- NA
    }

    # Variance estimation
    estimated_variance <- if (!is.na(estimated_sd)) {
      estimated_sd^2
    } else {
      NA
    }
  }

  # Return a list containing the estimated statistics
  list(mean = estimated_mean, sd = estimated_sd, variance = estimated_variance)
}


