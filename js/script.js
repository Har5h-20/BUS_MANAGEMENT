// Display a confirmation dialog before submitting a form
document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById("myForm");

    form.addEventListener("submit", function(event) {
        event.preventDefault(); // Prevent the form from submitting immediately

        const confirmation = confirm("Are you sure you want to submit this form?");
        
        if (confirmation) {
            // If the user confirms, submit the form
            this.submit();
        } else {
            // If the user cancels, do nothing
            return false;
        }
    });
});
