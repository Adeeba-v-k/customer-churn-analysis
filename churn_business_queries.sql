
Setting environment for using XAMPP for Windows.
hp@DESKTOP-38HVUM2 c:\xampp
# Mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 8
Server version: 10.4.32-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.


MariaDB [(none)]> use project;
Database changed
MariaDB [project]> SELECT *
    -> FROM churn_data
    -> LIMIT 5;
+------------+--------+---------------+---------+------------+--------+--------------+------------------+-----------------+----------------+--------------+------------------+-------------+-------------+-----------------+----------------+------------------+---------------------------+----------------+--------------+-------+
| customerID | gender | SeniorCitizen | Partner | Dependents | tenure | PhoneService | MultipleLines    | InternetService | OnlineSecurity | OnlineBackup | DeviceProtection | TechSupport | StreamingTV | StreamingMovies | Contract       | PaperlessBilling | PaymentMethod             | MonthlyCharges | TotalCharges | Churn |
+------------+--------+---------------+---------+------------+--------+--------------+------------------+-----------------+----------------+--------------+------------------+-------------+-------------+-----------------+----------------+------------------+---------------------------+----------------+--------------+-------+
| 7590-VHVEG | Female |             0 | Yes     | No         |      1 | No           | No phone service | DSL             | No             | Yes          | No               | No          | No          | No              | Month-to-month | Ye   |           | Electronic check          |          29.85 |        29.85 | No
| 5575-GNVDE | Male   |             0 | No      | No         |     34 | Yes          | No               | DSL             | Yes            | No           | Yes              | No          | No          | No              | One year       | No   |           | Mailed check              |          56.95 |       1889.5 | No
| 3668-QPYBK | Male   |             0 | No      | No         |      2 | Yes          | No               | DSL             | Yes            | Yes          | No               | No          | No          | No              | Month-to-month | Ye  |            | Mailed check              |          53.85 |       108.15 | Yes
| 7795-CFOCW | Male   |             0 | No      | No         |     45 | No           | No phone service | DSL             | Yes            | No           | Yes              | Yes         | No          | No              | One year       | No   |           | Bank transfer (automatic) |           42.3 |      1840.75 | No
| 9237-HQITU | Female |             0 | No      | No         |      2 | Yes          | No               | Fiber optic     | No             | No           | No               | No          | No          | No              | Month-to-month | Ye  |            | Electronic check          |           70.7 |       151.65 | Yes
+------------+--------+---------------+---------+------------+--------+--------------+------------------+-----------------+----------------+--------------+------------------+-------------+-------------+-----------------+----------------+------------------+---------------------------+----------------+--------------+-------+
5 rows in set (0.006 sec)

MariaDB [project]>
MariaDB [project]> SELECT ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS churn_rate FROM churn_data;
+------------+
| churn_rate |
+------------+
|       0.00 |
+------------+
1 row in set (0.008 sec)


MariaDB [project]> SELECT DISTINCT Churn, LENGTH(Churn) FROM churn_data;
+-------+---------------+
| Churn | LENGTH(Churn) |
+-------+---------------+
   |             3 |
  |             4 |
+-------+---------------+
2 rows in set (0.013 sec)

MariaDB [project]> UPDATE churn_data
    -> SET Churn = TRIM(Churn);
Query OK, 0 rows affected (0.020 sec)
Rows matched: 7043  Changed: 0  Warnings: 0

MariaDB [project]> SELECT DISTINCT Churn, HEX(Churn)
    -> FROM churn_data;
+-------+------------+
| Churn | HEX(Churn) |
+-------+------------+
   | 4E6F0D     |
  | 5965730D   |
+-------+------------+
2 rows in set (0.023 sec)

MariaDB [project]> UPDATE churn_data SET Churn = REPLACE(Churn, '\r', '');
Query OK, 7043 rows affected (0.233 sec)
Rows matched: 7043  Changed: 7043  Warnings: 0

MariaDB [project]> SELECT DISTINCT Churn, HEX(Churn) FROM churn_data;
+-------+------------+
| Churn | HEX(Churn) |
+-------+------------+
| No    | 4E6F       |
| Yes   | 596573     |
+-------+------------+
2 rows in set (0.015 sec)

MariaDB [project]> SELECT Churn, COUNT(*) AS customers FROM churn_data GROUP BY Churn;
+-------+-----------+
| Churn | customers |
+-------+-----------+
| No    |      5174 |
| Yes   |      1869 |
+-------+-----------+
2 rows in set (0.016 sec)


MariaDB [project]> SELECT ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS churn_rate FROM churn_data;
+------------+
| churn_rate |
+------------+
|      26.54 |
+------------+
1 row in set (0.007 sec)

MariaDB [project]> SELECT Contract, COUNT(*) AS customers FROM churn_data GROUP BY Contract;
+----------------+-----------+
| Contract       | customers |
+----------------+-----------+
| Month-to-month |      3875 |
| One year       |      1473 |
| Two year       |      1695 |
+----------------+-----------+
3 rows in set (0.021 sec)


MariaDB [project]> SELECT Churn, AVG(MonthlyCharges) AS avg_monthly_charges FROM churn_data GROUP BY Churn;
+-------+---------------------+
| Churn | avg_monthly_charges |
+-------+---------------------+
| No    |   61.26512372083631 |
| Yes   |   74.44133227059011 |
+-------+---------------------+
2 rows in set (0.011 sec)

MariaDB [project]> SELECT PaymentMethod,COUNT(*) AS churn_customers FROM churn_data
    -> WHERE Churn = 'Yes' GROUP BY PaymentMethod ORDER BY churn_customers DESC;
+---------------------------+-----------------+
| PaymentMethod             | churn_customers |
+---------------------------+-----------------+
| Electronic check          |            1071 |
| Mailed check              |             308 |
| Bank transfer (automatic) |             258 |
| Credit card (automatic)   |             232 |
+---------------------------+-----------------+
4 rows in set (0.013 sec)

MariaDB [project]> SELECT Churn,AVG(tenure) AS avg_tenure FROM churn_data GROUP BY Churn;
+-------+------------+
| Churn | avg_tenure |
+-------+------------+
| No    |    37.5700 |
| Yes   |    17.9791 |
+-------+------------+
2 rows in set (0.016 sec)

MariaDB [project]>
