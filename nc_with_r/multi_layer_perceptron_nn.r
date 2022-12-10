rm(list = ls())
#bias inclusive, first element
X <- matrix(data = c(-1, 0, 0, -1, 0, 1, -1, 1, 0, -1, 1, 1),
    nrow = 4, ncol = 3, byrow = TRUE)
X <- t(X)
#class; an XOR problem
d <- c(0, 1, 1, 0)

#Initial weights at the hidden layer
wH <- matrix(c(-1, -1, -1, 0.26, 0.402, 0.43, 0.38, -0.005, 0.085),
    nrow = 3, ncol = 3)
#Initial weights at the output layer
wO <- c(-0.25, 0.24, 0.05)
v <- {}
v[1]       <- -1 #bias
TSSE       <- 0
eta        <- 0.5 #learning rate
ethreshold <- 0.05
no_cycle   <- 0

print_k <- {}
print_X <- {}
# tot_e <- 0
# print_i = {}
# print_wold={}
# print_net ={}
# print_y = {}
# print_e = {}
# print_wnew = {}
# print_tot_e = {}
net_H <- {}
v <- {}
print_wHold <- {}
print_net_H <- {}
print_v <- {}
net_H[1] <- 0
v[1] <- -1
print_wHold <- array(0, dim = c(3, 3, nrow(X)))
net_O <- {}
y <- {}
print_net_O <- {}
print_y <- {}
net_O <- {}
delta_H <- {}
delta_H[1] <- 0
print_delta_O <- {}
print_delta_H <- {}
print_wOold <- {}
print_wOnew <- {}
print_wHnew <- {}
print_wHnew <- array(0, dim = c(3, 3, nrow(X)))

cat("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n",
    file = "multi_layer_perceptron_out.txt", append = FALSE)
cat("%%  Ouput on an Excel sheet\n",
    file = "multi_layer_perceptron_out.txt", append = TRUE)
cat("%%  show the outputs at the first, second and the last iteration only\n",
    file = "multi_layer_perceptron_out.txt", append = TRUE)
cat("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n",
    file = "multi_layer_perceptron_out.txt", append = TRUE)
cat("\n", file = "multi_layer_perceptron_out.txt", append = TRUE)

count <- 0
while(1){
  print_X <- {}
  print_net_H <- {}
  print_v <- {}
  print_delta_H <- {}
  print_wOold <- {}
  print_wOnew <- {}

  count <- count + 1
  print(count)
  for (k in 1:nrow(X)){

    #%%%%%%%%%%%%%%%%%%%%%
    #%    Propagation    %
    #%%%%%%%%%%%%%%%%%%%%%
    x <- X[, k]

    print_k[k] <- k
    print_X <- cbind(print_X, x)

    for (j in 2:nrow(wH)){
      #Step 3 - Compute net input at the hidden layer, the first node is a bias
      net_H[j] <- wH[,j] %*% x
      #Step 4 - Compute output at the hidden layer
      v[j] <- 1/(1+exp(-net_H[j]))
    }
    print_wHold[, , k] <- wH
    print_net_H <- rbind(print_net_H, net_H)
    print_v <- rbind(print_v, v)

    for (i in 1:ncol(as.matrix(wO))){
      #Step 5 - Compute net input at the output layer
      net_O[i] <- wO %*% v
      # Step 6 - Compute output at the output layer
      y[i] <- 1 / (1 + exp(-net_O[i]))
    }
    print_net_O[k] <- net_O
    print_y[k] <- y

    #Step 7 - Compute error at the output layer
    delta_O <- (d[k]-y)*y*(1-y)

    #Step 8 - Compute error at the hidden layer
    for (j in 2:nrow(wH)){   #j=1 is the bias node
      delta_H[j] <- wO[j] %*% delta_O * v[j] * (1 - v[j])
    }
    print_delta_O[k] <- delta_O
    print_delta_H <- rbind(print_delta_H, delta_H)
    print_wOold   <- rbind(print_wOold, wO)

    #%%%%%%%%%%%%%%%%%%%%%
    #%       Update      %
    #%%%%%%%%%%%%%%%%%%%%%
    #Step 9: Update weights of output layer
    for (j in 1:length(wO)){
      wO[j] <- wO[j] + eta * delta_O * v[j]
    }
    print_wOnew <- rbind(print_wOnew, wO)

    #Step 10: Update weights of hidden layer
    for (j in 1:nrow(wH)){
      for (l in 1:ncol(wH)){
        wH[j, l] <- wH[j,l]  + eta * delta_H[j] * x[l]
      }
    }
    print_wHnew[, , k] <- wH

    #Step 11: Update TSSE
    TSSE <- TSSE + (d[k] - y)^2
  }

  if (TSSE <= ethreshold) {
    terminate <- TRUE
  }else {
    TSSE <- 0
    terminate <- 0
    no_cycle <- no_cycle + 1
  }

  if ((no_cycle == 1) | (no_cycle == 2) | (no_cycle < 20) | terminate) {
    cat("%%%%%%%%%%%%%%%%%%%%%%%%\n",
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat("       %     Propagation\n",
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat("%%%%%%%%%%%%%%%%%%%%%%%%\n",
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat("\n", file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat(c("Iteration", "\t", "Input No", "\t", "X", "\t",
        "{Hidden Node1, Hidden Node2, Hidden Node3}", "\t\n"),
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat(c("\t\t\t", "Net[1,2,3]", "\t", "v[1,2,3]", "\t\n"),
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    for (i in 1:nrow(X)){
      cat(c(no_cycle, "\t", print_k[i], "\t", t(X[,i]), "\t", print_net_H[i,],
        "\t", print_v[i,], "\t\n"),
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    }
    cat('---------------------------------------------------------------------------------\n',
    file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat("\n", file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat(c("Output Node", "\t\t", "Error at Output Node", "\t",
        "Error at Hidden Nodes[1,2,3]", "\t\n"),
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat(c("ONet", "\t", "y", "\t\n"),
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    for (i in 1:nrow(X)){
      cat(c(print_net_O[i], "\t", print_y[i], "\t", print_delta_O[i],
        "\t", print_delta_H[i,], "\t\n"),
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    }
    cat('--------------------------------------------------------------------------------\n',
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat("\n", file = "multi_layer_perceptron_out.txt", append = TRUE)

    cat("%%%%%%%%%%%%%%%%%%%%%%%%%\n",
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat("%     Update\n",
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat('%%%%%%%%%%%%%%%%%%%%%%%%%\n',
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat(c("\t", "Iteration", "\t", "Output Weights", "\t\t",
        "{Hidden Node1, Hidden Node2, Hidden Node3}", "\t\n"),
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat(c("\t\t", "Old", "\t", "New", "\t", "Old", "\t", "New", "\t\n"),
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    for (i in 1:nrow(X)){
      cat(c("\t", no_cycle, "\t", print_wOold[i,], "\t", print_wOnew[i, ],
        "\t", print_wHold[, , i], "\t", print_wHnew[, , i], "\t\n"),
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    }
    cat('--------------------------------------------------------------------------------\n',
        file = "multi_layer_perceptron_out.txt", append = TRUE)
    cat("\n", file = "multi_layer_perceptron_out.txt", append = TRUE)
  }
  if (terminate) break
}