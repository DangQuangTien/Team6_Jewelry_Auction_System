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
         <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <style>
        /* Google Font Link */
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
            *{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Poppins" , sans-serif;
            }
        .hidden-fields label, .hidden-fields input {
            display: none;
        }
        .gradient-line {
                height: 2px; /* Adjust the height as needed */
                width: 100%; /* Adjust the width as needed */
                background: linear-gradient(to right, #a8c0ff, #325fcf,#a8c0ff, #325fcf); /* Adjust the colors as needed */
                margin: 20px 0; /* Adjust the margin as needed */
            }
    </style>
    <body class="bg-gray-100 flex justify-center">
    <main class="container mx-auto my-8 p-4 flex-grow-1">
        <a href="${pageContext.request.contextPath}/requestList" class="btn bg-indigo-400 hover:bg-indigo-700 mb-4 flex items-center text-gray-700 rounded">
            <i class="fas fa-chevron-left mr-2"></i> Back
        </a>
        <div class="text-center mb-6">
            <h2 class="text-2xl font-bold" style="color: #2563eb">Preliminary Assessment</h2>
        </div>
        <hr class="mb-6 gradient-line">
        <div class="flex flex-wrap -mx-4">
            <div class="w-full md:w-1/2 px-4 mb-4">
                <div class="card bg-white shadow-lg rounded-lg overflow-hidden">
                    <div class="card-body overflow-y-auto max-h-80 p-4">
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
                        <div class="grid grid-cols-2 gap-4">
                            <% for (String photo : photoArray) { %>
                                <div class="image-item">
                                    <img src="${pageContext.request.contextPath}/<%= photo %>" alt="Photo" class="w-full h-full object-cover">
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="w-full md:w-1/2 px-4 mb-4">         
                <div class="card-body bg-white shadow-lg rounded-lg p-6">
                    <form action="${pageContext.request.contextPath}/evaluate" id="valuationForm" onsubmit="confirmValuation(event)" method="POST">
                        <div class="mb-4">
                            <label for="category" class="block text-gray-700">Category</label>
                            <select id="category" name="category" class="block w-full mt-2 p-2 border border-gray-300 rounded-md" onchange="showFormFields()">
                                <% for (Category category : listCategory) { %>
                                    <option value="<%= category.getCategoryID() %>"><%= category.getCategoryName() %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="hidden-fields">
                            <label for="jewelryName" class="block text-gray-700">Jewelry Name</label>
                            <input type="hidden" id="jewelryName" name="jewelryName" value="">
                        </div>
                        <div class="hidden-fields">
                            <label for="artist" class="block text-gray-700">Artist</label>
                            <input type="hidden" id="artist" name="artist" value="">
                        </div>

                        <!-- Watch Fields -->
                        <div id="watchFields" class="form-section hidden-fields">
                            <h3 class="text-xl font-bold mb-4">Watch Details</h3>
                            <div class="mb-4">
                                <label for="circa" class="block text-gray-700">Circa</label>
                                <input type="hidden" id="circa" name="circa" value="">
                            </div>
                            <div class="mb-4">
                                <label for="material" class="block text-gray-700">Case Material</label>
                                <input type="hidden" id="material" name="material" value="">
                            </div>
                            <div class="mb-4">
                                <label for="dial" class="block text-gray-700">Dial</label>
                                <input type="hidden" id="dial" name="dial" value="">
                            </div>
                            <div class="mb-4">
                                <label for="braceletMaterial" class="block text-gray-700">Bracelet Material</label>
                                <input type="hidden" id="braceletMaterial" name="braceletMaterial" value="">
                            </div>
                            <div class="mb-4">
                                <label for="caseDimensions" class="block text-gray-700">Case Dimensions</label>
                                <input type="hidden" id="caseDimensions" name="caseDimensions" value="">
                            </div>
                            <div class="mb-4">
                                <label for="braceletSize" class="block text-gray-700">Bracelet Size</label>
                                <input type="hidden" id="braceletSize" name="braceletSize" value="">
                            </div>
                            <div class="mb-4">
                                <label for="serialNumber" class="block text-gray-700">Serial Number</label>
                                <input type="hidden" id="serialNumber" name="serialNumber" value="">
                            </div>
                            <div class="mb-4">
                                <label for="referenceNumber" class="block text-gray-700">Reference Number</label>
                                <input type="hidden" id="referenceNumber" name="referenceNumber" value="">
                            </div>
                            <div class="mb-4">
                                <label for="caliber" class="block text-gray-700">Caliber</label>
                                <input type="hidden" id="caliber" name="caliber" value="">
                            </div>
                            <div class="mb-4">
                                <label for="movement" class="block text-gray-700">Movement</label>
                                <input type="hidden" id="movement" name="movement" value="">
                            </div>
                            <div class="mb-4">
                                <label for="condition" class="block text-gray-700">Condition</label>
                                <input type="hidden" id="condition" name="condition" value="">
                            </div>
                        </div>

                        <!-- Bracelet Fields -->
                        <div id="braceletFields" class="form-section hidden-fields">
                            <h3 class="text-xl font-bold mb-4">Details</h3>
                            <div class="mb-4">
                                <label for="braceletMetal" class="block text-gray-700">Metal</label>
                                <input type="hidden" id="braceletMetal" name="metal" value="">
                            </div>
                            <div class="mb-4">
                                <label for="braceletGemstones" class="block text-gray-700">Gemstone(s)</label>
                                <input type="hidden" id="braceletGemstones" name="gemstones" value="">
                            </div>
                            <div class="mb-4">
                                <label for="braceletMeasurements" class="block text-gray-700">Measurements</label>
                                <input type="hidden" id="braceletMeasurements" name="measurements" value="">
                            </div>
                            <div class="mb-4">
                                <label for="braceletWeight" class="block text-gray-700">Weight</label>
                                <input type="hidden" id="braceletWeight" name="weight" value="">
                            </div>
                            <div class="mb-4">
                                <label for="braceletCondition" class="block text-gray-700">Condition</label>
                                <input type="hidden" id="braceletCondition" name="condition" value="">
                            </div>
                            <div class="mb-4">
                                <label for="braceletStamped" class="block text-gray-700">Stamped</label>
                                <input type="hidden" id="braceletStamped" name="stamped" value="">
                            </div>
                            <div class="mb-4">
                                <label style="color: red" for="ringSize" class="block text-gray-700">Ring Size (for rings)</label>
                                <input type="hidden" id="ringSize" name="ringSize" value="">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="Price" class="block text-gray-700">Estimate</label>
                            <div class="flex">
                                <input type="number" id="minPrice" name="minPrice" placeholder="Min" class="w-1/2 p-2 border border-gray-300 rounded-md mr-2">
                                <input type="number" id="maxPrice" name="maxPrice" placeholder="Max" class="w-1/2 p-2 border border-gray-300 rounded-md">
                            </div>
                        </div>
                        <div class="mb-4">
                            <label for="tempPrice" class="block text-gray-700">Temporary Price</label>
                            <input type="number" id="tempPrice" name="tempPrice" placeholder="Temporary Price" class="w-full p-2 border border-gray-300 rounded-md">
                        </div>
                        <input type="hidden" name="valuationID" value="<%= (String) request.getParameter("valuationID") %>">
                        <input type="hidden" name="photoURL" value="<%= (String) request.getParameter("photoURL") %>">
                        <input type="submit" name="action" value="Submit" class="btn bg-indigo-400 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded">
                    </form>
                </div>
            </div>
        </div>
    </main>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="asset/valuation.js"></script>
</body>
</html>
