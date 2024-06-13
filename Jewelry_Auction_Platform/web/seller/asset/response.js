function fetchJewelryData() {
    $.ajax({
        url: '${pageContext.request.contextPath}/UpdateJewelryServlet',
        type: 'GET',
        success: function (data) {
            var tableBody = $('#jewelryTableBody');
            tableBody.empty();

            if (data.length === 0) {
                $('.no-jewelry').removeClass('hidden');
                $('#jewelryTable').addClass('hidden');
            } else {
                $('.no-jewelry').addClass('hidden');
                $('#jewelryTable').removeClass('hidden');

                data.forEach(function (jewelry) {
                    var photos = jewelry.photos.split(";");
                    var status = jewelry.status;
                    var finalPrice = (jewelry.final_Price != null) ? jewelry.final_Price : "Updating";
                    var statusText = '';

                    if (status === 'Re-Evaluated') {
                        statusText = '<td style="color: red">' + finalPrice + '</td><td class="text-danger">Waiting for shipment</td>';
                    } else if (status === 'Received') {
                        statusText = '<td style="color: red">' + finalPrice + '</td><td style="color: green">Received</td>';
                    } else if (status === 'Pending Confirm') {
                        statusText = '<td style="color: red">' + finalPrice + '</td><td style="color: green"><strong>Pending Confirm</strong><br>' +
                                '<form action="${pageContext.request.contextPath}/MainController"><input type="hidden" name="jewelryID" value="' + jewelry.jewelryID + '"><input type="submit" name="action" value="Confirm"></form><br>' +
                                '<form action="${pageContext.request.contextPath}/MainController"><input type="hidden" name="jewelryID" value="' + jewelry.jewelryID + '"><input type="submit" name="action" value="Reject"></form></td>';
                    } else if (status === 'Confirmed') {
                        statusText = '<td style="color: red">' + finalPrice + '</td><td style="color: red">Ready To Auction</td>';
                    } else {
                        statusText = '<td style="color: red">Updating</td><td style="color: red">In Progress</td>';
                    }

                    tableBody.append(
                            '<tr>' +
                            '<td><img class="img-fluid" src="${pageContext.request.contextPath}/' + photos[0] + '" alt="Jewelry Image"></td>' +
                            '<td>' + jewelry.jewelryName + '</td>' +
                            '<td>' + jewelry.artist + '</td>' +
                            '<td>' + jewelry.circa + '</td>' +
                            '<td>' + jewelry.material + '</td>' +
                            '<td>' + jewelry.dial + '</td>' +
                            '<td>' + jewelry.braceletMaterial + '</td>' +
                            '<td>' + jewelry.caseDimensions + '</td>' +
                            '<td>' + jewelry.braceletSize + '</td>' +
                            '<td>' + jewelry.serialNumber + '</td>' +
                            '<td>' + jewelry.referenceNumber + '</td>' +
                            '<td>' + jewelry.caliber + '</td>' +
                            '<td>' + jewelry.movement + '</td>' +
                            '<td>' + jewelry.condition + '</td>' +
                            '<td>' + jewelry.metal + '</td>' +
                            '<td>' + jewelry.gemstones + '</td>' +
                            '<td>' + jewelry.measurements + '</td>' +
                            '<td>' + jewelry.weight + '</td>' +
                            '<td>' + jewelry.stamped + '</td>' +
                            '<td>' + jewelry.ringSize + '</td>' +
                            '<td>' + jewelry.minPrice + '</td>' +
                            '<td>' + jewelry.maxPrice + '</td>' +
                            '<td>' + jewelry.temp_Price + '</td>' +
                            statusText +
                            '</tr>'
                            );
                });
            }
        },
        error: function () {
            console.error('Failed to fetch jewelry data');
        }
    });
}

$(document).ready(function () {
    // Fetch jewelry data initially
    fetchJewelryData();

    // Set interval to fetch jewelry data periodically (every minute)
    setInterval(fetchJewelryData, 5000);
});