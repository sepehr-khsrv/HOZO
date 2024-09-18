
test_that('Hozo works for typical input', {
  result <- Hozo(median = 10, minimum = 5, maximum = 15, sample_size = 30)
  expect_equal(result$mean, 10)
  expect_equal(result$sd, (15 - 5) / 4)
  expect_equal(result$variance, result$sd^2)
})

test_that('Hozo handles small sample size', {
  expect_warning(result <- Hozo(median = 50, minimum = 40, maximum = 60, sample_size = 3),
                 'unreliable')
  expect_true(is.list(result))
})

test_that('Hozo returns zero variance for equal min and max', {
  result <- Hozo(median = 20, minimum = 20, maximum = 20, sample_size = 10)
  expect_equal(result$sd, 0)
  expect_equal(result$variance, 0)
})

test_that('Hozo handles invalid input', {
  expect_error(Hozo(median = 10, minimum = 15, maximum = 20, sample_size = 30),
               'minimum value cannot be greater than the median')
  expect_error(Hozo(median = 20, minimum = 10, maximum = 15, sample_size = 30),
               'maximum value cannot be less than the median')
})

