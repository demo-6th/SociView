const { list } = require("postcss")

document.addEventListener("turbolinks:load", () => {
  if (location.pathname == '/jueries/list'){
    ver list = document.queryCommandEnabled(queries_list)
    list.addclass('query_link_page')
  }
})