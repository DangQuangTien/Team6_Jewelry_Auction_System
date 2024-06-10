<%@page import="dao.UserDAOImpl"%>
<%@page import="entity.product.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%-- 
    Document   : valuation
    Created on : May 23, 2024, 9:20:58 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Valuation Form</title>
    <link rel="stylesheet" type="text/css" href="asset/valuation.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">Staff Portal</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/staff/staff.jsp"><i class="fas fa-user"></i>Staff</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/MainController?action=ValuationRequest"><i class="fas fa-file-invoice-dollar"></i> Valuation Request</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/staff/approvalRequest.jsp"><i class="fas fa-thumbs-up"></i> Approval Request</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/staff/finalValuation.jsp"><i class="fas fa-check-double"></i> Final Valuation</a>
                </li>
                <li class="nav-item">
                    <form action="${pageContext.request.contextPath}/MainController" method="POST" onsubmit="confirmLogout(event)">
                        <button type="submit" name="action" class="btn btn-link nav-link" value="Log out"><i class="fas fa-sign-out-alt"></i> Logout</button>
                    </form>
                </li>
            </ul>
        </div>
    </nav>

    <main class="container my-4">
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-body" style="overflow-y: auto; max-height: 500px;">
                        <h2>Jewelry Appraisal</h2>
                        <%
                            String photos = (String) request.getParameter("photoURL");
                            String[] photoArray = photos != null ? photos.split(";") : new String[0];

                            ArrayList<Category> listCategory = new ArrayList<>();
                            try {
                                UserDAOImpl dao = new UserDAOImpl();
                                listCategory = dao.listCategory();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                        <div class="image-grid">
                            <% for (String photo : photoArray) { %>
                            <div class="image-item">
                                <img src="${pageContext.request.contextPath}/<%= photo %>" alt="Photo" class="grid-image img-thumbnail">
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title">Fill In The Detail</h2>
                        <form action="${pageContext.request.contextPath}/MainController" onsubmit="confirmValuation(event)" method="GET">
                            <div class="form-group">
                                <label for="category">Category</label>
                                <select class="form-control" id="category" name="category" onchange="showFormFields()">
                                    <% for (Category category : listCategory) { %>
                                    <option value="<%= category.getCategoryID() %>"><%= category.getCategoryName() %></option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="jewelryName">Jewelry Name</label>
                                <input type="text" class="form-control" id="jewelryName" name="jewelryName" value="">
                            </div>
                            <div class="form-group">
                                <label for="artist">Artist</label>
                                <input type="text" class="form-control" id="artist" name="artist" value="">
                            </div>

                            <!-- Watch Fields -->
                            <div id="watchFields" class="form-section d-none">
                                <h3>Watch Details</h3>
                                <div class="form-group">
                                    <label for="circa">Circa</label>
                                    <input type="text" class="form-control" id="circa" name="circa" value="">
                                </div>
                                <div class="form-group">
                                    <label for="material">Case Material</label>
                                    <input type="text" class="form-control" id="material" name="material" value="">
                                </div>
                                <div class="form-group">
                                    <label for="dial">Dial</label>
                                    <input type="text" class="form-control" id="dial" name="dial" value="">
                                </div>
                                <div class="form-group">
                                    <label for="braceletMaterial">Bracelet Material</label>
                                    <input type="text" class="form-control" id="braceletMaterial" name="braceletMaterial" value="">
                                </div>
                                <div class="form-group">
                                    <label for="caseDimensions">Case Dimensions</label>
                                    <input type="text" class="form-control" id="caseDimensions" name="caseDimensions" value="">
                                </div>
                                <div class="form-group">
                                    <label for="braceletSize">Bracelet Size</label>
                                    <input type="text" class="form-control" id="braceletSize" name="braceletSize" value="">
                                </div>
                                <div class="form-group">
                                    <label for="serialNumber">Serial Number</label>
                                    <input type="text" class="form-control" id="serialNumber" name="serialNumber" value="">
                                </div>
                                <div class="form-group">
                                    <label for="referenceNumber">Reference Number</label>
                                    <input type="text" class="form-control" id="referenceNumber" name="referenceNumber" value="">
                                </div>
                                <div class="form-group">
                                    <label for="caliber">Caliber</label>
                                    <input type="text" class="form-control" id="caliber" name="caliber" value="">
                                </div>
                                <div class="form-group">
                                    <label for="movement">Movement</label>
                                    <input type="text" class="form-control" id="movement" name="movement" value="">
                                </div>
                                <div class="form-group">
                                    <label for="condition">Condition</label>
                                    <input type="text" class="form-control" id="condition" name="condition" value="">
                                </div>
                            </div>

                            <!-- Bracelet Fields -->
                            <div id="braceletFields" class="form-section d-none">
                                <h3>Details</h3>
                                <div class="form-group">
                                    <label for="braceletMetal">Metal</label>
                                    <input type="text" class="form-control" id="braceletMetal" name="metal" value="">
                                </div>
                                <div class="form-group">
                                    <label for="braceletGemstones">Gemstone(s)</label>
                                    <input type="text" class="form-control" id="braceletGemstones" name="gemstones" value="">
                                </div>
                                <div class="form-group">
                                    <label for="braceletMeasurements">Measurements</label>
                                    <input type="text" class="form-control" id="braceletMeasurements" name="measurements" value="">
                                </div>
                                <div class="form-group">
                                    <label for="braceletWeight">Weight</label>
                                    <input type="text" class="form-control" id="braceletWeight" name="weight" value="">
                                </div>
                                <div class="form-group">
                                    <label for="braceletCondition">Condition</label>
                                    <input type="text" class="form-control" id="braceletCondition" name="condition" value="">
                                </div>
                                <div class="form-group">
                                    <label style="color: red" for="ringSize">Ring Size (for rings)</label>
                                    <input type="text" class="form-control" id="ringSize" name="ringSize" value="">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="Price">Estimate</label>
                                <div class="input-group">
                                    <input type="number" class="form-control" id="minPrice" name="minPrice" placeholder="Min">
                                    <input type="number" class="form-control" id="maxPrice" name="maxPrice" placeholder="Max">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="tempPrice">Temporary Price</label>
                                <input type="number" class="form-control" id="tempPrice" name="tempPrice" placeholder="Temporary Price">
                            </div>

                            <input type="hidden" name="valuationID" value="<%= (String) request.getParameter("valuationID") %>">
                            <input type="hidden" name="photoURL" value="<%= (String) request.getParameter("photoURL") %>">

                            <button type="submit" name="action" value="Submit" class="btn btn-primary">Submit</button>
                            <button type="button" class="btn btn-secondary" onclick="cancelValuation()">Cancel</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="asset/valuation.js"></script>
</body>
</html>