import source_chart from "./source.js";
const axios = require('axios')
document.addEventListener("turbolinks:load", () => {
    const source_btn = document.querySelector(".source #analy")
    if (source_btn) {
        source_btn.addEventListener("click", (e) => {
            e.preventDefault()

            const token = document.querySelector('[name=csrf-token]').content
            axios.defaults.headers.common['X-CSRF-TOKEN'] = token

            var formEl = document.forms.query_ajax;
            var formData = new FormData(formEl);
            var object = {}
            formData.forEach(function(value, key) {
                object[key] = value;
            });

            axios.post('/queries/source', object)
                .then(function(resp) {
                    console.log(resp);
                    const { count, theme, start, end, source, type, gon } = resp.data
                    const search_list = document.querySelector(".search_list")
                    search_list.innerHTML = `
          <div class="container">
            <div class="row">
              <div id="search" class="search_all">
                <p id="count">查詢結果：${count}筆</p>
                <p id="theme">查詢主題：${theme}</p>
                <p id="start">起始時間：${start}</p>
                <p id="end">結束時間：${end}</p>
                <p id="source">資料來源：${source}</p>
                <p id="type">資料種類：${type}</p>
              </div>
            </div>
          </div>

          <div class="container">
            <canvas id="sourceBarChart" width="960px" height="400px"></canvas>
          </div>
          <div class="container">
            <canvas id="pttBarChart" width="960px" height="400px"></canvas>
          </div>
          <div class="container">
            <canvas id="dcardBarChart" width="960px" height="400px"></canvas>
          </div>         
          `
                    source_chart(gon)
                })
                .catch(function(err) {
                    console.log(err);
                })
        })
    }
})