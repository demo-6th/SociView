document.addEventListener("turbolinks:load", () => {
    const btn = document.querySelector('.check');
    btn.addEventListener('click', function(e) {
        btn.classList.remove("search_btn")
        btn.classList.add("active")
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

        if ((theme_radio_len > 0 || theme_checkbox_len > 1) && time_len == time_check.length && source_len > 0 && type_len > 0) {

        } else {
            e.preventDefault();
            theme_radio_len < 1 && theme_checkbox_len < 2 ? validateremove("validate_theme") : validateadd("validate_theme");
            time_len < time_check.length ? validateremove("validate_time") : validateadd("validate_time");
            source_len < 1 ? validateremove("validate_source") : validateadd("validate_source");
            type_len < 1 ? validateremove("validate_type") : validateadd("validate_type");
        }

        function validateremove(title) {
            const vld_d = document.getElementById(`${title}`)
            vld_d.classList.remove("disable")
            btn.classList.add("search_btn")
            btn.classList.remove("active")
        }

        function validateadd(title) {
            const vld_d = document.getElementById(`${title}`)
            vld_d.classList.add("disable")
        }

    })

    //套件預設不可滑動頁面，使用absolute定位，render進來後造成文字錯位
    //抓取DOM狀態
    document.onreadystatechange = subSomething;

    function subSomething() {
        if (document.readyState == "complete") {
            //DOM載入完成後抓取text內的(2)
            var aTags = document.getElementsByTagName("text");
            var searchText = "(2)";
            var found;
            for (var i = 0; i < aTags.length; i++) {
                if (aTags[i].textContent == searchText) {
                    found = aTags[i];
                    //重新定位
                    found.style.position = "relative"
                    found.style.bottom = "30px"
                    found.style.left = "200px"
                    break;
                }
            }
        }
    }
})