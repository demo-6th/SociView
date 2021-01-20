const axios = require('axios')
document.addEventListener("turbolinks:load", () =>{
  const volume_btn = document.querySelector(".volume #analy")
  if (volume_btn) {
    volume_btn.addEventListener("click", (e)=>{
      e.preventDefault()

      const token = document.querySelector('[name=csrf-token]').content
      axios.defaults.headers.common['X-CSRF-TOKEN'] = token

      axios.post('/queries/volume', { token })
        .then(function(resp){
          console.log(resp);
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
         </div>`
        })
        .catch(function(err){
          console.log(err);
        })
    })
  }
})