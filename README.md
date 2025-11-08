# Data-Anayltics-Dash-Board-
Works to collect data for revenue, customers, and products, and it can be displayed visually through PowerBI/Tableau

#  Sales Analytics Dashboard (SQL Project)

Hey, I’m **Sohib Charkaoui**, and this is a quick but solid **Sales Analytics Dashboard** I built using MySQL.  
It’s one of those plug-and-play projects — you can literally drop it into your SQL environment, run it, and get instant insights.

---

##  About This Project

This database tracks sales, products, and customer info so we can analyze business performance — kinda like a mini-data-science setup.  
It’s clean, simple, and universal — anyone can plug in their own data to test it.

**Database name:** `SalesAnalyticsDB`  
**Tables:**
- `products` → item info (category, price, etc.)  
- `customers` → who’s buying  
- `sales` → transactions (region, quantity, price, etc.)

---

##  What You Can Do With It

I added a bunch of analytical queries to play around with:
- **Total Revenue** overall and by region  
-  **Top 5 Selling Products**  
-  **Average Spending per Customer**  
-  **Monthly Sales Trends**  
-  **Month-Over-Month Revenue Growth** using `LAG()` (fancy data-science stuff)  
- **Category Performance & Average Order Value**

---

##  How to Run It

1. Open MySQL Workbench (or any MySQL 8+ environment).  
2. Copy the script from `CharkaouiSalesAnaylticsDashBoard.sql`.  
3. Run it all — it’ll create the DB, insert sample data, and print out the analytics.  
4. If you wanna test your own data, scroll to the **template section** in the script and just add your own `INSERT` lines.

---

##  Skills Shown

- SQL database design (relationships, foreign keys)  
- Analytical queries (SUM, AVG, GROUP BY, HAVING)  
- Window functions (`LAG()`) for time-based trends  
- Clean schema design for real-world data analytics  

---

##  Notes

This was built to look like something a real business analyst or data scientist would use for tracking KPIs.  
You can expand it later by connecting it to **Python (Pandas)** or **Power BI/Tableau** for visualization.  
For now though, it’s a standalone SQL project — clean, simple, and recruiter-friendly.  

---

## Contact

**Sohib Charkaoui**  
Data-focused IT Student @ UMass Boston 
