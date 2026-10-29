📊 SAP ABAP R2R Accounting Report

Record-to-Report | SAP FI | ABAP ALV Grid

An SAP ABAP learning project that retrieves accounting document information from the SAP "BKPF" and "BSEG" tables, processes debit and credit amounts, and displays summarized accounting data using the ALV Grid.

---

📌 Project Overview

The SAP ABAP R2R Accounting Report demonstrates the Record-to-Report (R2R) process in SAP Financial Accounting (FI).

The report retrieves accounting document header and line-item data, applies user-defined selection criteria, aggregates debit and credit amounts, calculates the difference, and presents the results in an interactive ALV Grid.

This project was developed as part of my SAP ABAP learning and training.

🎯 Project Objectives

- Retrieve accounting document data from SAP tables.
- Join accounting document header and line-item information.
- Implement selection criteria for company code, posting date, and document type.
- Calculate total debit and credit amounts for each accounting document.
- Calculate the difference between debit and credit.
- Display summarized accounting information using ALV Grid.

🛠️ Technologies Used

Technology| Purpose
SAP ABAP| Report development
SAP FI| Financial Accounting
BKPF| Accounting document header data
BSEG| Accounting document line-item data
Open SQL| Database retrieval and INNER JOIN
SELECT-OPTIONS| Dynamic report selection criteria
Internal Tables| Data processing and aggregation
Field Symbols| Efficient internal table processing
REUSE_ALV_GRID_DISPLAY| ALV Grid output
SE38| ABAP report development
SE16N| Database table validation

✨ Key Features

- 🏢 Company Code Filter — Retrieve documents for a selected company code.
- 📅 Posting Date Filter — Restrict results to a specified posting date range.
- 📄 Document Type Filter — Retrieve accounting documents based on document type.
- 🔗 BKPF and BSEG Join — Combine document header and line-item information.
- 💰 Debit and Credit Calculation — Aggregate debit and credit amounts.
- 🧮 Difference Calculation — Calculate the difference between debit and credit.
- 📊 ALV Grid Display — Present accounting document summaries in a structured grid.
- 🔍 Data Validation — Compare report results against SAP source table records.

⚙️ Selection Criteria

The report provides the following selection options:

Field| Description
"S_BUKRS"| Company Code
"S_BUDAT"| Posting Date
"S_BLART"| Accounting Document Type

Example test values:

- Company Code: "0123"
- Posting Date: "01.01.2020" to "31.12.2026"
- Document Type: "DR"

Note: These are example values. The available data depends on the SAP system.

🔄 Processing Logic

1. Read accounting document header data from "BKPF".
2. Retrieve the corresponding line items from "BSEG".
3. Join both tables using company code, document number, and fiscal year.
4. Apply the selection criteria.
5. Process the selected accounting line items.
6. Group the data by company code, document number, and fiscal year.
7. Calculate debit and credit totals.
8. Calculate the difference.
9. Display the summarized results using ALV Grid.

💡 Calculation Logic

Debit Amount:

Sum of line-item amounts where "SHKZG = 'S'".

Credit Amount:

Sum of line-item amounts where "SHKZG = 'H'".

Difference:

Difference = Debit Amount - Credit Amount

A zero difference can indicate that the accounting document is balanced.

📊 ALV Output

The report displays the following fields:

Field| Description
"BUKRS"| Company Code
"BELNR"| Accounting Document Number
"GJAHR"| Fiscal Year
"BLART"| Document Type
"WAERS"| Document Currency
"DEBIT_AMT"| Total Debit Amount
"CREDIT_AMT"| Total Credit Amount
"DIFFERENCE"| Debit Amount − Credit Amount

🖼️ Project Screenshots

Screenshots of the report execution and validation are available in the ""Screenshots"" (./Screenshots) folder.

Final ALV Output

"SAP ABAP R2R ALV Output" (Screenshots/08_Final_ALV_Output.png)

Selection Screen

"SAP ABAP R2R Selection Screen" (Screenshots/02_Selection_Screen.png)

Debit and Credit Validation

"Debit and Credit Validation" (Screenshots/13_Debit_Credit_Validation.png)

Replace these image paths with the exact filenames you upload to GitHub.

🧪 Testing and Validation

The following tests are included in the project validation process:

Test Case| Expected Result
Company Code Filter| Only selected company-code records are displayed
Posting Date Filter| Records fall within the selected date range
Document Type Filter| Only the selected document type is displayed
Debit/Credit Calculation| Amounts match the corresponding BSEG line items
Difference Calculation| Difference equals debit minus credit
No-Data Scenario| Appropriate message appears when no matching records exist
Syntax Check| Program passes syntax check and activation

Testing status should be updated based on the actual results from the SAP system.

🚀 Live Demo

SAP GUI Demo

This project is a classical SAP ABAP report developed for execution within SAP GUI.

A public web-based live demo is not currently available.

To view the report:

1. Access an authorized SAP system.
2. Open transaction "SE38".
3. Enter program name "Z343_REUSE_ALV_GRID_DISPLAY".
4. Execute the program using "F8".
5. Enter the required selection criteria.
6. View the accounting document summary in ALV Grid.

🎥 Demo Video

A screen-recording demonstration can be added here in the future.

Demo Video: [Add your demo video link here, if available]

📁 Repository Structure

SAP-ABAP-R2R-Project/
│
├── README.md
├── Z343_REUSE_ALV_GRID_DISPLAY.abap
├── SAP_ABAP_R2R_Project_Documentation.pdf
│
└── Screenshots/
    ├── 01_Source_Code_1.png
    ├── 02_Source_Code_2.png
    ├── 03_Source_Code_3.png
    ├── 04_Source_Code_4.png
    ├── 05_Syntax_Check.png
    ├── 05_Syntax_Activation.png
    ├── 06_Final_ALV_Output.png
    ├── 07_Debit_Credit_Validation.png
    ├── 08_Posting_Date_Filter_Test.png
    ├── 09_Document_Type_Filter_Test.png
    ├── 10_No_Data_Message_Test.png
    └── 11_BSEG_Debit_Credit_Verification.png

📚 Learning Outcomes

Through this project, I gained practical experience in:

- SAP ABAP report development.
- SAP FI accounting document tables.
- Open SQL and INNER JOIN.
- Selection-screen programming.
- Internal table processing.
- Debit and credit aggregation.
- ALV Grid reporting.
- Data validation using SE16N.

👩‍💻 Author

Bhavya Sree Cherukuri

SAP ABAP Trainee | B.Tech – Artificial Intelligence & Machine Learning

📌 Interested in SAP ABAP Development and SAP Technical Consulting.

🔗 GitHub: "Bhavya-67" (https://github.com/Bhavya-67)

⚠️ Disclaimer

This is a learning and training project developed for educational purposes. The report output depends on the accounting data and authorizations available in the SAP system. No confidential business data or credentials should be shared publicly.

---

⭐ If you find this project useful, feel free to explore the source code and documentation.
