document.addEventListener("turbolinks:load", () => {
  const art = document.getElementById('article')
  const f_btn = document.getElementById('filter_btn')
  if (f_btn) {
    const post_div = document.querySelectorAll('#post_div')
    const comment_div = document.querySelectorAll('#comment_div')
    f_btn.addEventListener('click', function () {
      if (art.value == "all") {
        for (var i = 0; i < post_div.length; i++) {
          post_div[i].style.display = "block"
        }
        for (var i = 0; i < comment_div.length; i++) {
          comment_div[i].style.display = "block"
        }
      } else if (art.value == "post") {
        for (var i = 0; i < post_div.length; i++) {
          post_div[i].style.display = "block"
        }
        for (var i = 0; i < comment_div.length; i++) {
          comment_div[i].style.display = "none"
        }
      } else {
        for (var i = 0; i < post_div.length; i++) {
          post_div[i].style.display = "none"
        }
        for (var i = 0; i < comment_div.length; i++) {
          comment_div[i].style.display = "block"
        }
      }
    })
  }
})