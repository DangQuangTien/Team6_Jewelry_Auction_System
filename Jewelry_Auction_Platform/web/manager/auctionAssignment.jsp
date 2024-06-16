$(document).ready(function() { var table = $('#myTable').DataTable(); $('#myTable tbody').on('dblclick', 'tr', function() { var data = table.row(this).data(); $('#modal-body').html('You clicked on ' + data[0] + '\'s row'); $('#myModal').modal('show');
}); });
<link rel="stylesheet" href="../admin/style/styles.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/searchpanes/2.3.1/css/searchPanes.bootstrap5.css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/2.0.2/css/select.bootstrap5.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>

</head>

<body>
    <div class=" container-fluid ">
        <div class="row ">
            <div class="col-2 d-flex flex-column justify-content-between bg-dark min-vh-100 sidebar ">
                <div class="mt-4 ">
                    <a href=" " class="text-white text-decoration-none d-flex align-items-center justify-content-center sidebar-logo " role="button ">
                        <img src="../images/logo/auction_jewelry.png " alt="Logo ">
                    </a>
                    <hr class="text-white d-none d-sm-block " />
                    <ul class="nav nav-pills flex-column mt-4 mt-sm-0" id="menu">
                        <li class="nav-item mb-0 my-sm-0 my-0" id="dashboard">
                            <a class="nav-link text-white" href="manager.jsp" aria-current="page">
                                <i class="fas fa-tachometer-alt"></i>
                                <span class="ms-2 d-none d-sm-inline">Assignment Table</span>
                            </a>
                        </li>

                    </ul>
                </div>

            </div>
            <main class="col-10 main-content m-0 p-0 ">
                <div class="bg-dark w-100 d-flex justify-content-between ">
                    <div class="title navbar ">
                        <h2 class="text-white ps-4 ">Assignment Table</h2>
                    </div>
                    <div class="dropdown me-5">
                        <a class="btn border-none outline-none text-white dropdown-toggle " type="button " id="triggerId " data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-user "></i>
                            <h6 class="text-white ms-2 d-none d-sm-inline">Admin</h6>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="triggerId">
                            <a class="dropdown-item" href="managerProfile.jsp">Profile</a>
                            <a class="dropdown-item" href="#">Change Password</a>
                            <a class="dropdown-item" href="#">Logout</a>
                        </div>
                    </div>
                </div>
                <div class="container light-style flex-grow-1 container-p-y ">
                    <h4 class="font-weight-bold py-3 mb-2 ">
                        Assignment Table
                    </h4>
                    <div>
                        <table id="myTable" class="display">
                            <thead>
                                <tr>
                                    <th>Recipient ID</th>
                                    <th>Auction ID</th>
                                    <th>Auction Name</th>
                                    <th>Aution Brand</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>RP-123</td>
                                    <td>Au-123</td>
                                    <td>Sapphire Ring in 14k White Gold Product</td>
                                    <td>Mikimoto</td>
                                    <td class="text-pending">Pending</td>
                                </tr>
                                <tr>
                                    <td>RP-234</td>
                                    <td>Au-234</td>
                                    <td>Sapphire Ring in 14k White Gold Product</td>
                                    <td>Mikimoto</td>
                                    <td class="text-pending">Pending</td>
                                </tr>
                                <tr>
                                    <td>RP-345</td>
                                    <td>Au-345</td>
                                    <td>Sapphire Ring in 14k White Gold Product</td>
                                    <td>Mikimoto</td>
                                    <td class="text-pending">Pending</td>
                                </tr>
                                <tr>
                                    <td>RP-456</td>
                                    <td>Au-456</td>
                                    <td>Sapphire Ring in 14k White Gold Product</td>
                                    <td>Mikimoto</td>
                                    <td class="text-received">Conplete</td>
                                </tr>
                                <tr>
                                    <td>RP-567</td>
                                    <td>Au-567</td>
                                    <td>Sapphire Ring in 14k White Gold Product</td>
                                    <td>Mikimoto</td>
                                    <td class="text-received">Conplete</td>
                                </tr>
                                <tr>
                                    <td>RP-789</td>
                                    <td>Au-789</td>
                                    <td>Sapphire Ring in 14k White Gold Product</td>
                                    <td>Mikimoto</td>
                                    <td class="text-pending">Pending</td>
                                </tr>
                                <tr>
                                    <td>RP-890</td>
                                    <td>Au-890</td>
                                    <td>Sapphire Ring in 14k White Gold Product</td>
                                    <td>Mikimoto</td>
                                    <td class="text-todo">Todo</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- Hiện thị Popup/Modal/Dialog  -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="myModalLabel">Chi tiết phân công</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="$('#myModal').modal('hide');">
                    <span aria-hidden="true">&times;</span>
                </button>
                            </div>
                            <div class="modal-body" id="modal-body">
                                <div class="d-flex justify-content-between">
                                    <span class="text-start">Tên người quản lí: </span>
                                    <span class="text-start">Nguyễn Thành Tài - Mã người quản lí</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="text-start">Tên người nhận việc: </span>
                                    <span class="text-start">Võ Việt Thắng - Mã nhân viên</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="text-start">Mã trang sức: </span>
                                    <span class="text-start">Au-567</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="text-start">Tên trang sức: </span>
                                    <span class="text-start">Sapphire Ring in 14k White Gold Product</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="text-start">Trạng thái: </span>
                                    <span class="text-start">Complete</span>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="$('#myModal').modal('hide');">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script>
        $(document).ready(function() {
            $('#myTable').DataTable();
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r " crossorigin="anonymous "></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+ " crossorigin="anonymous "></script>
    <script>
        var url = window.location.href;
        var navItems = document.querySelectorAll('.nav-item');

        navItems.forEach(function(navItem) {
            navItem.classList.remove('active');
        });

        if (url.includes('admin.jsp')) {
            document.getElementById('dashboard').classList.add('active');
        } else if (url.includes('userManagement.jsp')) {
            document.getElementById('userManagement').classList.add('active');
        }
        // Hàm sử lí show modal/dialog/popup
        $(document).ready(function() {
            var table = $('#myTable').DataTable();
            //Hàm show
            $('#myTable tbody').on('dblclick', 'tr', function() {
                var data = table.row(this).data();
                $('#myModal').modal('show');
            });
            //Tắt modal/dialog/popup
            $('#myModal').modal('hide');
        });
    </script>
</body>
<form action="${pageContext.request.contextPath}/MainController" method="POST" onsubmit="confirmLogout(event)">
    <input type="submit" name="action" value="Log out">
</form>

</html>