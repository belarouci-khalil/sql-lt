1. Write a query that returns the number of records in the City table.
2. Write a query that returns the plans—their names and prices—from the Plan table that include an internet data plan. Extend the result set with: the internet data plan name; the included data allowance in MB; the internet data plan price; the corresponding mobile network operator name. Use information from the InternetDataPlan and MobileNetworkOperator tables.
3. Write a query that returns all mobile network operators—their names—and the plans they offer—their names and prices—that include at least 100 free minutes for calls within the Lithuanian network.
4. Write a query that returns a summary showing the number of users in each city.
5. Write a query that returns the cities with no users.
6. Write queries that calculate the average number of users per city: excluding cities with no users; including cities with no users.
7. Write a query that returns the name of the operator offering the largest number of plans. If several operators offer the same maximum number of plans, return all of them.
8. Write a query that returns a list of people who subscribed to any plan between January 3, 2025 and January 10, 2025, inclusive. The result must include: the person’s first name; the person’s last name; the plan name; the contract start date.
9. Write a query that calculates the average price of the plans offered by each operator. The result must include: the operator name; the average plan price. Sort the results by the average price in descending order.
10. Write a query that determines how many additional services are provided by each operator. The result must include: the operator name; the number of additional services.
11. Write a query that determines which additional services are provided by the mobile network operator TELE2. The query must return the additional service name and price.
12. Write a query that returns the additional services offered by all mobile network operators. The query must return the operator name, additional service name, and price.
13. Write a query that returns the number of countries belonging to each zone.
14. Write a query that returns the name of the operator offering the most expensive calls to Mexico.
15. Write a query that finds the internet data plan that is not included in any mobile plan and has the lowest price per 1 MB. The query must return the operator name, internet data plan name, and price per 1 MB.
16. Write a query that returns the percentage distribution of subscribers among mobile network operators.
17. Write a query that returns the three most popular mobile plans among subscribers. If several plans have the same number of subscribers at the cut-off point, return all tied plans. The query must return the plan name and number of subscribers.
18. Write a query that returns information about ten randomly selected subscribers. The result must include: full name; city; phone number; contract start date; contract end date; operator name; plan name; an indicator showing whether an additional internet data plan has been ordered; an indicator showing whether any additional services have been ordered.
19. Write a query that returns the top five subscribers by the number of calls made within Lithuania during October 2025.
20. Write a query that determines the most popular foreign country based on the number of calls made to that country. If several countries are equally popular, return all of them.
21. In the Subscriber table, add a new column named discount with the data type DECIMAL(3,2), the NOT NULL constraint, and a default value of 0.00.
22. In the Person table, add a new column named email with the data type VARCHAR(50). This column must allow NULL values.
23. Create a new table named Domain with the following columns: domainID – INT, with the IDENTITY property; domainName – VARCHAR(15).
24. Insert the following records into the Domain table: gmail.com, yahoo.com, hotmail.com, and eif.viko.lt.
25. Update the records in the Person table by assigning an email address to each person. The email address must follow this format: firstname.lastname@domain. The domain must be randomly selected from the Domain table.
26. Create a new table named MobilePhone with the following columns: mobTelID – INT; manufacturer – VARCHAR(15); model – VARCHAR(30); price – FLOAT; monthlyPrice – FLOAT. The mobTelID column must use the IDENTITY property.
27. In the Subscriber table, add a new column named mobTelID with the data type INT. Remember that not all subscribers purchase a mobile phone together with their mobile plan.
28. Create a foreign key relationship between the mobTelID column in the Subscriber table and the mobTelID column in the MobilePhone table.