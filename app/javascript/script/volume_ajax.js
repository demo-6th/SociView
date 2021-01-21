import volume_chart from "./volume.js";
const axios = require('axios')

document.addEventListener("turbolinks:load", () =>{
  const volume_btn = document.querySelector(".volume #analy")
  if (volume_btn) {
    volume_btn.addEventListener("click", (e)=>{
      e.preventDefault()


      const token = document.querySelector('[name=csrf-token]').content
      axios.defaults.headers.common['X-CSRF-TOKEN'] = token

      var formEl = document.forms.query_ajax;
      var formData = new FormData(formEl);
      var object = {};
      formData.forEach(function (value, key) {
        object[key] = value;
      });

      axios.post('/queries/volume', object)
        .then(function(resp){
           const { count1, count2, count3, theme, start, end, source, type, gon } = resp.data
           const users_query_page = document.querySelector(".search_list")
           users_query_page.innerHTML =`<div class="container">
           <div class="row">
             <div id="search" class="search_all">
               <p id="count">查詢結果：${count1 + count2 + count3}筆</p>
               <p id="theme">查詢主題：${theme}</p>
               <p id="start">起始時間：${start}</p>
               <p id="end">結束時間：${end}</p>
               <p id="source">資料來源：${source}</p>
               <p id="type">資料種類：${type}</p>
             </div>
           </div>
         </div>
      
         <div class="container">
           <canvas id="volumeBarChart" width="960px" height="400px"></canvas>
         </div>

         <div class="container">
           <canvas id="volumeLineChart" width="960px" height="400px"></canvas>
         </div>`
        })
         volume_chart(gon)
        .catch(function(err){
          console.log(err);
        })
    })
  }
})