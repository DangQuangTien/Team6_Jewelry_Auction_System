<%-- 
    Document   : staff
    Created on : May 23, 2024, 1:09:59 AM
    Author     : User
--%>

<%@page import="entity.valuation.Valuation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
                background-color: #f9f9f9;
                color: #333;
            }
            h3 {
                font-size: 2em;
                color: #2196F3;
                text-align: center;
                padding: 20px;
                border-radius: 10px;
                background: linear-gradient(135deg, #ff6f91, #ff9671, #ffc75f, #f9f871, #d65db1, #845ec2, #2c73d2, #0081cf, #0089ba, #008e9b, #00c9a7);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                box-shadow: 0 0 20px rgba(255, 255, 255, 0.8);
                animation: wave 3s linear infinite;
            }

            @keyframes wave {
                0%, 100% {
                    transform: translateY(0);
                }
                25% {
                    transform: translateY(-5px);
                }
                50% {
                    transform: translateY(0);
                }
                75% {
                    transform: translateY(5px);
                }
            }

            h2 {
                color: #2196F3;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                background-color: #fff;
            }
            th, td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ddd;
            }
            th {
                background-color: #f2f2f2;
            }
            img {
                max-width: 100px;
                max-height: 100px;
            }
            .submit-btn {
                background-color: #2196F3;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .submit-btn:hover {
                background-color: #1976D2;
            }
            .submit-btn-grey {
                background-color: grey;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: not-allowed;
                transition: background-color 0.3s;
            }
            .submit-btn-grey:hover {
                background-color: darkgrey;
            }
        </style>
        <script>
            function confirmLogout(event) {
                if (!confirm("Are you sure you want to log out?")) {
                    event.preventDefault();
                }
            }
            function confirmReceipt(event) {
                if (!confirm("Are you sure you want to confirm the receipt?")) {
                    event.preventDefault();
                }
            }
        </script>
    </head>
    <%
        String greeting = "day!";
        try {
            LocalTime now = LocalTime.now();
            int hour = now.getHour();
            if (hour < 12) {
                greeting = "Morning!";
            } else if (hour < 17) {
                greeting = "Afternoon!";
            } else {
                greeting = "Evening!";
            }
        } catch (Exception ex) {
            ex.getMessage();
        }
    %>
    <body>
        <h3>Good <%= greeting%> Welcome back, Staff</h3>
        <form action="${pageContext.request.contextPath}/MainController" method="POST">
            <input type="submit" name="action" class="submit-btn" value="Valuation Request">
        </form>
    <br><br>
    <form action="${pageContext.request.contextPath}/staff/approvalRequest.jsp" method="POST">
        <input type="submit" name="action" class="submit-btn" value="Approval Request">
    </form>
    <br>
    <form action="${pageContext.request.contextPath}/MainController" method="POST" onsubmit="confirmLogout(event)">
        <input type="submit" name="action" class="submit-btn" value="Log out">
    </form>
    <br>
    <c:set var="listValuationRequest" value="${requestScope.listValuationRequest}" />
    <c:if test="${not empty listValuationRequest}">
        <h2>Valuation Requests</h2>
        <table>
            <thead>
                <tr>
                    <th>No</th>
                    <th>Photo</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                    <th>Communication Preference</th>
                    <th>Description</th>
                    <th>Action</th>
                    <th>Confirmation of Receipt</th>
                    <th>Final Valuation</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="val" items="${listValuationRequest}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td>
                            <c:set var="photoArray" value="${fn:split(val.photo, ';')}" />
                            <img src="${photoArray[0]}" alt="Photo">
                        </td>
                        <td>${val.name}</td>
                        <td>${val.email}</td>
                        <td>${val.phone}</td>
                        <td>${val.communication}</td>
                        <td>${val.description}</td>
                        <td>
                            <div align="center">
                                <c:choose>
                                    <c:when test="${val.status == 0}">
                                        <form action="${pageContext.request.contextPath}/staff/valuation.jsp" method="GET">
                                            <input type="hidden" name="photoURL" value="${val.photo}">
                                            <input type="hidden" name="valuationID" value="${val.valuationID}">
                                            <input type="submit" class="submit-btn" value="Evaluate">
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="submit" class="submit-btn-grey" value="Evaluated" disabled><br><br>
                                        <c:if test="${val.status == 1}">
                                            <form action="${pageContext.request.contextPath}/MainController" method="GET">
                                                <input type="hidden" name="valuationID" value="${val.valuationID}">
                                                <input type="hidden" name="name" value="${val.name}">
                                                <input type="submit" name="action" class="submit-btn" value="Request to Ship">
                                            </form>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                                </form>
                            </div>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/MainController" method="POST" onsubmit="confirmReceipt(event)">
                                <input type="hidden" name="valuationID" value="${val.valuationID}">
                                <input type="submit" name="action" class="submit-btn" value="Confirm Receipt">
                            </form>
                        </td>
                        <td><c:choose>
                                <c:when test="${val.status == 0}">
                                    <input type="submit" class="submit-btn-grey" value="Final Evaluate" disabled>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/staff/finalValuation.jsp" method="POST">
                                        <input type="hidden" name="valuationID" value="${val.valuationID}">
                                        <input type="submit" name="action" class="submit-btn" value="Final Evaluate">
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>
