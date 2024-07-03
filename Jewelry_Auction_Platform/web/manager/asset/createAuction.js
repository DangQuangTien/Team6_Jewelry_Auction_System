
function confirmCreate(event) {
    event.preventDefault(); // Prevent the form from submitting immediately

    // Using SweetAlert for confirmation
    Swal.fire({
        title: 'Are you sure?',
        text: 'You are about to create an auction.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, create it!'
    }).then((result) => {
        if (result.isConfirmed) {
            // If confirmed, show success alert
            Swal.fire({
                title: 'Auction created successfully!',
                icon: 'success',
                confirmButtonText: 'OK'
            }).then(() => {
                // Optionally submit the form or perform the desired action after success alert
                // For example, you can submit the form programmatically
                document.getElementById('createForm').submit();
            });
        }
    });
}



var selectedJewelryIDs = [];

function handleCheckboxChange(checkbox) {
    var jewelryID = checkbox.value;
    if (checkbox.checked) {
        selectedJewelryIDs.push(jewelryID);
    } else {
        var index = selectedJewelryIDs.indexOf(jewelryID);
        if (index !== -1) {
            selectedJewelryIDs.splice(index, 1);
        }
    }
}

function updateSelectedJewelryIDs() {
    var selectedJewelryIDsInput = document.getElementById('selectedJewelryIDsInput');
    selectedJewelryIDsInput.value = selectedJewelryIDs.join(',');
}

function goToPage(page) {
    document.getElementById('page').value = page;
    document.getElementById('paginationForm').submit();
}

function showJewelryDetails(jewelry) {
    document.getElementById('modalJewelryName').innerText = jewelry.jewelryName;
    document.getElementById('modalArtist').innerText = jewelry.artist;
    document.getElementById('modalCirca').innerText = jewelry.circa;
    document.getElementById('modalMaterial').innerText = jewelry.material;
    document.getElementById('modalDial').innerText = jewelry.dial;
    document.getElementById('modalBraceletMaterial').innerText = jewelry.braceletMaterial;
    document.getElementById('modalCaseDimensions').innerText = jewelry.caseDimensions;
    document.getElementById('modalBraceletSize').innerText = jewelry.braceletSize;
    document.getElementById('modalSerialNumber').innerText = jewelry.serialNumber;
    document.getElementById('modalReferenceNumber').innerText = jewelry.referenceNumber;
    document.getElementById('modalCaliber').innerText = jewelry.caliber;
    document.getElementById('modalMovement').innerText = jewelry.movement;
    document.getElementById('modalCondition').innerText = jewelry.condition;
    document.getElementById('modalMetal').innerText = jewelry.metal;
    document.getElementById('modalGemstones').innerText = jewelry.gemstones;
    document.getElementById('modalMeasurements').innerText = jewelry.measurements;
    document.getElementById('modalWeight').innerText = jewelry.weight;
    document.getElementById('modalStamped').innerText = jewelry.stamped;
    document.getElementById('modalRingSize').innerText = jewelry.ringSize;
    document.getElementById('modalMinPrice').innerText = jewelry.minPrice;
    document.getElementById('modalMaxPrice').innerText = jewelry.maxPrice;

    var modal = new bootstrap.Modal(document.getElementById('jewelryModal'));
    modal.show();
}