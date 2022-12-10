# We can use the print() function
print("Hello World!")
# Quotes can be suppressed in the output
print("Hello World!", quote = FALSE)
# If there are more than 1 item, we can concatenate using paste()
print(paste("How","are","you?"))

x <- 1:5
y <- 6:10
z <- seq(from = 1, to = 4, by = .6)
print(x)
print(y)
print(z)
z <- x + y
print(z)

set.seed(7)
z <- sample(z)
print(z)
z <- sample(z, size = 7, replace = TRUE)
print(z)


cat("============ 1 ============\n")


data <- data.frame(x1 = 11:20, x2 = letters[1:10])
print(data)
subset_data <- data[sample(1:nrow(data), size = 3), ]
print(subset_data)


cat("============ 2 ============\n")


list <- list(1:3,
             753,
             c("A", "XXX", "Hello"),
             "YYY",
             5)
print(list)
cat("----------- continue -----------\n")
subset_list <- list[sample(1:length(list), size = 3)]
print(subset_list)


cat("============ 3 ============\n")


total <- sum(0:9)
print(total)

letter <- append(LETTERS[1:13],letters[14:26])
print(letter)
outcome <- c(1,6,4,9)*2
print(outcome)
something <- c(1,4,letters[2])  # indices start at one, you get (1,4,"b")
print(something)
len <- length(something)
print(len)


cat("============ 4 ============\n")

