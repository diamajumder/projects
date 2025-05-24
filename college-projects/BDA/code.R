library(readxl)
library(lmtest)
library(dplyr)
library(margins)
library(caret)
library(readr)


data <- read_csv("D:/dia/IIMT/Term 6/BDA_IR week/framingham.csv")
View(data)

set.seed(123)  
train_index <- createDataPartition(data$TenYearCHD, p = 0.8, list = FALSE, times = 1)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

#model_logit <- glm(TenYearCHD ~ male + age + education +currentSmoker + cigsPerDay + BPMeds +
#                prevalentStroke + prevalentHyp + diabetes + totChol + sysBP + diaBP + BMI +
#                heartRate + glucose, data = train_data, family = "binomial"(link = "logit"))

model_logit <- glm(TenYearCHD ~ male + age + cigsPerDay + sysBP +
                    glucose, data = train_data, family = "binomial"(link = "logit"))
summary(model_logit)

selected_data <- train_data[c("male", "age", "cigsPerDay", "sysBP", "glucose")]

cor <- cor(dplyr::select(train_data, male, age, cigsPerDay, sysBP, glucose), 
            use="pairwise.complete.obs")
print(cor)

#no multicollinearity

m_eff <- margins(model_logit)
summary(m_eff)


pred_class <- predict(model_logit,newdata = test_data)
pred_class1 <- ifelse(pred_class > 0.5, 1, 0)
table(predicted = pred_class1, actual = test_data$TenYearCHD)
confusion_matrix <- table(Predicted = pred_class1, Actual = test_data$TenYearCHD)
print(confusion_matrix)

true_pos <- confusion_matrix[2,2]
true_neg <- confusion_matrix[1,1]
false_pos <- confusion_matrix[2,1]
false_neg <- confusion_matrix[1,2]

accuracy <- (confusion_matrix[1,1]+confusion_matrix[2,2])/sum(confusion_matrix)
print(accuracy)

precision <- true_pos/(true_pos+false_pos)
print(precision)

recall <- true_pos/(true_pos+false_neg)
print(recall)
