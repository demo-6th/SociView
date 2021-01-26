document.addEventListener("turbolinks:load", () => {
  let start = gon.start;
  let end = gon.end;
  let result = gon.result;
  let all_date = [];
  let pos_count = 0;
  let neg_count = 0;
  let neutral_count = 0;
  let pos_line = {};
  let neg_line = {};
  let neu_line = {};

  for (
    let d = new Date(start);
    d <= new Date(end);
    d.setDate(d.getDate() + 1)
  ) {
    let formatDt = `${new Date(d).getFullYear()}-${
      new Date(d).getMonth() + 1
    }-${new Date(d).getDate()}`;
    all_date.push(formatDt);
  }

  all_date.forEach((d) => {
    pos_line[d] = 0;
    neg_line[d] = 0;
    neu_line[d] = 0;
  });

  if (result !== undefined) {
    result.forEach((e) => {
      let d_result = `${new Date(e.created_at).getFullYear()}-${
        new Date(e.created_at).getMonth() + 1
      }-${new Date(e.created_at).getDate() - 1}`;

      if (e.sentiment === "positive") {
        pos_count += 1;
        pos_line[d_result] += 1;
      } else if (e.sentiment === "negative") {
        neg_count += 1;
        neg_line[d_result] += 1;
      } else {
        neutral_count += 1;
        neu_line[d_result] += 1;
      }
    });
  }

  if (document.getElementById("sentimentPieChart")) {
    // pie chart
    const ctx_pie = document
      .getElementById("sentimentPieChart")
      .getContext("2d");
    const pieChart = new Chart(ctx_pie, {
      type: "pie",
      data: {
        labels: ["正面", "負面", "中立"],
        datasets: [
          {
            data: [pos_count, neg_count, neutral_count],
            backgroundColor: [
              "rgba(75,192,192,0.5)",
              "rgba(255,99,132,0.5)",
              "rgba(58,164,235,0.5)",
            ],
          },
        ],
      },
      options: {
        title: {
          fontSize: 30,
          display: true,
          text: "情緒圓餅圖",
        },
      },
    });

    // bar chart
    const ctx_bar = document
      .getElementById("sentimentBarChart")
      .getContext("2d");
    const barChart = new Chart(ctx_bar, {
      type: "bar",
      data: {
        labels: ["正面", "負面", "中立"],
        datasets: [
          {
            data: [pos_count, neg_count, neutral_count],
            backgroundColor: [
              "rgba(75,192,192,0.5)",
              "rgba(255,99,132,0.5)",
              "rgba(58,164,235, 0.5)",
            ],
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
                beginAtZero: true,
              },
            },
          ],
          xAxes: [
            {
              barThickness: 160,
              maxBarThickness: 200,
            },
          ],
        },
        title: {
          fontSize: 30,
          display: true,
          text: "情緒長條圖",
        },
        legend: {
          display: false,
        },
      },
    });

    // line chart
    const ctx_line = document
      .getElementById("sentimentLineChart")
      .getContext("2d");

    const lineChart = new Chart(ctx_line, {
      type: "line",
      data: {
        labels: all_date,
        datasets: [
          {
            label: "正面聲量",
            data: Object.values(pos_line),
            borderWidth: 1,
            pointRadius: 5,
            borderColor: "rgba(75,192,192,1)",
            backgroundColor: "rgba(75,192,192,0.2)",
          },
          {
            label: "負面聲量",
            data: Object.values(neg_line),
            borderWidth: 1,
            pointRadius: 5,
            borderColor: "rgba(220,70,70,1)",
            backgroundColor: "rgba(255,99,132,0.2)",
          },
          {
            label: "中立聲量",
            data: Object.values(neu_line),
            borderWidth: 1,
            pointRadius: 5,
            borderColor: "rgba(58,164,235, 1)",
            backgroundColor: "rgba(58,164,235, 0.2)",
          },
        ],
      },
      options: {
        scales: {
          xAxes: [
            {
              gridLines: {
                borderDash: [8, 4],
                color: "white",
                drawBorder: true,
              },
            },
          ],
          yAxes: [
            {
              ticks: {
                callback: function (value, index, values) {
                  return value + " 則";
                },
                beginAtZero: true,
                stepSize: 1,
              },
            },
          ],
        },
        title: {
          fontSize: 30,
          display: true,
          text: "情緒折線圖",
        },
      },
    });
  }
});
