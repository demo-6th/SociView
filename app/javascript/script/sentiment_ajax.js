import setiment_chart from "./sentiment.js";
const axios = require('axios')
document.addEventListener("turbolinks:load", () =>{
  const setiment_btn = document.querySelector(".sentiment #analy")
  if (setiment_btn) {
    setiment_btn.addEventListener("click", (e)=>{
      e.preventDefault()

      const token = document.querySelector('[name=csrf-token]').content
      axios.defaults.headers.common['X-CSRF-TOKEN'] = token

      var formEl = document.forms.query_ajax;
      var formData = new FormData(formEl);
      var object = {}
      formData.forEach(function (value, key) {
        object[key] = value;
      });

      axios.post('/queries/sentiment', object)
        .then(function(resp){
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

          <div class="chart">
            <canvas id="sentimentPieChart" width="960px" height="400px"></canvas>
          </div>
          <div class="chart">
            <canvas id="sentimentBarChart" width="960px" height="400px"></canvas>
          </div>
          <div class="chart">
            <canvas id="sentimentLineChart" width="960px" height="400px"></canvas>
          </div>`
          setiment_chart(gon)
        })
        .catch(function(err){
          console.log(err);
        })
    })
  }
})