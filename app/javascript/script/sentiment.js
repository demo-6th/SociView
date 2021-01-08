document.addEventListener("turbolinks:load", () => {
  const ctx = document.getElementById("sentimentPieChart").getContext("2d");
  const pieChart = new Chart(ctx, {
    type: "pie",
    data: {
      labels: ["正面", "負面", "中立"],
      datasets: [
        {
          label: "（主文）情緒長條圖",
          data: [3, 4, 5],
          backgroundColor: ["lightgreen", "tomato", "lightblue"],
        },
      ],
    },
    options: {
      scales: {
        yAxes: [
          {
            ticks: {
              callback: function (value, index, values) {
                return value + " 則";
              },
            },
          },
        ],
      },
    },
  });
});
