document.addEventListener("turbolinks:load", () => {
    const dom = document.querySelector('#typewriter')
    const data = "　　　　　　　　　　　　　　　　　　　　您好，本網頁適用解析度為　１０２４　x　７６８　以上，低於此規格會降低使用者體驗，敬請見諒　　　　　　　　　　　　　　　　　　　　".split('')
    let index = 0

    function writing(index) {
        if (index < data.length - 19) {
            dom.innerHTML = data.slice(index, index + 21).join('')
            setTimeout(writing.bind(this), 300, ++index)
        } else {
            index = 0
            writing(index)
        }
    }
    writing(index)
})

// n = blank , n-1 = data.lenght , n+1 = index