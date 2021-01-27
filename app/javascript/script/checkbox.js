document.addEventListener("turbolinks:load", () => {

    const input = document.querySelector(".input_check")
    input.type = "hidden"
    const check_box = document.querySelector('.choice_item_input input[type="checkbox"]');
    if (check_box !== null) {
        check_box.addEventListener('click', function() {
            if (check_box.checked == true) {
                input.type = "text"
                input.focus();
            } else {
                input.type = "hidden"
            }
        })
    }

    const radio_box = document.querySelector('.choice_item_input input[type="radio"]');
    const radio_rmbox1 = document.querySelector('.input_rm1 input[type="radio"]');
    const radio_rmbox2 = document.querySelector('.input_rm2 input[type="radio"]');
    if (radio_box !== null) {

        radio_box.addEventListener('click', function() {
            input.type = "text"
            input.focus();
        })
        radio_rmbox1.addEventListener('click', function() {
            input.type = "hidden"
        })
        radio_rmbox2.addEventListener('click', function() {
            input.type = "hidden"
        })
    }

    const source_box = document.querySelector('.source_select_all input[type="checkbox"]')
    const source_btn = document.querySelectorAll('.source_btn input[type="checkbox"]')

    source_box.addEventListener('click', function() {
        if (source_box.checked == "") {
            source_btn[1].checked = ""
            source_btn[2].checked = ""
        } else {
            source_btn[1].checked = "checked"
            source_btn[2].checked = "checked"
        }
    })

    source_btn[1].addEventListener('click', function() {
        source_box.checked = ""
    })
    source_btn[2].addEventListener('click', function() {
        source_box.checked = ""
    })

    const type_box = document.querySelector('.type_select_all input[type="checkbox"]')
    const type_btn = document.querySelectorAll('.type_btn input[type="checkbox"]')

    type_box.addEventListener('click', function() {
        if (type_box.checked == "") {
            type_btn[1].checked = ""
            type_btn[2].checked = ""
        } else {
            type_btn[1].checked = "checked"
            type_btn[2].checked = "checked"
        }
    })

    type_btn[1].addEventListener('click', function() {
        type_box.checked = ""
    })
    type_btn[2].addEventListener('click', function() {
        type_box.checked = ""
    })




    const btn = document.querySelector('.check');
    btn.addEventListener('click', function(e) {
        btn.classList.remove("search_btn")
        btn.classList.add("active")
        const theme_radio_len = document.querySelectorAll('.theme_btn input[type="radio"]:checked').length
        const theme_checkbox_len = document.querySelectorAll('.theme_btn input[type="checkbox"]:checked').length
        const theme_checkbox_input_len = document.querySelectorAll('.choice_item_input input[type="checkbox"]:checked').length
        const time_check = document.querySelectorAll('.time_btn input[type="text"]')
        const input_check = document.querySelectorAll('.theme_btn input[type="text"]')
        const source_len = document.querySelectorAll('.source_btn input[type="checkbox"]:checked').length
        const type_len = document.querySelectorAll('.type_btn input[type="checkbox"]:checked').length
        let time_len = 0
        for (var i = 0; i < time_check.length; i++) {
            if (time_check[i].value == '') {

            } else {
                time_len += 1
            }
        }
        let input_len = 0
        for (var i = 0; i < input_check.length; i++) {
            if (input_check[i].value == '') {

            } else {
                input_len += 1
            }
        }

        if (input.type == "hidden") {
            if ((theme_radio_len > 0 || theme_checkbox_len > 1) && time_len == time_check.length && source_len > 0 && type_len > 0) {

            } else {
                e.preventDefault();
                theme_radio_len < 1 && theme_checkbox_len < 2 ? validateremove("validate_theme") : validateadd("validate_theme");
                time_len < time_check.length ? validateremove("validate_time") : validateadd("validate_time");
                source_len < 1 ? validateremove("validate_source") : validateadd("validate_source");
                type_len < 1 ? validateremove("validate_type") : validateadd("validate_type");
            }
        } else if (input.type == "text") {
            if ((theme_radio_len > 0 || theme_checkbox_len > 1 && input_len > 0) && time_len == time_check.length && source_len > 0 && type_len > 0) {

            } else {
                e.preventDefault()
                theme_radio_len < 1 && (theme_checkbox_len < 2 || input_len < 1) ? validateremove("validate_theme") : validateadd("validate_theme");
                time_len < time_check.length ? validateremove("validate_time") : validateadd("validate_time");
                source_len < 1 ? validateremove("validate_source") : validateadd("validate_source");
                type_len < 1 ? validateremove("validate_type") : validateadd("validate_type");
            }
        }

        function validateremove(title) {
            const vld_d = document.getElementById(`${title}`)
            vld_d.classList.remove("disable")
            vld_d.classList.add("alert")
            btn.classList.add("search_btn")
            btn.classList.remove("active")
        }

        function validateadd(title) {
            const vld_d = document.getElementById(`${title}`)
            vld_d.classList.remove("alert")
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