document.addEventListener("turbolinks:load", () => {
  const dom = document.querySelector('#typewriter') 
  const data = "您好，本網頁適用解析度 1024 x 768 以上的介面".split('') 
  let index = 0
  function writing(index) { 
    if (index < data.length) { 
      dom.innerHTML += data[index]
       setTimeout(writing.bind(this), 100, ++index) 
     }
  }
  writing(index)
})