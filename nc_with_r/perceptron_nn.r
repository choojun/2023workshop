rm(list=ls())
#bias inclusive, first element
X <- matrix(data = c(-1, 0.1, 0.8, -1, 0.2, 0.7, -1, 0.6, 0.2, -1, 0.7, 0.1),
  nrow = 4, ncol = 3, byrow = TRUE)
X <- t(X)
#class
d <- c(1, 1, 0, 0)
#Initial weight
w <- matrix(data = c(0.1, 0.2, -0.1), nrow = 3, ncol = 1)

tot_e <- 0
print_i <- {}
print_wold <- {}
print_net <- {}
print_y <- {}
print_e <- {}
print_wnew <- {}
print_tot_e <- {}

while(1){
  for (i in 1:nrow(X)) {
    print_i[i] <- i
    print_wold <- w

    #Step 1 - Compute activation level
    net <- t(w) %*% (X[, i])

    #Step 2 - Make prediction
    if (net < 0) {
        y <- 0
        }
    else {
        y <- 1
        }
    print_net[i] <- net
    print_y[i]   <- y

    #Step 3 - Calculate error
    e <- d[i] - y
    print_e[i] <- e
    tot_e <- abs(e) + tot_e
    print_tot_e[i] <- tot_e

    #Step 4 - Update weight
    w <- w + e * X[, i]
    print_wnew <- cbind(print_wnew, w)
  }
  if (tot_e == 0) {
    #Terminate
    break
    }
  else{
    tot_e <- 0 #A new cycle
    print_wnew <- {}
  }
}

cat("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n", file = "perceptron_out.txt",
    append = FALSE)
cat("%%  Ouput on an Excel sheet\n", file = "perceptron_out.txt", append = TRUE)
cat("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n", file = "perceptron_out.txt",
    append = TRUE)
cat("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n",
    file = "perceptron_out.txt", append = TRUE)
cat(c("Input No", "\t", "X", "\t", "w(old)", "\t", "net", "\t", "y", "\t",
    "error", "\t", "w(new)", "\t\n"), file = "perceptron_out.txt",
    append = TRUE)
for (i in 1:nrow(X)){
  cat(c(print_i[i], "\t", t(X[, i]), "\t", t(print_wold[i]), "\t", print_net[i],
  "\t", print_y[i], "\t", print_e[i], "\t", t(print_wnew[, i]), "\t\n"),
  file = "perceptron_out.txt", append = TRUE)
}