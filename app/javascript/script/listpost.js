document.addEventListener("turbolinks:load", () => {
  const art = document.getElementById('article')
  const sen = document.getElementById('sentiment')
  const f_btn = document.getElementById('filter_btn')
  const sort = document.getElementById('sort')
  const sort_n = document.getElementById('sort_new')
  const sort_o = document.getElementById('sort_old')
  const sort_m = document.getElementById('sort_many')
  const sort_l = document.getElementById('sort_less')
  filter_page()
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
      filter_page()
    })
  }
  if (sort) {
    sort_n.addEventListener('click', function () {
      var list_div = document.querySelectorAll('.list')
      var arr = []
      for (var i = 0; i < list_div.length; i++) {
        arr.push(list_div[i])
      }
      arr.sort(function (a, b) {
        return -(Date.parse(a.dataset["time"]) - Date.parse(b.dataset["time"]))
      })
      for (var i = 0; i < arr.length; i++) {
        document.querySelector('.div_list').appendChild(arr[i])
      }
      sort_page()
    })
    sort_o.addEventListener('click', function () {
      var list_div = document.querySelectorAll('.list')
      var arr = []
      for (var i = 0; i < list_div.length; i++) {
        arr.push(list_div[i])
      }
      arr.sort(function (a, b) {
        return Date.parse(a.dataset["time"]) - Date.parse(b.dataset["time"])
      })
      for (var i = 0; i < arr.length; i++) {
        document.querySelector('.div_list').appendChild(arr[i])
      }
      sort_page()
    })
    sort_m.addEventListener('click', function () {
      var list_div = document.querySelectorAll('.list')
      var arr = []
      for (var i = 0; i < list_div.length; i++) {
        arr.push(list_div[i])
      }
      arr.sort(function (a, b) {
        return -(a.getAttribute('like_count') - b.getAttribute('like_count'))
      })
      for (var i = 0; i < arr.length; i++) {
        document.querySelector('.div_list').appendChild(arr[i])
      }
      sort_page()
    })
    sort_l.addEventListener('click', function () {
      var list_div = document.querySelectorAll('.list')
      var arr = []
      for (var i = 0; i < list_div.length; i++) {
        arr.push(list_div[i])
      }
      arr.sort(function (a, b) {
        return a.getAttribute('like_count') - b.getAttribute('like_count')
      })
      for (var i = 0; i < arr.length; i++) {
        document.querySelector('.div_list').appendChild(arr[i])
      }
      sort_page()
    })
  }




  function sort_page() {
    var block_ary = sort_arr

    function showBtn() {
      var opt = document.getElementById('selectpage')
      var btnNum = Math.ceil(block_ary.length / 10);
      var str = "";
      for (var i = 0; i < btnNum; i++) {
        str += ` <option id ="${i + 1}" value="${i + 1}">${i + 1}</option> `;
      }
      opt.innerHTML = str;
      var s_btn = document.getElementById('page_btn')
      var sel = document.getElementById('selectpage')
      s_btn.addEventListener('click', function () {
        var items = 10;
        var pageIndexStart = (sel.value - 1) * items;
        var pageIndexEnd = sel.value * items;
        for (let i = 0; i < block_ary.length; i++) {
          block_ary[i].style.display = "none"
        }
        for (var i = pageIndexStart; i < pageIndexEnd; i++) {
          if (i >= block_ary.length) {
            break;
          }
          block_ary[i].style.display = "block"
        };
      });
    }
    changePage(1, block_ary);
    showBtn();
  }

  function changePage(value, ary) {
    var items = 10;
    var pageIndexStart = (value - 1) * items;
    var pageIndexEnd = value * items;
    for (let i = 0; i < ary.length; i++) {
      ary[i].style.display = "none"
    }
    for (var i = pageIndexStart; i < pageIndexEnd; i++) {
      if (i >= ary.length) {
        break;
      }
      ary[i].style.display = "block"
    };
  }




})