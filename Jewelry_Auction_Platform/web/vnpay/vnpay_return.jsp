<%@page import="java.util.logging.Level"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="entity.Invoice.Invoice"%>
<%@page import="dao.UserDao"%>
<%@page import="dao.UserDAOImpl"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="jewelryauction.controller.payment.Config"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>PAYMENT RESULT</title>
        <!-- Bootstrap core CSS -->
        <link href="../assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->
        <link href="../assets/jumbotron-narrow.css" rel="stylesheet"> 
        <script src="../assets/jquery-1.11.3.min.js"></script>
    </head>
    <body>
        <%
            //Begin process return from VNPAY
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
        %>
        <!--Begin display -->
        <div class="container">
            <div class="header clearfix">
                <h3 class="text-muted">PAYMENT RESULT</h3>
            </div>
            <div class="table-responsive">
                <div class="form-group">
                    <label>Transaction ID:</label>
                    <label><%=request.getParameter("vnp_TxnRef")%></label>
                </div>    
                <div class="form-group">
                    <label>Amount:</label>
                    <%
                        String amountParam = request.getParameter("vnp_Amount");
                        long totalAmount = Long.parseLong(amountParam.trim());
                        long actualAmount = totalAmount / 100;
                    %>
                    <label><% out.print(actualAmount); %></label>
                </div>  
                <div class="form-group">
                    <label>Transaction Description:</label>
                    <%
                        String orderInfo = request.getParameter("vnp_OrderInfo");
                        String[] orderInfoParts = orderInfo.split(";");
                    %>
                    <label><%  out.print(orderInfoParts[0]);%></label>
                </div> 
                <div class="form-group">
                    <label>Payment Error Code:</label>
                    <label><%=request.getParameter("vnp_ResponseCode")%></label>
                </div> 
                <div class="form-group">
                    <label>Transaction ID at VNPAY-QR:</label>
                    <label><%=request.getParameter("vnp_TransactionNo")%></label>
                </div> 
                <div class="form-group">
                    <label>Payment Bank Code:</label>
                    <label><%=request.getParameter("vnp_BankCode")%></label>
                </div> 
                <div class="form-group">
                    <label>Payment Time:</label>
                    <label><%
                        String vnpPayDate = request.getParameter("vnp_PayDate");

                        // Define the original format
                        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyyMMddHHmmss");

                        // Define the desired format
                        SimpleDateFormat desiredFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                        try {
                            // Parse the date string into a Date object
                            Date date = originalFormat.parse(vnpPayDate);

                            // Format the Date object into the desired format
                            String formattedDate = desiredFormat.format(date);

                            // Output the formatted date
                            out.println(formattedDate);
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("Invalid date format");
                        }
                        %></label>
                </div> 
                <div class="form-group">
                    <label>Transaction Status:</label>
                    <label>
                        <%
                            if (signValue.equals(vnp_SecureHash)) {
                                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                                    out.println("Successful");
                                    UserDao dao = new UserDAOImpl();
                                    dao.updateRegisterBidStatus(orderInfoParts[2], orderInfoParts[1]);
                                    String memberID = orderInfoParts[2];
                                    String jewelryID = orderInfoParts[1];
                                    String invoiceID = request.getParameter("vnp_TxnRef");
                                    Date date = originalFormat.parse(vnpPayDate);
                                    String formattedDate = desiredFormat.format(date);
                                    BigDecimal decimalValue = new BigDecimal(actualAmount);
                                    decimalValue = decimalValue.setScale(2, BigDecimal.ROUND_HALF_UP);
                                    Invoice invoice = new Invoice(invoiceID, memberID, jewelryID, formattedDate, decimalValue);
                                    dao.insertInvoice(invoice);
                                } else {
                                    out.print("Failed");
                                }

                            } else {
                                out.print("invalid signature");
                            }
                        %></label>
                </div> 
            </div>
            <p>
                <%
                    out.println("<a href=\"" + request.getContextPath() + "/my-upcoming-bids\">Back</a>");
                %>
            </p>
            <p>
                &nbsp;
            </p>
            <footer class="footer">
                <p>&copy; VNPAY 2020</p>
            </footer>
        </div>  
    </body>
</html>