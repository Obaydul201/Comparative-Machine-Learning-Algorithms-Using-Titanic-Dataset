# Load the Titanic dataset
titanic_data <- read.csv(file.choose())  # Choose the Titanic CSV file
View(titanic_data)
str(titanic_data)

# Preprocess the data
# Handling missing values
titanic_data$Age[is.na(titanic_data$Age)] <- mean(titanic_data$Age, na.rm = TRUE)
titanic_data$Embarked[is.na(titanic_data$Embarked)] <- "S"  # Fill missing Embarked with "S"

# Convert categorical variables to factors
titanic_data$Survived <- factor(titanic_data$Survived)
titanic_data$Pclass <- factor(titanic_data$Pclass)
titanic_data$Sex <- factor(titanic_data$Sex)
titanic_data$Embarked <- factor(titanic_data$Embarked)

# Install and load caret for data partitioning
#install.packages("caret")
library(caret)

# Split the data into training and testing sets
set.seed(123)
train_index <- createDataPartition(titanic_data$Survived, p = 0.8, list = FALSE)
train_data <- titanic_data[train_index, ]
test_data <- titanic_data[-train_index, ]

# Ensure the levels of Embarked in test_data match train_data to prevent errors
test_data$Embarked <- factor(test_data$Embarked, levels = levels(train_data$Embarked))

# Separate features and labels
train_labels <- train_data$Survived
test_labels <- test_data$Survived

# Define a function to calculate metrics
#install.packages("e1071")
library(e1071)

#install.packages("caret")
library(caret)

calculate_metrics <- function(predictions, actual) {
  cm <- confusionMatrix(predictions, actual)
  accuracy <- cm$overall["Accuracy"]
  precision <- cm$byClass["Precision"]
  recall <- cm$byClass["Recall"]
  f1 <- cm$byClass["F1"]
  error_rate <- 1 - accuracy
  return(c(accuracy, precision, recall, f1, error_rate))
}

# Initialize results dataframe
results <- data.frame(Model = character(), Accuracy = numeric(), 
                      Precision = numeric(), Recall = numeric(), 
                      F1_Score = numeric(), Error_Rate = numeric())

# 1. Decision Tree
#install.packages("rpart")
library(rpart)

dt_model <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train_data, method = "class")
dt_pred <- predict(dt_model, test_data, type = "class")
metrics_dt <- calculate_metrics(dt_pred, test_labels)
results <- rbind(results, c("Decision Tree", metrics_dt))

# 2. K-Nearest Neighbors (KNN)
#install.packages("class")
library(class)

knn_pred <- knn(train = train_data[,c("Pclass", "Age", "SibSp", "Parch", "Fare")], 
                test = test_data[,c("Pclass", "Age", "SibSp", "Parch", "Fare")], 
                cl = train_labels, k = 5)
metrics_knn <- calculate_metrics(knn_pred, test_labels)
results <- rbind(results, c("K-Nearest Neighbors", metrics_knn))

# 3. Support Vector Machine (SVM)
svm_model <- svm(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train_data)
svm_pred <- predict(svm_model, test_data)
metrics_svm <- calculate_metrics(svm_pred, test_labels)
results <- rbind(results, c("Support Vector Machine", metrics_svm))

# 4. Random Forest
#install.packages("randomForest")
library(randomForest)

rf_model <- randomForest(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train_data)
rf_pred <- predict(rf_model, test_data)
metrics_rf <- calculate_metrics(rf_pred, test_labels)
results <- rbind(results, c("Random Forest", metrics_rf))

# Rename columns and convert results to numeric
colnames(results) <- c("Model", "Accuracy", "Precision", "Recall", "F1_Score", "Error_Rate")
results[, 2:6] <- lapply(results[, 2:6], as.numeric)

# Print final results
print(results)

# Visualize the results
#install.packages("reshape2")
library(reshape2)

results_long <- melt(results, id.vars = "Model", variable.name = "Metric", value.name = "Score")

#install.packages("ggplot2")
library(ggplot2)

ggplot(results_long, aes(x = Metric, y = Score, fill = Model)) + 
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Comparison of Model Performance on Titanic Dataset",
       x = "Metric",
       y = "Score") +
  scale_fill_brewer(palette = "Set1") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Identify the best algorithm based on each metric
#install.packages("dplyr")
library(dplyr)

best_by_metric <- results_long %>% 
  group_by(Metric) %>% 
  top_n(1, Score) %>% 
  arrange(desc(Metric))
print(best_by_metric)
