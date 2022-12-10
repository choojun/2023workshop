library(caret)

filename <- "iris.csv"
# load the CSV file from the local directory
dataset <- read.csv(filename, header=TRUE)
# set the column names in the dataset
colnames(dataset) <- c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width","Species")

# Split Data into Training and Testing randomly
sample_size = floor(0.8*nrow(dataset))
set.seed(7)
picked = sample(seq_len(nrow(dataset)), size = sample_size)
dataset = dataset[picked,]
validation = dataset[-picked,]


cat("------------ data is splitted into two randomly\n")

# dimensions of dataset
dim(dataset)
cat("------------ dimensions of dataset\n")
# list types for each attribute
sapply(dataset, class)
cat("------------ list types for each attribute\n")
# take a peek at the first 5 rows of the data
head(dataset)
cat("------------ first 5 rows of the data\n")
# list the levels for the class
levels(dataset$Species)
cat("------------ list the levels for the class\n")
# summarize the class distribution
percentage <- prop.table(table(dataset$Species)) * 100
cbind(freq=table(dataset$Species), percentage=percentage)
cat("------------ summarize the class distribution\n")
# summarize attribute distributions
summary(dataset)
cat("------------ summarize attribute distributions\n")

# split input and output
x <- dataset[,1:4]
y <- dataset[,5]
# boxplot for each attribute on one image
par(mfrow=c(1,4))
  for(i in 1:4) {
    png(paste("feature", c(names(iris)[i]), ".png"))
    boxplot(x[,i], main=names(iris)[i])
    dev.off()
}
cat("------------ boxplot for each attribute on png: feature*.png\n")

# barplot for class breakdown
#windows();plot(y)
# scatterplot matrix
#featurePlot(x=x, y=y, plot="ellipse")
# box and whisker plots for each attribute
#featurePlot(x=x, y=y, plot="box")
# density plots for each attribute by class value
#scales <- list(x=list(relation="free"), y=list(relation="free"))
#featurePlot(x=x, y=y, plot="density", scales=scales)


# Run algorithms using 10-fold cross validation
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"
# LDA - linear algorithms
set.seed(7)
fit.lda <- train(Species~., data=dataset, method="lda", metric=metric, trControl=control)
# CART - nonlinear algorithms
set.seed(7)
fit.cart <- train(Species~., data=dataset, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(Species~., data=dataset, method="knn", metric=metric, trControl=control)
# SVM
set.seed(7)
fit.svm <- train(Species~., data=dataset, method="svmRadial", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(Species~., data=dataset, method="rf", metric=metric, trControl=control)
cat("------------ Run algorithms using 10-fold cross validation\n")



# summarize accuracy of models
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)
cat("------------ summarize accuracy of models\n")

# compare accuracy of models
png("result.png")
dotplot(results)
dev.off()
cat("------------ compare accuracy of models: result.png\n")

# summarize best model
print(fit.lda)
cat("------------ summarize best model\n")


# The LDA was the most accurate model. Now we want to get an idea of the accuracy of the model on our validation set. This will give us an independent final check on the accuracy of the best model. It is valuable to keep a validation set just in case you made a slip during such as overfitting to the training set or a data leak. Both will result in an overly optimistic result.
# We can run the LDA model directly on the validation set and summarize the results in a confusion matrix.

# estimate skill of LDA on the validation dataset
predictions <- predict(fit.lda, validation)
confusionMatrix(predictions, as.factor(validation$Species))
cat("------------ estimate skill of LDA on the validation dataset\n")

# We can see that the accuracy is 100%. It was a small validation dataset (20%), but this result is within our expected margin of 97% +/-4% suggesting we may have an accurate and a reliably accurate model.
