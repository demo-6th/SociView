document.addEventListener("turbolinks:load", () => {
  const first = document.querySelector('.first a');
  const prev = document.querySelector('.prev a');
  const next = document.querySelector('.next a');
  const last = document.querySelector('.last a');
  if (first) {
    first.innerHTML = "第一頁";
  }
  if (prev) {
    prev.innerHTML = "前一頁";
  }
  if (next) {
    next.innerHTML = "下一頁";
  }
  if (last) {
    last.innerHTML = "最後頁";
  }
})