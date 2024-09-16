
# Example usage of estimate_stats function

# Test Case 1: A typical case with median 10, min 5, max 15, and sample size 30
result1 <- estimate_stats(median = 10, minimum = 5, maximum = 15, sample_size = 30)
print(result1)

# Test Case 2: Small sample size case
result2 <- estimate_stats(median = 50, minimum = 40, maximum = 60, sample_size = 3)
print(result2)

# Test Case 3: Large sample size case
result3 <- estimate_stats(median = 100, minimum = 90, maximum = 110, sample_size = 100)
print(result3)

# Test Case 4: Edge case where minimum equals maximum
result4 <- estimate_stats(median = 20, minimum = 20, maximum = 20, sample_size = 10)
print(result4)

# Test Case 5: A typical case with large range between min and max
result5 <- estimate_stats(median = 15, minimum = 10, maximum = 100, sample_size = 20)
print(result5)

# This should throw an error
tryCatch(
  estimate_stats(median = 10, minimum = 15, maximum = 20, sample_size = 30),
  error = function(e) print(e$message)
)

# Test Case: Maximum less than median
# This should throw an error
tryCatch(
  estimate_stats(median = 20, minimum = 10, maximum = 15, sample_size = 30),
  error = function(e) print(e$message)
)
# This should provide a warning and set sd/variance to 0
result_equal_min_max <- estimate_stats(median = 10, minimum = 10, maximum = 10, sample_size = 30)
print(result_equal_min_max)

# Test Case: Sample size of 1
# This should warn about unreliable estimates
result_small_sample <- estimate_stats(median = 10, minimum = 5, maximum = 15, sample_size = 1)
print(result_small_sample)



