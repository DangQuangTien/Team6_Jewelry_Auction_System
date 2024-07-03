<%@page import="dao.UserDAOImpl"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Profile</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.9/dist/sweetalert2.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f9f9f9;
            }
            .navbar {
                background: radial-gradient(circle, rgba(255, 239, 166, 1) 0%, rgba(218, 165, 32, 0.8) 50%, rgba(184, 134, 11, 0.8) 100%);
                background-size: 200% 200%;
                background-position: 50% 50%;
                transition: background 0.3s ease, box-shadow 0.3s ease, padding-top 0.3s ease, padding-bottom 0.3s ease;
                padding-top: 15px;
                padding-bottom: 15px;
                z-index: 1000;
                backdrop-filter: blur(15px);
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3), 0 0 20px rgba(0, 0, 0, 0.19);
            }

            .navbar:hover {
                background-position: 100% 100%;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.3), 0 0 40px rgba(0, 0, 0, 0.25);
            }

            .navbar-brand .brand-name {
                font-size: 2em;
                font-family: 'Zapf-Chancery';
                font-weight: 700;
                color: black;
            }

            .nav-link {
                color: black !important;
                transition: color 0.3s;
                font-family: Andale Mono;
                font-size: 1.25em;
            }

            .navbar-nav .nav-link {
                position: relative;
                transition: color 0.3s;
            }

            .navbar-nav .nav-link::after {
                content: '';
                position: absolute;
                bottom: -5px;
                left: 50%;
                width: 0;
                height: 2px;
                background-color: #ffc107;
                transition: width 0.3s, left 0.3s;
                visibility: hidden;
            }

            .navbar-nav .nav-link:hover::after {
                visibility: visible;
                width: 100%;
                left: 0;
            }

            .profile-container {
                margin-top: 70px; 
            }

            .profile-header {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .profile-content {
                margin-top: 20px;
            }

            .btn-update {
                width: fit-content;
                height: 40px;
                background: #ffc107;
                border-radius: 8px;
                border: 2px solid #ffc107;
                font-size: 15px;
                font-weight: bold;
                color: #334b79;
                -webkit-transition: 0.5s all ease;
                transition: 0.5s all ease;
                position: relative;
                overflow: hidden;
                padding: 10px 25px;
                z-index: 1;
                margin-left: 390px;
            }

            .btn-update:before {
                width: 50%;
                height: 100%;
                content: "";
                margin: auto;
                position: absolute;
                top: 0%;
                left: -50%;
                background: #070500;
                transition: all 0.5s ease;
                z-index: -1;
            }

            .btn-update:after {
                width: 50%;
                height: 100%;
                content: "";
                margin: auto;
                position: absolute;
                top: 0%;
                left: 100%;
                background: #070500;
                transition: all 0.5s ease;
                z-index: -1;
            }

            .btn-update:hover {
                color: white;
                cursor: pointer;
            }

            .btn-update:hover:before {
                top: 0;
                left: 0;
            }

            .btn-update:hover:after {
                top: 0;
                left: 50%;
            }

            .Btn {
                --black: #000000;
                --ch-black: #141414;
                --eer-black: #1b1b1b;
                --night-rider: #2e2e2e;
                --white: #ffc107;
                --af-white: #ffc107;
                --ch-white: #ffc107;
                display: flex;
                align-items: center;
                justify-content: flex-start;
                width: 45px;
                height: 45px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                position: relative;
                overflow: hidden;
                transition-duration: .3s;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.199);
                background-color: var(--af-white);
            }

            .sign {
                width: 100%;
                transition-duration: .3s;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .sign svg {
                width: 17px;
            }

            .sign svg path {
                fill: var(--night-rider);
            }
            /* text */
            .text {
                position: absolute;
                right: 0%;
                width: 0%;
                opacity: 0;
                color: var(--night-rider);
                font-size: 1.2em;
                transition-duration: .3s;
            }
  
            .Btn:hover {
                width: 125px;
                border-radius: 5px;
                transition-duration: .3s;
            }

            .Btn:hover .sign {
                width: 30%;
                transition-duration: .3s;
                padding-left: 20px;
            }

            .Btn:hover .text {
                opacity: 1;
                width: 70%;
                transition-duration: .3s;
                padding-right: 10px;
            }

            .section-header {
                margin-top: 40px;
                margin-bottom: 20px;
                text-align: center;
            }

            .card {
                margin-bottom: 20px;
            }

            .card-header {
                background-color: #ffc107;
                color: #000000;
            }

            .card-body {
                padding: 20px;
            }

            .btn-pay-now {
                --black: #000000;
                --ch-black: #141414;
                --eer-black: #1b1b1b;
                --night-rider: #2e2e2e;
                --white: #ffc107;
                --af-white: #ffc107;
                --ch-white: #ffc107;
                display: flex;
                align-items: center;
                justify-content: flex-start;
                width: 45px;
                height: 45px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                position: relative;
                overflow: hidden;
                transition-duration: .3s;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.199);
                background-color: var(--af-white);
            }

            .btn-pay-now .sign {
                width: 100%;
                transition-duration: .3s;
                color: #ffc107;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .btn-pay-now .sign svg {
                width: 17px;
            }

            .btn-pay-now .sign svg path {
                fill: var(--night-rider);
            }

            .btn-pay-now .text {
                position: absolute;
                right: 0%;
                width: 0%;
                opacity: 0;
                color: var(--night-rider);
                font-size: 1.2em;
                transition-duration: .3s;
            }

            .btn-pay-now:hover {
                width: 125px;
                border-radius: 5px;
                transition-duration: .3s;
            }

            .btn-pay-now:hover .sign {
                width: 30%;
                transition-duration: .3s;
                padding-left: 20px;
            }

            .btn-pay-now:hover .text {
                opacity: 1;
                width: 70%;
                transition-duration: .3s;
                padding-right: 10px;
            }

        </style>
    </head>
    <body>
        <c:set var="member" value="${sessionScope.MEMBER}" />
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                    <span class="brand-name">Jewelry Auction</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="auctionDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Auctions
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="auctionDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auctions">Upcoming Auctions</a></li>
                                <li><a class="dropdown-item" href="#">Past Auctions</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/valuation">Selling</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/my-upcoming-bids">My Bids</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/response">My Asset</a>
                        </li>
                    </ul>
                    <form class="d-flex" action="${pageContext.request.contextPath}/logout">
                        <button type="submit" class="Btn">
                            <div class="sign">
                                <svg viewBox="0 0 512 512">
                                <path d="M377.9 105.9L500.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L377.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1-128 0c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM160 96L96 96c-17.7 0-32 14.3-32 32l0 256c0 17.7 14.3 32 32 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32l-64 0c-53 0-96-43-96-96L0 128C0 75 43 32 96 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32z"></path>
                                </svg>
                            </div>
                            <div class="text">Logout</div>
                        </button>
                    </form>
                </div>
            </div>
        </nav>
        <div class="container profile-container">
            <div class="profile-header text-center">
                <h2>My Profile</h2>
            </div>
            <div class="profile-content">
                <c:set var="member" value="${sessionScope.MEMBER}" />
                <form action="updateProfile" method="post">
                    <div class="row">
                        <div class="col-md-6">
                            <h4>User Information</h4>
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" value="${member.firstName} ${member.lastName}" required>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="phone" name="phone" value="${member.phoneNumber}" required>
                            </div>
                            <div class="mb-3">
                                <label for="gender" class="form-label">Gender</label>
                                <input type="text" class="form-control" id="gender" name="gender" value="${member.gender}">
                            </div>
                            <div class="mb-3">
                                <label for="DOB" class="form-label">Date of Birth</label>
                                <input type="text" class="form-control" id="DOB" name="DOB" value="${member.DOB}">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <h4>Shipping Address</h4>
                            <div class="mb-3">
                                <label for="streetName" class="form-label">Street Name</label>
                                <input type="text" class="form-control" id="streetName" name="streetName" value="" required>
                            </div>
                            <div class="mb-3">
                                <label for="city" class="form-label">City</label>
                                <input type="text" class="form-control" id="city" name="city" value="" required>
                            </div>
                            <div class="mb-3">
                                <label for="zipCode" class="form-label">Zip Code</label>
                                <input type="text" class="form-control" id="zipCode" name="zipCode" value="" required>
                            </div>
                            <div class="mb-3">
                                <label for="country" class="form-label">Country</label>
                                <input type="text" class="form-control" id="country" name="country" value="" required>
                            </div>
                            <button type="submit" class="btn-update">Update Profile</button>
                        </div>  
                    </div>
                </form>
            </div>
            <div class="section-header">
                <h3>Order History</h3>
            </div>
            <div class="row">
                <c:forEach var="jewelry" items="${requestScope.JEWELRYLIST}">
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                Order #${jewelry.jewelryID}
                            </div>
                            <div class="card-body">
                                <div class="text-center">
                                    <img src="${fn:split(jewelry.photos, ';')[0]}" class="card-img-top" alt="Jewelry Photo">
                                </div>
                                <h5 class="card-title">${jewelry.jewelryName}</h5>
                                <p class="card-text">Date: ${jewelry.date}</p>
                                <p class="card-text">Status: ${jewelry.statusBid}</p>
                                <p class="card-text">Your Bid: $${jewelry.currentBid}</p>
                                <c:if test="${jewelry.statusBid == 'Pending Payment'}">
                                    <form action="${pageContext.request.contextPath}/pay" method="POST">
                                        <input type="hidden" name="memberID" value="${member.memberID}">
                                        <input type="hidden" name="jewelryID" value="${jewelry.jewelryID}">
                                        <input type="hidden" name="jewelryName" value="${jewelry.jewelryName}">
                                        <input type="hidden" name="photo" value="${fn:split(jewelry.photos, ';')[0]}">
                                        <input type="hidden" name="bidAmount" value="${jewelry.currentBid}">
                                        <button type="submit" class="btn-pay-now">
                                            <div class="sign">
                                                <svg viewBox="0 0 512 512">
                                                    <path d="M377.9 105.9L500.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L377.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1-128 0c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM160 96L96 96c-17.7 0-32 14.3-32 32l0 256c0 17.7 14.3 32 32 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32l-64 0c-53 0-96-43-96-96L0 128C0 75 43 32 96 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32z"></path>
                                                </svg>
                                            </div>
                                            <div class="text">Payout</div>
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <footer class="text-center py-4 mt-auto" style="background-color: #000; color: #fff; position: relative; overflow: hidden;">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <h5>Jewelry Auction</h5>
                        <p>Your premier destination for exquisite jewelry and gemstones. Discover the timeless beauty and elegance in our curated collections.</p>
                    </div>
                    <div class="col-md-4">
                        <h5>Quick Links</h5>
                        <ul class="list-unstyled">
                            <li><a href="${pageContext.request.contextPath}/register" style="color: #ffc107;">Register</a></li>
                            <li><a href="${pageContext.request.contextPath}/login" style="color: #ffc107;">Login</a></li>
                            <li><a href="${pageContext.request.contextPath}/auctions" style="color: #ffc107;">Auctions</a></li>
                            <li><a href="${pageContext.request.contextPath}/selling" style="color: #ffc107;">Selling</a></li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h5>Contact Us</h5>
                        <p><i class="fas fa-phone-alt"></i> +849872539999</p>
                        <p><i class="fas fa-envelope"></i> support@jewelryauction.com</p>
                        <p><i class="fas fa-map-marker-alt"></i> 123 Jewelry Street, New York, NY</p>
                        <div class="social-icons mt-3">
                            <a href="#" class="mx-2" style="color: #ffc107; transition: transform 0.3s;"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="mx-2" style="color: #ffc107; transition: transform 0.3s;"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="mx-2" style="color: #ffc107; transition: transform 0.3s;"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="mx-2" style="color: #ffc107; transition: transform 0.3s;"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
                <div class="mt-4">
                    <p>&copy; 2024 Jewelry Auction. All rights reserved.</p>
                </div>
            </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@sweetalert2/11.1.9/dist/sweetalert2.all.min.js"></script>
        <script>
            $(document).ready(function(){
                $(".btn-pay-now").on("click", function(e){
                    e.preventDefault();
                    var form = $(this).closest("form");
                    Swal.fire({
                        title: 'Are you sure?',
                        text: "You are about to proceed with the payment.",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, pay now!'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            form.submit();
                        }
                    });
                });
            });
        </script>
    </body>
</html>
