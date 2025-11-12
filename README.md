# 🛒 Retail Sales & Inventory Analytics Dashboard

![Retails Sales](https://img.shields.io/badge/Retails%20Sales-Analytics-green?logo=car&logoColor=white)
[![MySQL](https://img.shields.io/badge/MySQL-Database-orange?logo=mysql)](https://www.mysql.com/)
[![Power BI](https://img.shields.io/badge/PowerBI-Visualization-yellow?logo=powerbi)](https://powerbi.microsoft.com/)
[![VS Code](https://img.shields.io/badge/VSCode-Editor-0078d7?logo=visualstudiocode&logoColor=white)](https://code.visualstudio.com/)
![EDA](https://img.shields.io/badge/Focus-EDA%20%26%20BI%20Insights-green)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## 📑 Table of Contents

- [📌 Overview](#-overview)
- [🎯 Objectives](#-objectives)
- [🧩 Dataset Description](#-dataset-description)
- [🚀 Tools & Technologies Used](#-tools-&-technologies-used)
- [⚙️ Project Workflow](#-project-workflow)
- [📊 Dashboard Highlights](#-dashboard-highlights)
- [🧠 Business Impact](#-business-impact)

---

## 📌 Overview

An interactive **Power BI dashboard** for retail sales and inventory analytics — built using **Excel, SQL, and Power BI**.  
This project delivers actionable insights into **sales performance, customer behavior, staff efficiency, and stock optimization**, helping retail businesses make smarter, data-driven decisions.

---

## 🎯 Objectives

This project — **Retail Sales & Inventory Intelligence System** — is a data analytics solution designed to help a retail company optimize its **sales, inventory, and staff performance** using **Excel, SQL, and Power BI**.

The dashboard provides a **360° view of business operations**, analyzing order processing, store performance, and inventory status across multiple regions and brands.

---

## 🧩 Dataset Description

**Dataset Name:** Retail Sales Data  
**Size:** ~5000+ transactions  
**Schema:** 9 relational tables (Sales & Production domains)

| Domain         | Tables                                                   | Description                 |
| -------------- | -------------------------------------------------------- | --------------------------- |
| **Sales**      | `orders`, `order_items`, `customers`, `staffs`, `stores` | Order & transaction data    |
| **Production** | `products`, `brands`, `categories`, `stocks`             | Inventory & product details |

---

## 🚀 Tools & Technologies Used

| Tool / Language                 | Purpose                                               |
| ------------------------------- | ----------------------------------------------------- |
| **Excel**                       | Data cleaning, preprocessing, and initial exploration |
| **SQL (MySQL / SQL Workbench)** | Data modeling, querying, and data validation          |
| **Power BI**                    | Dashboard creation, KPI tracking, and storytelling    |
| **Python (Optional)**           | Advanced analytics or customer segmentation           |

---

## ⚙️ Project Workflow

### **Phase 1: Excel – Data Preprocessing**

- Cleaned raw data (removed nulls, duplicates, fixed date formats).
- Standardized category and product names.
- Performed data validation and pivot analysis.
- Exported clean datasets for SQL import.

### **Phase 2: SQL – Database Management**

- Created a normalized relational schema.
- Implemented primary & foreign key relationships.
- Wrote analytical queries for:
  - Store-wise and brand-wise performance
  - Staff productivity metrics
  - Inventory and order tracking
  - Revenue and AOV trends

### **Phase 3: Power BI – Dashboard Creation**

- Connected Power BI directly to SQL views.
- Created an **interactive, multi-page dashboard**:

  - **Overview Page** – KPIs, Sales Over Time
  - **Stores & Staff Page** – Performance metrics and comparisons
  - **Products & Inventory Page** – Top Products and Stock Coverage
  - **Customers Page** – Spending patterns and engagement metrics

- Added slicers for **Year**, **Month**, **Brand**, **Category**, **Store**, and **Staff**.

---

## 📊 Dashboard Highlights

| Metric                     | Value  |
| -------------------------- | ------ |
| **Total Sales**            | ₹7.69M |
| **Total Orders**           | 1,615  |
| **Unique Customers**       | 7      |
| **Avg. Order Value (AOV)** | ₹4.76K |

### **Top Performing Stores**

- 🏆 **Baldwin Bikes:** ₹5.2M
- **Santa Cruz Bikes:** ₹1.6M
- **Rowlett Bikes:** ₹0.9M

### **Top Staff Members**

| Staff Name      | Store            | Orders | Revenue |
| --------------- | ---------------- | ------ | ------- |
| Marcelene Boyer | Baldwin Bikes    | 553    | ₹2.62M  |
| Venita Daniel   | Baldwin Bikes    | 540    | ₹2.59M  |
| Genna Serrano   | Santa Cruz Bikes | 184    | ₹0.85M  |

### **Top Brands**

- **Trek:** ₹4.6M
- **Electra:** ₹1.2M
- **Surly:** ₹0.9M

---

## 🧠 Business Impact

✅ Improved decision-making with real-time visibility of KPIs.  
✅ Identified top-selling products and optimized inventory distribution.  
✅ Enhanced staff accountability through sales performance metrics.  
✅ Strengthened customer engagement insights and trend analysis.  
✅ Delivered an automated, scalable reporting solution using Power BI.

---

### ⭐ GitHub Project Summary (For Repository “About” Section)

> **Retail Sales & Inventory Analytics Dashboard** built with Excel, SQL, and Power BI.  
> Visualizes KPIs across stores, staff, and products to improve decision-making in retail operations.  
> Focused on sales trends, inventory optimization, and performance insights.

---

## 🧑‍💻 Author

**Neeraj Kumar**  
📧 [LinkedIn Profile](https://www.linkedin.com/in/krneerajsingh/)

---

## 🪪 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
