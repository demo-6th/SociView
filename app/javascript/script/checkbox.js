document.addEventListener("turbolinks:load", () => {
    const input = document.querySelector(".input_check");
    input.type = "hidden";
    const check_box = document.querySelector(
        '.check_item_input input[type="checkbox"]'
    );
    if (check_box !== null) {
        check_box.addEventListener("click", function() {
            if (check_box.checked == true) {
                input.type = "text";
                input.focus();
            } else {
                input.type = "hidden";
            }
        });
    }

    const radio_box = document.querySelector(
        '.radio_item_input input[type="radio"]'
    );
    const radio_rmbox1 = document.querySelector('.input_rm1 input[type="radio"]');
    const radio_rmbox2 = document.querySelector('.input_rm2 input[type="radio"]');
    if (radio_box !== null) {
        radio_box.addEventListener("click", function() {
            input.type = "text";
            input.focus();
            radio_rmbox1.checked = false;
            radio_rmbox2.checked = false;
        });
        radio_rmbox1.addEventListener("click", function() {
            input.type = "hidden";
            radio_rmbox2.checked = false;
            radio_box.checked = false;
        });
        radio_rmbox2.addEventListener("click", function() {
            input.type = "hidden";
            radio_rmbox1.checked = false;
            radio_box.checked = false;
        });
    }

    const source_box = document.querySelector(
        '.source_select_all input[type="checkbox"]'
    );
    const source_btn = document.querySelectorAll(
        '.source_btn input[type="checkbox"]'
    );
    source_box.addEventListener("click", function() {
        if (source_box.checked == "") {
            source_btn[1].checked = "";
            source_btn[2].checked = "";
        } else {
            source_btn[1].checked = "checked";
            source_btn[2].checked = "checked";
        }
    });

    source_btn[1].addEventListener("click", function() {
        source_box.checked = "";
    });
    source_btn[2].addEventListener("click", function() {
        source_box.checked = "";
    });

    const type_box = document.querySelector(
        '.type_select_all input[type="checkbox"]'
    );
    const checkbox_type_btn = document.querySelectorAll(
        '.type_btn input[type="checkbox"]'
    );
    const radio_type_btn = document.querySelectorAll(
        '.type_btn_list input[type="radio"]'
    );

    if (type_box != null) {
        type_box.addEventListener("click", function() {
            if (type_box.checked == "") {
                checkbox_type_btn[1].checked = "";
                checkbox_type_btn[2].checked = "";
            } else {
                checkbox_type_btn[1].checked = "checked";
                checkbox_type_btn[2].checked = "checked";
            }
        })
        if (checkbox_type_btn[1] != undefined) {
            checkbox_type_btn[1].addEventListener("click", function() {
                type_box.checked = "";
            })
        };
        if (checkbox_type_btn[2] != undefined) {
            checkbox_type_btn[2].addEventListener("click", function() {
                type_box.checked = "";
            });
        };
    } else {
        radio_type_btn[0].addEventListener('click', function() {
            radio_type_btn[1].checked = "";
        })
        radio_type_btn[1].addEventListener('click', function() {
            radio_type_btn[0].checked = "";
        })
    }



    const btn = document.querySelector(".check");
    btn.addEventListener("click", function(e) {
        btn.classList.remove("search_btn");
        btn.classList.add("active");
        const theme_radio_len = document.querySelectorAll(
            '.theme_btn input[type="radio"]:checked'
        ).length;
        const theme_checkbox_len = document.querySelectorAll(
            '.theme_btn input[type="checkbox"]:checked'
        ).length;
        const time_check = document.querySelectorAll(
            '.time_btn input[type="text"]'
        );
        const radio_input_check = document.querySelectorAll(
            '.radio_item_input input[type="text"]'
        );
        const check_input_check = document.querySelectorAll(
            '.check_item_input input[type="text"]'
        );
        const source_len = document.querySelectorAll(
            '.source_btn input[type="checkbox"]:checked'
        ).length;
        const checkbox_type_len = document.querySelectorAll(
            '.type_btn input[type="checkbox"]:checked'
        ).length;
        const type_len_list = document.querySelectorAll('.type_btn_list input[type="radio"]:checked').length;
        let time_len = 0;

        for (var i = 0; i < time_check.length; i++) {
            if (time_check[i].value.trim() == "") {} else {
                time_len += 1;
            }
        }

        let radio_input_len = 0;
        for (var i = 0; i < radio_input_check.length; i++) {
            if (radio_input_check[i].value.trim() == "") {
                radio_input_check[i].value = "";
            } else {
                radio_input_len += 1;
            }
        }

        let check_input_len = 0;
        for (var i = 0; i < check_input_check.length; i++) {
            if (check_input_check[i].value.trim() == "") {
                check_input_check[i].value = "";
            } else {
                check_input_len += 1;
            }
        }
        if (input.type == "hidden") {
            if (
                (theme_radio_len > 0 || theme_checkbox_len > 1) &&
                time_len == time_check.length &&
                source_len > 0 &&
                (checkbox_type_len > 0 || type_len_list > 0)
            ) {} else {
                e.preventDefault();
                theme_radio_len < 1 && theme_checkbox_len < 2 ?
                    validateremove("validate_theme") :
                    validateadd("validate_theme");
                time_len < time_check.length ?
                    validateremove("validate_time") :
                    validateadd("validate_time");
                console.log(time_check.length)
                source_len < 1 ?
                    validateremove("validate_source") :
                    validateadd("validate_source");

                checkbox_type_len < 1 && type_len_list < 1 ?
                    validateremove("validate_type") :
                    validateadd("validate_type");

            }
        }

        if (input.type == "text") {
            if (
                ((theme_radio_len > 0 && radio_input_len > 0) ||
                    (theme_checkbox_len > 1 && check_input_len > 0)) &&
                time_len == time_check.length &&
                source_len > 0 &&
                (checkbox_type_len > 0 || type_len_list > 0)
            ) {} else {
                e.preventDefault();
                if (theme_radio_len == 1) {
                    radio_input_len < 1 ?
                        validateremove("validate_theme") :
                        validateadd("validate_theme");
                    time_len < time_check.length ?
                        validateremove("validate_time") :
                        validateadd("validate_time");
                    source_len < 1 ?
                        validateremove("validate_source") :
                        validateadd("validate_source");
                    (checkbox_type_len < 1 && type_len_list < 1) ?
                    validateremove("validate_type"):
                        validateadd("validate_type");
                } else {
                    (theme_checkbox_len == 1 && check_input_len >= 0) ||
                    (theme_checkbox_len > 1 && check_input_len == 0) ?
                    validateremove("validate_theme"): validateadd("validate_theme");
                    time_len < time_check.length ?
                        validateremove("validate_time") :
                        validateadd("validate_time");
                    source_len < 1 ?
                        validateremove("validate_source") :
                        validateadd("validate_source");
                    (checkbox_type_len < 1 && type_len_list < 1) ?
                    validateremove("validate_type"):
                        validateadd("validate_type");
                }
            }
        }

        function validateremove(title) {
            const vld_d = document.getElementById(`${title}`);
            vld_d.classList.remove("disable");
            vld_d.classList.add("alert");
            btn.classList.add("search_btn");
            btn.classList.remove("active");
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