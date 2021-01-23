const axios = require('axios')
document.addEventListener("turbolinks:load", () =>{
  let post_btn = document.querySelector(".list #analy")
    if (post_btn) {
      post_btn.addEventListener("click", (e)=>{
        e.preventDefault();
        const token = document.querySelector('[name=csrf-token]').content
        axios.defaults.headers.common['X-CSRF-TOKEN'] = token

        axios.post('/queries/list', {
          success: function(resp){
          dataType: HTML
          document.querySelector(".search_list").html(response);
          }
        })
      })
    }
})

// Rails.ajax({
//   url: "/queries/list",
//   type: "post",
//   success: function(data) { Rails.document.querySelector(".search_list")[0].innerHTML = data.html; }
// })
