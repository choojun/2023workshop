rm(list = ls())
#In this version, learning rate and neighborhood are constant
#Step 1: insert input
X <- matrix(data = c(1, 1, 1, 2, 1, 3, 2, 1, 2, 2, 2, 3, 3, 1, 3, 2, 3, 3),
    nrow = 9, ncol = 2, byrow = TRUE)

#Step 2: initialize weights
Nodes  = matrix(data = c(-0.45, 0.1, 0.18, 0.55, 0.65, -0.12, 0.2, -0.35, 0.3, 0.07, 0.15, -0.20, -0.02, -0.05, -0.25, -0.08, 0.44, 0.45), 
    nrow = 9, ncol = 2, byrow = TRUE)
alpha  <- 0.2
radius <- 2

#list all neighbourhood scores from the location of a winning node
N1 <- matrix(data = c(0, 1, 2, 1, 1, 2, 2, 2, 2),
    nrow = 3, ncol = 3, byrow = TRUE)
N2 <- matrix(data = c(1, 1, 2, 0, 1, 2, 1, 1, 2),
    nrow = 3, ncol = 3, byrow = TRUE)
N3 <- matrix(data = c(2, 2, 2, 1, 1, 2, 0, 1, 2),
    nrow = 3, ncol = 3, byrow = TRUE)
N4 <- matrix(data = c(1, 0, 1, 1, 1, 1, 2, 2, 2),
    nrow = 3, ncol = 3, byrow = TRUE)
N5 <- matrix(data = c(1, 1, 1, 1, 0, 1, 1, 1, 1),
    nrow = 3, ncol = 3, byrow = TRUE)
N6 <- matrix(data = c(2, 2, 2, 1, 1, 1, 1, 0, 1),
    nrow = 3, ncol = 3, byrow = TRUE)
N7 <- matrix(data = c(2, 1, 0, 2, 1, 1, 2, 2, 2),
    nrow = 3, ncol = 3, byrow = TRUE)
N8 <- matrix(data = c(2, 1, 1, 2, 1, 0, 2, 1, 1),
    nrow = 3, ncol = 3, byrow = TRUE)
N9 <- matrix(data = c(2, 2, 2, 2, 1, 1, 2, 1, 0),
    nrow = 3, ncol = 3, byrow = TRUE)

N <- array(0, dim = c(3, 3, 9))
N[, , 1] <- N1
N[, , 2] <- N2
N[, , 3] <- N3
N[, , 4] <- N4
N[, , 5] <- N5
N[, , 6] <- N6
N[, , 7] <- N7
N[, , 8] <- N8
N[, , 9] <- N9

print_oldW <- Nodes
for (i in 1:nrow(X)){
  #array(0, dim=c(3,3,9)) E_distance = sum((ones(size(Nodes,1),1)*X(i,:)- Nodes).^2,2).^(0.5);
  dist_col_sum <- apply(((array(1, dim=c(nrow(Nodes),1))) %*% X[i,] -  Nodes)^2, 1, sum)
  E_distance <- dist_col_sum^0.5

  #Step 4: find winner node
  z <- max(E_distance)
  id <- which(E_distance == z)

  #Determine neighborhood
  Nb <- N[, , id]

  #Step 5:update weights
  for (j in 1:nrow(Nodes)){
    if (Nb[j] <= radius) {
      Nodes[j, ] <- Nodes[j, ] + alpha * (X[i, ] - Nodes[j, ])
    }
}
}

print_newW <- Nodes


cat("%%%%%%%%%%%%%%%%%\n",
    file = "self_organizing_map_outout.txt", append = FALSE)
cat("%% Print output\n",
    file = "self_organizing_map_outout.txt", append = TRUE)
cat("%%%%%%%%%%%%%%%%%\n",
    file = "self_organizing_map_outout.txt", append = TRUE)
cat("-------------------------------------------\n",
    file = "self_organizing_map_outout.txt", append = TRUE)
cat(c("NodeID", "\t", "Old_Weight", "\t", "New_Weight", "\t\n"),
    file = "self_organizing_map_outout.txt", append = TRUE)
for (i in 1:nrow(Nodes)){
  cat(c(i, "\t", t(print_oldW[i,]), "\t", print_newW[i, ], "\t\n"),
    file = "self_organizing_map_outout.txt", append = TRUE)
}