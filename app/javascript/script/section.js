document.addEventListener("turbolinks:load", () => {
  const search_btn = document.querySelector(".search_btn")
  search_btn.addEventListener('click', addItemBtn)

  function addItemBtn(){
    const list_page = document.querySelector('.search_list')
    const search_item = document.createElement('div')
    search_item.classList.add('search_data')
    search_item.innerHTML = `<div class="container">
                              <div class="w-full px-2">
                                <div class="search_all bg-red-100 px-5 border-solid border-gray-800 border-2 leading-6">
                                  <span>查詢結果：189筆</span>
                                  <h3>查詢主題：空氣清淨機</h3>
                                  <p>資料來源：Dcard</p>
                                </div>
                              </div>
                            </div>`
    if (document.querySelector(".search_data") !== null){
      return
    }
    list_page.appendChild(search_item)
  }
})