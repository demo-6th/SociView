document.addEventListener("turbolinks:load", () => {
    const btn = document.querySelector('.check');
    btn.addEventListener('click', function(e) {
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

        theme_radio_len < 1 && theme_checkbox_len < 1 ? validateremove("validate_theme") : validateadd("validate_theme");
        time_len < time_check.length ? validateremove("validate_time") : validateadd("validate_time");
        source_len < 1 ? validateremove("validate_source") : validateadd("validate_source");
        type_len < 1 ? validateremove("validate_type") : validateadd("validate_type");


        function validateremove(title) {
            const vld_d = document.getElementById(`${ title }`)
            vld_d.classList.remove("disable"), e.preventDefault()
        }

        function validateadd(title) {
            const vld_d = document.getElementById(`${ title }`)
            vld_d.classList.add("disable")
        }
    })
})