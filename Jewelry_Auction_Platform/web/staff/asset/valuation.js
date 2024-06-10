
function showFormFields() {
    var category = document.getElementById("category").value;
    var watchFields = document.getElementById("watchFields");
    var braceletFields = document.getElementById("braceletFields");

    watchFields.style.display = "none";
    braceletFields.style.display = "none";

    if (category === "category9") {
        watchFields.style.display = "block";
    } else {
        braceletFields.style.display = "block";
    }
}
window.onload = function () {
    showFormFields();
}

function confirmValuation(event) {
    if (!confirm("Are you certain you want to send this appraisal?")) {
        event.preventDefault();
    }
}
function cancelValuation() {
    if (confirm("Are you sure you want to cancel this appraisal?")) {
        window.location.href = "${pageContext.request.contextPath}/ProcessValuationRequest";
    }
}
