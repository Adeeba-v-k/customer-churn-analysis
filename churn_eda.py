import pandas as pd 
import numpy as np

data = pd.read_excel("Telco-Customer-Churn.xlsx")
print(data.head())

print(data.shape)

print(data.columns)


data.info()

print(data.isnull().sum())

data["TotalCharges"] = pd.to_numeric(data["TotalCharges"], errors="coerce")
data.info()

print(data.head())

print("dupicate = ",data.duplicated().sum())

import seaborn as sns
import matplotlib.pyplot as plt

sns.countplot(x='Churn', data=data)
plt.title("Churn Distribution")
plt.show()

sns.countplot(x='Contract', hue='Churn', data=data)
plt.title("Churn by Contract")
plt.show()

sns.boxplot(x='Churn', y='MonthlyCharges', data=data)
plt.title("Monthly Charges vs Churn")
plt.show()

sns.boxplot(x='Churn', y='tenure', data=data)
plt.title("Tenure vs Churn")
plt.show()


data.to_csv("churn_cleaned.csv", index=False)