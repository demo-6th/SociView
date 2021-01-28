document.addEventListener("turbolinks:load", () => {
  var burger = document.querySelector(".burger")
  if (burger){
    burger.addEventListener("click",()=> {
      var aside = document.querySelector(".aside")
      aside.classList.remove("hidden")  
    })
  }else{
    aside.classList.add("hidden")
  }
})