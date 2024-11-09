# Titanic Dataset Machine Learning Model Comparison

This project compares multiple machine learning models on the Titanic dataset to predict passenger survival. Using R language, it evaluates model performance based on accuracy, precision, recall, F1 score, and error rate.

## Table of Contents
1. [Dataset Description](#dataset-description)
2. [Preprocessing Steps](#preprocessing-steps)
3. [Algorithms Used](#algorithms-used)
4. [Results](#results)
5. [Installation](#installation)
6. [Usage](#usage)
7. [Contributing](#contributing)

## Dataset Description
This project uses the [Titanic dataset](https://www.kaggle.com/c/titanic/data) with 891 entries and 12 columns. The dataset provides information about passengers on the Titanic, including demographics, family relationships, and ticket details. Below are the key features:

- **PassengerId**: Unique identifier for each passenger
- **Survived**: Survival status (0 = No, 1 = Yes)
- **Pclass**: Ticket class (1 = 1st, 2 = 2nd, 3 = 3rd)
- **Name**: Full name of the passenger
- **Sex**: Gender of the passenger
- **Age**: Age of the passenger, with some missing values filled during preprocessing
- **SibSp**: Number of siblings or spouses aboard
- **Parch**: Number of parents or children aboard
- **Ticket**: Ticket number
- **Fare**: Passenger fare
- **Cabin**: Cabin number (mostly missing data)
- **Embarked**: Port of Embarkation (C = Cherbourg; Q = Queenstown; S = Southampton)

The dataset contains missing values in `Age`, `Cabin`, and `Embarked`, which are handled in the preprocessing step.

## Preprocessing Steps
1. **Handling Missing Values**:
   - Replaced missing `Age` values with the mean age.
   - Filled missing `Embarked` values with the most common port (`S`).
2. **Feature Engineering**:
   - Converted categorical variables (`Survived`, `Pclass`, `Sex`, and `Embarked`) into factors.
3. **Data Splitting**:
   - Split the dataset into training (80%) and testing (20%) sets.

## Algorithms Used
The following machine learning algorithms were implemented and evaluated:
1. **Decision Tree**
2. **K-Nearest Neighbors (KNN)**
3. **Support Vector Machine (SVM)**
4. **Random Forest**

## Results
The models' performances were evaluated based on accuracy, precision, recall, F1 score, and error rate. Below are the results:

| Model                  | Accuracy | Precision | Recall  | F1 Score | Error Rate |
|------------------------|----------|-----------|---------|----------|------------|
| Decision Tree          | 0.7797   | 0.7966    | 0.8624  | 0.8282   | 0.2203     |
| K-Nearest Neighbors    | 0.6441   | 0.7018    | 0.7339  | 0.7175   | 0.3559     |
| Support Vector Machine | 0.8023   | 0.8136    | 0.8807  | 0.8458   | 0.1977     |
| Random Forest          | 0.8079   | 0.8151    | 0.8899  | 0.8509   | 0.1921     |

## Installation
1. Ensure you have [R](https://cran.r-project.org/) and [RStudio](https://www.rstudio.com/) installed.
2. Install necessary R packages using the commands:
   ```R
   install.packages(c("caret", "e1071", "class", "rpart", "randomForest", "reshape2", "ggplot2", "dplyr"))
   ```

## Usage
1. Clone this repository:
   ```bash
   git clone https://github.com/Obaydul201/Comparative-Machine-Learning-Algorithms-Using-Titanic-Dataset.git
   ```
2. Open the R script and run it in RStudio or any compatible R environment.
3. Select the Titanic dataset CSV file when prompted.
4. View the results in the console and the graphical comparison of model metrics.

## Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m 'Add feature'
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.