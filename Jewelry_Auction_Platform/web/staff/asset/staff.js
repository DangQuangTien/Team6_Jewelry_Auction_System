function confirmLogout(event) {
    event.preventDefault(); // Prevent the default action initially

    Swal.fire({
        title: 'Log Out',
        text: 'Are you sure you want to log out?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, log out',
        cancelButtonText: 'Cancel'
    }).then((result) => {
        if (result.isConfirmed) {
            // If confirmed, proceed with the action
            window.location.href = event.target.href; // or any specific logout logic
        }
    });
}


function confirmReceipt(event) {
    event.preventDefault(); // Prevent the default action initially

    Swal.fire({
        title: 'Confirm Receipt',
        text: 'Are you sure you want to confirm the receipt?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, confirm',
        cancelButtonText: 'Cancel'
    }).then((result) => {
        if (result.isConfirmed) {
            // If confirmed, proceed with the form submission or action
            event.target.submit(); // for form submission
        }
    });
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
