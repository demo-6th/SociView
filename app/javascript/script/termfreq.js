document.addEventListener("turbolinks:load", () => {
    const response = await fetch("data/tf_V.csv");
    const data = await response.text();
    const rows = data.split('\n').splice(1);
    rows.forEach((element) => {
      const column = element.split(',');
      const term = column[1];
      const freq = column[2];
      console.log(term)
      console.log(freq)




  // if (document.getElementById("sentimentPieChart")) {
  //   // pie chart
  //   const ctx_pie = document
  //     .getElementById("sentimentPieChart")
  //     .getContext("2d");
  //   const pieChart = new Chart(ctx_pie, {
  //     type: "bar",
  //     data: {
  //       labels: ["正面", "負面", "中立"],
  //       datasets: [
  //         {
  //           label: "（主文）情緒長條圖",
  //           data: [pos_count, neg_count, neutral_count],
  //           // backgroundColor: [
  //           //   "rgba(75,192,192,0.5)",
  //           //   "rgba(255,99,132,0.5)",
  //           //   "rgba(58,164,235,0.5)",
  //           // ],
  //         },
  //       ],
  //     },
  //     options: {
  //       title: {
  //         display: true,
  //         text: "情緒圓餅圖",
  //       },
  //     },
  //   });
  // }
});

