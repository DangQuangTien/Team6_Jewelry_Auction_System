$(document).ready(function () {
    // Get the modal
    var modal = document.getElementById("jewelryModal");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    // Event listener for view buttons
    $(document).on('click', '.view-details', function () {
        var details = $(this).data('details');
        var detailsHtml = '<table class="table table-striped">' +
            '<tr><th>Jewelry Name</th><td>' + details.name + '</td></tr>' +
            '<tr><th>Photo</th><td><img class="img-fluid" src="' + details.photo + '" alt="Jewelry Image"></td></tr>' +
            '<tr><th>Artist</th><td>' + details.artist + '</td></tr>' +
            '<tr><th>Circa</th><td>' + details.circa + '</td></tr>' +
            '<tr><th>Material</th><td>' + details.material + '</td></tr>' +
            '<tr><th>Dial</th><td>' + details.dial + '</td></tr>' +
            '<tr><th>Bracelet Material</th><td>' + details.braceletMaterial + '</td></tr>' +
            '<tr><th>Case Dimensions</th><td>' + details.caseDimensions + '</td></tr>' +
            '<tr><th>Bracelet Size</th><td>' + details.braceletSize + '</td></tr>' +
            '<tr><th>Serial Number</th><td>' + details.serialNumber + '</td></tr>' +
            '<tr><th>Reference Number</th><td>' + details.referenceNumber + '</td></tr>' +
            '<tr><th>Caliber</th><td>' + details.caliber + '</td></tr>' +
            '<tr><th>Movement</th><td>' + details.movement + '</td></tr>' +
            '<tr><th>Condition</th><td>' + details.condition + '</td></tr>' +
            '<tr><th>Metal</th><td>' + details.metal + '</td></tr>' +
            '<tr><th>Gemstones</th><td>' + details.gemstones + '</td></tr>' +
            '<tr><th>Measurements</th><td>' + details.measurements + '</td></tr>' +
            '<tr><th>Weight</th><td>' + details.weight + '</td></tr>' +
            '<tr><th>Stamped</th><td>' + details.stamped + '</td></tr>' +
            '<tr><th>Ring Size</th><td>' + details.ringSize + '</td></tr>' +
            '<tr><th>Min Price</th><td>' + details.minPrice + '</td></tr>' +
            '<tr><th>Max Price</th><td>' + details.maxPrice + '</td></tr>' +
            '<tr><th>Temporary Price</th><td>' + details.tempPrice + '</td></tr>' +
            '<tr><th>Final Price</th><td>' + details.finalPrice + '</td></tr>' +
            '<tr><th>Status</th><td>' + details.status + '</td></tr>' +
            '</table>';

        $('#jewelryDetails').html(detailsHtml);
        modal.style.display = "block";
    });
});