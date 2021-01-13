document.addEventListener("turbolinks:load", () => {
    var btn = document.querySelector('.check');
    var msg = document.getElementById('checkedValue');
    btn.addEventListener('click', function() {

        var len = document.querySelectorAll('.checkbox input[type="checkbox"]:checked').length
        if (len <= 0) {
            msg.innerHTML = < p class = "bg-red-300 text-center" > 請至少選一個 < /p>;
        } else {
            return
        }
    })





})