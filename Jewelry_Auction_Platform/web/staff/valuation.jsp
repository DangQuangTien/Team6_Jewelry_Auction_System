<%-- 
    Document   : valuation
    Created on : May 23, 2024, 9:20:58 AM
    Author     : User
--%>

<%@page import="dao.UserDAOImpl"%>
<%@page import="entity.product.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

    <main class="container my-4 flex-grow-1">
        <div class="row">
            <div class="col-md-6 mb-4">
                <h2>Jewelry Appraisal</h2>
                <div class="card product-display">
                    <div class="card-body" style="overflow-y: auto; max-height: 500px;">
                        
                        <%
                            String photos = (String) request.getParameter("photoURL");
                            String[] photoArray = photos.split(";");

                            ArrayList<Category> listCategory = new ArrayList<>();
                            try {
                                UserDAOImpl dao = new UserDAOImpl();
                                listCategory = dao.listCategory();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                        <div class="image-grid">
                            <% for (String photo : photoArray) {%>
                            <div class="image-item">
                                <img src="${pageContext.request.contextPath}/<%= photo%>" alt="Photo" class="grid-image">
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mb-4">         
                    <div class="card-body">
                        <h2 class="card-title">Fill In The Detail</h2>
                        <form action="${pageContext.request.contextPath}/MainController" onsubmit="confirmValuation(event)" method="GET">
                            <div>
                                <label for="category">Category</label>
                                <select id="category" name="category" onchange="showFormFields()">
                                    <% for (Category category : listCategory) {%>
                                    <option value="<%= category.getCategoryID()%>"><%= category.getCategoryName()%></option>
                                    <% }%>
                                </select>
                            </div>

                            <div>
                                <label for="jewelryName">Jewelry Name</label>
                                <input type="text" id="jewelryName" name="jewelryName" value="">
                            </div>
                            <div>
                                <label for="artist">Artist</label>
                                <input type="text" id="artist" name="artist" value="">
                            </div>

                            <!-- Watch Fields -->
                            <div id="watchFields" class="form-section">
                                <h3>Watch Details</h3>
                                <div>
                                    <label for="circa">Circa</label>
                                    <input type="text" id="circa" name="circa" value="">
                                </div>
                                <div>
                                    <label for="material">Case Material</label>
                                    <input type="text" id="material" name="material" value="">
                                </div>
                                <div>
                                    <label for="dial">Dial</label>
                                    <input type="text" id="dial" name="dial" value="">
                                </div>
                                <div>
                                    <label for="braceletMaterial">Bracelet Material</label>
                                    <input type="text" id="braceletMaterial" name="braceletMaterial" value="">
                                </div>
                                <div>
                                    <label for="caseDimensions">Case Dimensions</label>
                                    <input type="text" id="caseDimensions" name="caseDimensions" value="">
                                </div>
                                <div>
                                    <label for="braceletSize">Bracelet Size</label>
                                    <input type="text" id="braceletSize" name="braceletSize" value="">
                                </div>
                                <div>
                                    <label for="serialNumber">Serial Number</label>
                                    <input type="text" id="serialNumber" name="serialNumber" value="">
                                </div>
                                <div>
                                    <label for="referenceNumber">Reference Number</label>
                                    <input type="text" id="referenceNumber" name="referenceNumber" value="">
                                </div>
                                <div>
                                    <label for="caliber">Caliber</label>
                                    <input type="text" id="caliber" name="caliber" value="">
                                </div>
                                <div>
                                    <label for="movement">Movement</label>
                                    <input type="text" id="movement" name="movement" value="">
                                </div>
                                <div>
                                    <label for="condition">Condition</label>
                                    <input type="text" id="condition" name="condition" value="">
                                </div>
                            </div>

                            <!-- Bracelet Fields -->
                            <div id="braceletFields" class="form-section">
                                <h3>Details</h3>
                                <div>
                                    <label for="braceletMetal">Metal</label>
                                    <input type="text" id="braceletMetal" name="metal" value="">
                                </div>
                                <div>
                                    <label for="braceletGemstones">Gemstone(s)</label>
                                    <input type="text" id="braceletGemstones" name="gemstones" value="">
                                </div>
                                <div>
                                    <label for="braceletMeasurements">Measurements</label>
                                    <input type="text" id="braceletMeasurements" name="measurements" value="">
                                </div>
                                <div>
                                    <label for="braceletWeight">Weight</label>
                                    <input type="text" id="braceletWeight" name="weight" value="">
                                </div>
                                <div>
                                    <label for="braceletCondition">Condition</label>
                                    <input type="text" id="braceletCondition" name="condition" value="">
                                </div>
                                <div>
                                    <label for="braceletStamped">Stamped</label>
                                    <input type="text" id="braceletStamped" name="stamped" value="">
                                </div>
                                <div>
                                    <label style="color: red" for="ringSize">Ring Size (for rings)</label>
                                    <input type="text" id="ringSize" name="ringSize" value="">
                                </div>
                            </div>

                            <div>
                                <label for="Price">Estimate</label>
                                <input type="number" id="minPrice" name="minPrice" placeholder="Min">
                                <input type="number" id="maxPrice" name="maxPrice" placeholder="Max">
                            </div>
                            <div>
                                <label for="tempPrice">Temporary Price</label>
                                <input type="number" id="tempPrice" name="tempPrice" placeholder="Temporary Price">
                            </div>

                            <input type="hidden" name="valuationID" value="<%= (String) request.getParameter("valuationID")%>">
                            <input type="hidden" name="photoURL" value="<%= (String) request.getParameter("photoURL")%>">
                            <input type="submit" name="action" value="Submit" class="submit-btn">
                            <button type="button" class="cancel-btn" onclick="cancelValuation()">Cancel</button>
                        </form>                    
                    </div>          
               </div>
          </div>
    </main>
    
    <script type="text/javascript" src="asset/valuation.js"></script> 
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
