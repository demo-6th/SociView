document.addEventListener("turbolinks:load", () => {
  tab_bar = document.querySelector(".tab_ber")
  tab_line = document.querySelector(".tab_line")
  if (tab_bar){
    tab_bar.addEventListener("click",function(e){
      e.preventDefault()
      console.log("aaa")
    })
  }
  
})