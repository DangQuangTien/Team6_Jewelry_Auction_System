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

$(document).ready(function() {
    $('[data-toggle="modal"]').on('click', function() {
        var targetModal = $(this).data('target');
        $(targetModal).modal('show');
    });
});

$(document).ready(function() {
    $('.btn-info').click(function() {
        var targetModal = $(this).data('target');
        $(targetModal).modal('show');
    });
});

