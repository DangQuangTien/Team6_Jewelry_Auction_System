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

function confirmLogout(event) {
    if (!confirm('Are you sure you want to log out?')) {
        event.preventDefault();
    }
}

function confirmValuation(event) {
    if (!confirm('Are you sure you want to submit this valuation?')) {
        event.preventDefault();
    }
}

function cancelValuation() {
    window.history.back();
}

function confirmValuation(event) {
    if (!confirm("Are you certain you want to send this appraisal?")) {
        event.preventDefault();
    }
}


