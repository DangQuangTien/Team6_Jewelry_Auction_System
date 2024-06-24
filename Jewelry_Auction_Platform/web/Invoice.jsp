<!DOCTYPE html>
<html>
<head>
    <title>Jewelry Auction Invoice</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5eded;
            color: #333;
            padding-top: 70px;
            min-height: 100vh;
            position: relative;
            box-sizing: border-box;
        }

        .navbar-dark .navbar-nav .nav-link,
        .navbar-dark .navbar-brand {
            color: #e4af11 !important;
        }

        .navbar-dark .navbar-toggler {
            border-color: #e4af11;
        }

        .navbar-dark .navbar-toggler-icon {
            color: #e4af11;
        }

        .footer {
            background-color: #343a40;
            color: #e4af11;
            padding: 20px 0;
            text-align: center;
            position: absolute;
            bottom: 0;
            width: 100%;
        }

        .footer a {
            color: #e4af11;
            text-decoration: none;
            padding: 0 10px;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        .footer h6 {
            margin: 0;
            padding-bottom: 10px;
            font-size: 1.2em;
        }

        .footer span {
            font-size: 0.9em;
        }

        .container {
            display: flex;
            flex-direction: column;
            padding-top: 20px;
        }

        .invoice-title {
            margin-top: 20px;
            margin-bottom: 20px;
            font-size: 2rem;
            color: #333;
            text-align: center;
        }

        .invoice-table {
            margin-top: 30px;
        }

        .table td, .table th {
            text-align: left;
            vertical-align: middle;
        }

        .details-btn {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .details-btn:hover {
            background-color: #0056b3;
        }

        .card-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 15px;
        }

        .card-text {
            font-size: 1rem;
            margin-bottom: 10px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        .card-icon {
            color: #007bff;
            font-size: 1.2rem;
            margin-right: 10px;
        }

        .print-btn {
            margin-top: 20px;
            font-size: 1.2rem;
        }

        .invoice-header {
            background-color: #e9ecef;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }

        .invoice-header h4 {
            font-size: 1.75rem;
            margin-bottom: 10px;
        }

        .invoice-header p {
            margin: 0;
            font-size: 1.1rem;
        }

        .invoice-section {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .invoice-section h4 {
            font-size: 1.5rem;
            margin-bottom: 20px;
        }

        .invoice-section p {
            font-size: 0.9rem;
            margin-bottom: 10px;
        }

        .main-content {
            display: flex;
            justify-content: space-between;
        }

        .item-list {
            width: 30%;
            max-height: 600px;
            overflow-y: auto;
            padding-right: 20px;
        }

        .item-details, .payment-details, .invoice-summary {
            width: 65%;
        }

        .modal-content {
            border-radius: 8px;
            padding: 20px;
        }

        .modal-header, .modal-body, .modal-footer {
            padding: 15px 20px;
        }

        .modal-title {
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <a class="navbar-brand" href="home.jsp"><i class="fas fa-gem"></i> Jewelry Auctions</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="home.jsp"><i class="fas fa-home"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Auction.jsp"><i class="fas fa-gavel"></i> Auction</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="seller/valuation.jsp"><i class="fas fa-tags"></i> Sell</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="MainController?action=Profile&username="><i class="fas fa-user"></i> Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="notification.jsp" id="bell-icon"><i class="fas fa-bell"></i></a>
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" placeholder="Search for anything" aria-label="Search">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit"><i class="fas fa-search"></i> Search</button>
                </form>
            </div>
        </nav>
    </header>

    <main class="container my-4 flex-grow-1">
        <div class="invoice-header">
            <h4><i class="fas fa-file-invoice"></i> Invoice</h4>
            <p>Jewelry Auctions</p>
            <p>Date: <strong id="invoiceDate"></strong></p>
            <p>Invoice #: <strong id="invoiceID"></strong></p>
        </div>
        <div class="main-content">
            <div class="item-list">
                <h5>Auction Items</h5>
                <ul class="list-group" id="auctionItemList">
                    <!-- Example items -->
                    <li class="list-group-item" data-id="1" data-name="Luxury Watch" data-bid="$800" data-category="Watch" data-shipment="within 30 business days" data-note="Auction fee will also be charged">
                        Luxury Watch - $800
                    </li>
                    <li class="list-group-item" data-id="2" data-name="Diamond Necklace" data-bid="$1500" data-category="Necklace" data-shipment="within 20 business days" data-note="No additional charges">
                        Diamond Necklace - $1500
                    </li>
                    <!-- Additional items can be added dynamically here -->
                </ul>
            </div>
            <div class="item-details">
                <div class="invoice-section">
                    <h4><i class="fas fa-info-circle"></i> Auction Details</h4>
                    <p><i class="fas fa-id-badge card-icon"></i><strong>Auction ID:</strong> <span id="itemAuctionID">N/A</span></p>
                    <p><i class="fas fa-dollar-sign card-icon"></i><strong>Bid:</strong> <span id="itemBid">N/A</span></p>
                    <p><i class="fas fa-tags card-icon"></i><strong>Category:</strong> <span id="itemCategory">N/A</span></p>
                    <p><i class="fas fa-shipping-fast card-icon"></i><strong>Shipment:</strong> <span id="itemShipment">N/A</span></p>
                    <p><i class="fas fa-info-circle card-icon"></i><strong>Note:</strong> <span id="itemNote">N/A</span></p>
                </div>
                <div class="invoice-section payment-details">
                    <h4><i class="fas fa-credit-card"></i> Payment Details</h4>
                    <form>
                        <div class="form-group">
                            <label for="paymentMethod"><i class="fas fa-money-check-alt card-icon"></i>Payment method</label>
                            <select class="form-control" id="paymentMethod">
                                <option>Bank transfer</option>
                                <option>Credit Card</option>
                                <option>PayPal</option>
                                <option>Cryptocurrency</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="shippingAddress"><i class="fas fa-map-marker-alt card-icon"></i>Shipping Address</label>
                            <input type="text" class="form-control" id="shippingAddress" placeholder="Enter your shipping address">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-university card-icon"></i>Our bank information (including fee)</label>
                            <p>Account number : xxxx - xxxx - xxxx - xxxx</p>
                            <p>Account name : Official Platform of Jewelry Auction</p>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-percentage card-icon"></i>Auction Fee</label>
                            <input type="text" class="form-control" id="auctionFee" value="N/A" readonly>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-sticky-note card-icon"></i>Note</label>
                            <p>System will check and notify you when the seller has received the payment.</p>
                        </div>
                        <button type="button" class="btn btn-primary btn-block" id="confirmBtn"><i class="fas fa-check"></i> CONFIRM</button>
                    </form>
                </div>
                <div class="invoice-section invoice-summary">
                    <h4><i class="fas fa-file-invoice-dollar"></i> Invoice Summary</h4>
                    <table class="table table-bordered">
                        <thead class="thead-light">
                            <tr>
                                <th>Description</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody id="invoiceSummary">
                            <tr>
                                <td><i class="fas fa-money-check-alt card-icon"></i>Payment Method</td>
                                <td id="paymentMethodSummary">N/A</td>
                            </tr>
                            <tr>
                                <td><i class="fas fa-map-marker-alt card-icon"></i>Shipping Address</td>
                                <td id="shippingAddressSummary">N/A</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="text-center">
            <button class="btn btn-success details-btn print-btn"><i class="fas fa-print"></i> Print Invoice</button>
        </div>
    </main>

    <!-- START OF FOOTER -->
    <footer class="footer mt-auto py-3 bg-dark text-white text-center">
        <div>
            <h6>Jewelry Auction</h6>
            <a href="register.jsp">Register</a> |
            <a href="login.jsp">Login</a> |
            <a href="#">Help & FAQ</a> |
            <a href="#">Support</a> |
            <a href="#">Sitemap</a>
        </div>
    </footer>
    <!-- END OF FOOTER -->

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Generate invoiceID and invoiceDate
            document.getElementById('invoiceID').innerText = 'INV' + Math.floor(Math.random() * 1000000);
            document.getElementById('invoiceDate').innerText = new Date().toLocaleDateString();

            // Confirm button functionality
            document.getElementById('confirmBtn').addEventListener('click', function() {
                const paymentMethod = document.getElementById('paymentMethod').value;
                const shippingAddress = document.getElementById('shippingAddress').value;

                document.getElementById('paymentMethodSummary').innerText = paymentMethod;
                document.getElementById('shippingAddressSummary').innerText = shippingAddress;
            });

            // Show item details and update fields when item is clicked
            document.querySelectorAll('#auctionItemList .list-group-item').forEach(item => {
                item.addEventListener('click', function() {
                    const itemId = this.getAttribute('data-id');
                    const itemName = this.getAttribute('data-name');
                    const itemBid = this.getAttribute('data-bid');
                    const itemCategory = this.getAttribute('data-category');
                    const itemShipment = this.getAttribute('data-shipment');
                    const itemNote = this.getAttribute('data-note');

                    // Update Auction Details
                    document.getElementById('itemAuctionID').innerText = itemId;
                    document.getElementById('itemBid').innerText = itemBid;
                    document.getElementById('itemCategory').innerText = itemCategory;
                    document.getElementById('itemShipment').innerText = itemShipment;
                    document.getElementById('itemNote').innerText = itemNote;

                    // Update Auction Fee
                    const auctionFee = (parseFloat(itemBid.replace('$', '')) * 0.1).toFixed(2);
                    document.getElementById('auctionFee').value = `10% of the final bid price = $${auctionFee}`;
                });
            });
        });
    </script>
</body>
</html>
