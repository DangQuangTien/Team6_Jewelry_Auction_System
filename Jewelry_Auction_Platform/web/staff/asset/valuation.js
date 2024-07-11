function showFormFields() {
    var category = document.getElementById('category').value;
    var watchFields = document.getElementById('watchFields');
    var braceletFields = document.getElementById('braceletFields');

    watchFields.classList.add('d-none');
    braceletFields.classList.add('d-none');

    if (category === 'watch') {
        watchFields.classList.remove('d-none');
    } else if (category === 'bracelet') {
        braceletFields.classList.remove('d-none');
    }
}

document.addEventListener("DOMContentLoaded", function () {
    showFormFields();
});

function showFormFields() {
    const categorySelect = document.getElementById("category");
    const watchFields = document.getElementById("watchFields");
    const braceletFields = document.getElementById("braceletFields");

    // Hide all sections initially
    watchFields.style.display = "none";
    braceletFields.style.display = "none";

    // Get the selected category
    const selectedCategory = categorySelect.options[categorySelect.selectedIndex].text;

    // Show relevant fields based on category
    if (selectedCategory.toLowerCase().includes("watch")) {
        watchFields.style.display = "block";
    } else if (selectedCategory.toLowerCase().includes("bracelet")) {
        braceletFields.style.display = "block";
    } else {
        braceletFields.style.display = "block";
    }
}

function confirmValuation(event) {
    event.preventDefault(); // Prevent default form submission initially

    Swal.fire({
        title: 'Are you sure?',
        text: "Are you certain you want to send this appraisal?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, send it!'
    }).then((result) => {
        if (result.isConfirmed) {
            // Proceed with form submission
            document.getElementById('valuationForm').submit(); // Submit the form
        } else {
            // If not confirmed, you may choose to do something here, like show another message or just return
        }
    });
}
function cancelValuation() {
    window.history.back();
}

function confirmValuation(event) {
    event.preventDefault(); // Prevent default form submission initially

    Swal.fire({
        title: 'Are you sure?',
        text: "Are you certain you want to send this appraisal?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, send it!'
    }).then((result) => {
        if (result.isConfirmed) {
            // Proceed with form submission
            document.getElementById('valuationForm').submit(); // Submit the form
        } else {
            // If not confirmed, you may choose to do something here, like show another message or just return
        }
    });
}

