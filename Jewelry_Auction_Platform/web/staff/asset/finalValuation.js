
function confirmUpdate(event) {
    if (!confirm("Are you sure you want to update user information?")) {
        event.preventDefault();
    }
}


function confirmDelete(event) {
    if (!confirm("Are you sure you want to delete this user?")) {
        event.preventDefault();
    }
}
function toggleApprovalTable() {
    var table = document.getElementById("approvalTable");
    if (table.style.display === "none" || table.style.display === "") {
        table.style.display = "table";
    } else {
        table.style.display = "none";
    }
}


function confirmAuction(event) {
    event.preventDefault(); // Prevent form submission initially

    Swal.fire({
        title: 'Confirmation',
        html: 'Are you sure you want to send the final price?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Yes, send it!',
        cancelButtonText: 'No'
    }).then((result) => {
        if (result.isConfirmed) {
            // Manually submit the form if confirmed
            event.target.submit();
        }
    });
}
