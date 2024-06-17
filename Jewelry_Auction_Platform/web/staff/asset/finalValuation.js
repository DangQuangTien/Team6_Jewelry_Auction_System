function confirmLogout(event) {
    if (!confirm("Are you sure you want to log out?")) {
        event.preventDefault();
    }
}

function confirmAuction(event) {
    if (!confirm("Are you sure you want to send the final valuation?")) {
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
    if (!confirm('Are you sure you want to send this final price?')) {
        event.preventDefault();
    }
}

function confirmLogout(event) {
    if (!confirm('Are you sure you want to log out?')) {
        event.preventDefault();
    }
}