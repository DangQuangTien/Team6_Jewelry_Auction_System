<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Invoice Growth Dashboard</title>
        <!-- Include Chart.js library -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <style>
        .btn {
            background-color: #c82333;
            color: white;
            border: none;
            border-radius: 20px;
            padding: 8px 16px;
            font-size: 12px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            font-family: Helvetica;
            text-transform: uppercase;
            outline: none;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            font-weight: bold
        }

        .btn:hover {
            background-color: #a71d2a;
            transform: scale(1.05);
        }
    </style>
    <script>
        function redirectToPage(url) {
        window.location.href = 'staff';
        }
    </script>
    <body>
        <button class="btn" onclick="redirectToPage()">EXIT</button>
        <div style="width: 90%; margin: auto; height: 500px; font-size: 30px">
            <canvas id="invoiceChart"></canvas>
        </div>

        <script>
            // Retrieve data from JSP page using JSTL
            <c:set var="invoiceDataList" value="${requestScope.INVOICES}"/>
            var invoiceData = [
            <c:forEach items="${invoiceDataList}" var="invoice">
            {
            month: '${invoice.invoiceDate}', // Assuming invoiceDate format is 'YYYY-MM-DD HH:mm:ss.0'
                    amount: ${invoice.totalAmount},
                    invoiceID: '${invoice.invoiceID}' // Assuming invoiceID is a string
            },
            </c:forEach>
            {
            month: '2024-08-01 00:00:00.0',
                    amount: 150000000.00,
                    invoiceID: 'INV-0004'
            },
            {
            month: '2024-09-01 00:00:00.0',
                    amount: 200000000.00,
                    invoiceID: 'INV-0005'
            },
            {
            month: '2024-10-01 00:00:00.0',
                    amount: 180000000.00,
                    invoiceID: 'INV-0006'
            },
            {
            month: '2024-11-01 00:00:00.0',
                    amount: 250000000.00,
                    invoiceID: 'INV-0007'
            },
            {
            month: '2024-12-01 00:00:00.0',
                    amount: 300000000.00,
                    invoiceID: 'INV-0008'
            },
            {
            month: '2025-01-01 00:00:00.0',
                    amount: 350000000.00,
                    invoiceID: 'INV-0009'
            }
            ];
            // Aggregate data by month
            var aggregatedData = {};
            invoiceData.forEach(function(item) {
            var month = item.month.substring(0, 7); // Extract YYYY-MM from invoiceDate
            if (!aggregatedData[month]) {
            aggregatedData[month] = {
            totalAmount: 0,
                    count: 0,
                    invoiceIDs: [] // Store unique invoice IDs for each month
            };
            }
            aggregatedData[month].totalAmount += item.amount;
            // Count each unique invoiceID only once per month
            if (!aggregatedData[month].invoiceIDs.includes(item.invoiceID)) {
            aggregatedData[month].count++;
            aggregatedData[month].invoiceIDs.push(item.invoiceID);
            }
            });
            // Prepare data for Chart.js
            var months = Object.keys(aggregatedData);
            var amounts = months.map(month => aggregatedData[month].totalAmount.toFixed(2));
            var counts = months.map(month => aggregatedData[month].count);
            // Chart.js configuration
            var ctx = document.getElementById('invoiceChart').getContext('2d');
            var chart = new Chart(ctx, {
            type: 'bar',
                    data: {
                    labels: months,
                            datasets: [{
                            label: 'Total Amount',
                                    data: amounts,
                                    backgroundColor: 'rgba(75, 192, 192, 0.5)',
                                    borderColor: 'rgb(75, 192, 192)',
                                    borderWidth: 2
                            }, {
                            label: 'Number of Invoices',
                                    data: counts,
                                    backgroundColor: 'rgba(255, 159, 64, 0.5)',
                                    borderColor: 'rgb(255, 159, 64)',
                                    borderWidth: 2
                            }]
                    },
                    options: {
                    responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                            x: {
                            title: {
                            display: true,
                                    text: 'Month'
                            }
                            },
                                    y: {
                                    beginAtZero: true,
                                            title: {
                                            display: true,
                                                    text: 'Amount / Count'
                                            }
                                    }
                            }
                    }
            });
        </script>
    </body>
</html>
