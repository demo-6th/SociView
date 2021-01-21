document.addEventListener("turbolinks:load", () => {
  const art = document.getElementById('article')
  const sen = document.getElementById('sentiment')
  const f_btn = document.getElementById('filter_btn')
  if (f_btn) {
    const post_div = document.querySelectorAll('#post_div')
    const comment_div = document.querySelectorAll('#comment_div')
    const neutral_post = document.querySelectorAll('.neutral_post')
    const positive_post = document.querySelectorAll('.positive_post')
    const negative_post = document.querySelectorAll('.negative_post')
    const neutral_comment = document.querySelectorAll('.neutral_comment')
    const positive_comment = document.querySelectorAll('.positive_comment')
    const negative_comment = document.querySelectorAll('.negative_comment')
    f_btn.addEventListener('click', function () {
      if (art.value == "all") {
        if (sen.value == "all") {
          for (var i = 0; i < post_div.length; i++) {
            post_div[i].style.display = "block"
          }
          for (var i = 0; i < comment_div.length; i++) {
            comment_div[i].style.display = "block"
          }
        } else if (sen.value == "positive") {
          for (var i = 0; i < positive_post.length; i++) {
            positive_post[i].style.display = "block"
          }
          for (var i = 0; i < positive_comment.length; i++) {
            positive_comment[i].style.display = "block"
          }
          for (var i = 0; i < negative_post.length; i++) {
            negative_post[i].style.display = "none"
          }
          for (var i = 0; i < negative_comment.length; i++) {
            negative_comment[i].style.display = "none"
          }
          for (var i = 0; i < neutral_post.length; i++) {
            neutral_post[i].style.display = "none"
          }
          for (var i = 0; i < neutral_comment.length; i++) {
            neutral_comment[i].style.display = "none"
          }
        } else if (sen.value == "negative") {
          for (var i = 0; i < positive_post.length; i++) {
            positive_post[i].style.display = "none"
          }
          for (var i = 0; i < positive_comment.length; i++) {
            positive_comment[i].style.display = "none"
          }
          for (var i = 0; i < negative_post.length; i++) {
            negative_post[i].style.display = "block"
          }
          for (var i = 0; i < negative_comment.length; i++) {
            negative_comment[i].style.display = "block"
          }
          for (var i = 0; i < neutral_post.length; i++) {
            neutral_post[i].style.display = "none"
          }
          for (var i = 0; i < neutral_comment.length; i++) {
            neutral_comment[i].style.display = "none"
          }
        } else {
          for (var i = 0; i < positive_post.length; i++) {
            positive_post[i].style.display = "none"
          }
          for (var i = 0; i < positive_comment.length; i++) {
            positive_comment[i].style.display = "none"
          }
          for (var i = 0; i < negative_post.length; i++) {
            negative_post[i].style.display = "none"
          }
          for (var i = 0; i < negative_comment.length; i++) {
            negative_comment[i].style.display = "none"
          }
          for (var i = 0; i < neutral_post.length; i++) {
            neutral_post[i].style.display = "block"
          }
          for (var i = 0; i < neutral_comment.length; i++) {
            neutral_comment[i].style.display = "block"
          }
        }
      } else if (art.value == "post") {
        if (sen.value == "all") {
          for (var i = 0; i < post_div.length; i++) {
            post_div[i].style.display = "block"
          }
          for (var i = 0; i < comment_div.length; i++) {
            comment_div[i].style.display = "none"
          }
        } else if (sen.value == "positive") {
          for (var i = 0; i < positive_post.length; i++) {
            positive_post[i].style.display = "block"
          }
          for (var i = 0; i < positive_comment.length; i++) {
            positive_comment[i].style.display = "none"
          }
          for (var i = 0; i < negative_post.length; i++) {
            negative_post[i].style.display = "none"
          }
          for (var i = 0; i < negative_comment.length; i++) {
            negative_comment[i].style.display = "none"
          }
          for (var i = 0; i < neutral_post.length; i++) {
            neutral_post[i].style.display = "none"
          }
          for (var i = 0; i < neutral_comment.length; i++) {
            neutral_comment[i].style.display = "none"
          }
        } else if (sen.value == "negative") {
          for (var i = 0; i < positive_post.length; i++) {
            positive_post[i].style.display = "none"
          }
          for (var i = 0; i < positive_comment.length; i++) {
            positive_comment[i].style.display = "none"
          }
          for (var i = 0; i < negative_post.length; i++) {
            negative_post[i].style.display = "block"
          }
          for (var i = 0; i < negative_comment.length; i++) {
            negative_comment[i].style.display = "none"
          }
          for (var i = 0; i < neutral_post.length; i++) {
            neutral_post[i].style.display = "none"
          }
          for (var i = 0; i < neutral_comment.length; i++) {
            neutral_comment[i].style.display = "none"
          }
        } else {
          for (var i = 0; i < positive_post.length; i++) {
            positive_post[i].style.display = "none"
          }
          for (var i = 0; i < positive_comment.length; i++) {
            positive_comment[i].style.display = "none"
          }
          for (var i = 0; i < negative_post.length; i++) {
            negative_post[i].style.display = "none"
          }
          for (var i = 0; i < negative_comment.length; i++) {
            negative_comment[i].style.display = "none"
          }
          for (var i = 0; i < neutral_post.length; i++) {
            neutral_post[i].style.display = "block"
          }
          for (var i = 0; i < neutral_comment.length; i++) {
            neutral_comment[i].style.display = "none"
          }
        }
      } else {
        if (sen.value == "all") {
          for (var i = 0; i < post_div.length; i++) {
            post_div[i].style.display = "none"
          }
          for (var i = 0; i < comment_div.length; i++) {
            comment_div[i].style.display = "block"
          }
        } else if (sen.value == "positive") {
          for (var i = 0; i < positive_post.length; i++) {
            positive_post[i].style.display = "none"
          }
          for (var i = 0; i < positive_comment.length; i++) {
            positive_comment[i].style.display = "block"
          }
          for (var i = 0; i < negative_post.length; i++) {
            negative_post[i].style.display = "none"
          }
          for (var i = 0; i < negative_comment.length; i++) {
            negative_comment[i].style.display = "none"
          }
          for (var i = 0; i < neutral_post.length; i++) {
            neutral_post[i].style.display = "none"
          }
          for (var i = 0; i < neutral_comment.length; i++) {
            neutral_comment[i].style.display = "none"
          }
        } else if (sen.value == "negative") {
          for (var i = 0; i < positive_post.length; i++) {
            positive_post[i].style.display = "none"
          }
          for (var i = 0; i < positive_comment.length; i++) {
            positive_comment[i].style.display = "none"
          }
          for (var i = 0; i < negative_post.length; i++) {
            negative_post[i].style.display = "none"
          }
          for (var i = 0; i < negative_comment.length; i++) {
            negative_comment[i].style.display = "block"
          }
          for (var i = 0; i < neutral_post.length; i++) {
            neutral_post[i].style.display = "none"
          }
          for (var i = 0; i < neutral_comment.length; i++) {
            neutral_comment[i].style.display = "none"
          }
        } else {
          for (var i = 0; i < positive_post.length; i++) {
            positive_post[i].style.display = "none"
          }
          for (var i = 0; i < positive_comment.length; i++) {
            positive_comment[i].style.display = "none"
          }
          for (var i = 0; i < negative_post.length; i++) {
            negative_post[i].style.display = "none"
          }
          for (var i = 0; i < negative_comment.length; i++) {
            negative_comment[i].style.display = "none"
          }
          for (var i = 0; i < neutral_post.length; i++) {
            neutral_post[i].style.display = "none"
          }
          for (var i = 0; i < neutral_comment.length; i++) {
            neutral_comment[i].style.display = "block"
          }
        }
      }
    })
  }
})