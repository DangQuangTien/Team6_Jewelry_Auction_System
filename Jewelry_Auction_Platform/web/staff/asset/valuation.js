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