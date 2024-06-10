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

function showDetails(jewelryID) {    
    var jewelry = jewelryDetails[jewelryID];

    document.getElementById('circa').innerText = jewelry.circa;
    document.getElementById('material').innerText = jewelry.material;
    document.getElementById('dial').innerText = jewelry.dial;
    document.getElementById('braceletMaterial').innerText = jewelry.braceletMaterial;
    document.getElementById('caseDimensions').innerText = jewelry.caseDimensions;
    document.getElementById('braceletSize').innerText = jewelry.braceletSize;
    document.getElementById('serialNumber').innerText = jewelry.serialNumber;
    document.getElementById('referenceNumber').innerText = jewelry.referenceNumber;
    document.getElementById('caliber').innerText = jewelry.caliber;
    document.getElementById('movement').innerText = jewelry.movement;
    document.getElementById('condition').innerText = jewelry.condition;
    document.getElementById('metal').innerText = jewelry.metal;
    document.getElementById('gemstones').innerText = jewelry.gemstones;
    document.getElementById('measurements').innerText = jewelry.measurements;
    document.getElementById('weight').innerText = jewelry.weight;
    document.getElementById('stamped').innerText = jewelry.stamped;
    document.getElementById('ringSize').innerText = jewelry.ringSize;
    document.getElementById('finalPrice').value = jewelry.finalPrice;
    document.getElementById('jewelryID').value = jewelryID;
}

function toggleDetails(button) {
    var row = button.closest('tr').nextElementSibling;
    if (row.style.display === 'none' || row.style.display === '') {
        row.style.display = 'table-row';
        button.textContent = 'Hide Details';
    } else {
        row.style.display = 'none';
        button.textContent = 'Show Details';
    }
}