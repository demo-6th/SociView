document.addEventListener("turbolinks:load", () => {
    const btn = document.querySelector('.check');
    const msg = document.getElementById('checkedValue');
    btn.addEventListener('click', function(e) {
        // e.preventDefault();
        const theme_radio_len = document.querySelectorAll('.theme_btn input[type="radio"]:checked').length
        const theme_checkbox_len = document.querySelectorAll('.theme_btn input[type="checkbox"]:checked').length
        const time_check = document.querySelectorAll('.time_btn input[type="text"]')
        const source_len = document.querySelectorAll('.source_btn input[type="checkbox"]:checked').length
        const type_len = document.querySelectorAll('.type_btn input[type="checkbox"]:checked').length
        let time_len = 0
        for (var i = 0; i < time_check.length; i++) {
            if (time_check[i].value == '') {

            } else {
                time_len += 1
            }
        }

        theme_radio_len < 1 && theme_checkbox_len < 1 ? (myFunction("主題"), e.preventDefault()) : '';
        time_len < time_check.length ? (myFunction("時間"), e.preventDefault()) : '';
        source_len < 1 ? (myFunction("來源"), e.preventDefault()) : '';
        type_len < 1 ? (myFunction("文本"), e.preventDefault()) : '';

        function myFunction(title) {
            alert(`${title}未填`);
            //     msg.innerHTML = < p class = "bg-red-300 text-center" > 請至少選一個 < /p>;
        }
    })
})