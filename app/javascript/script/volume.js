document.addEventListener("turbolinks:load", () => {
    start = gon.start;
    end = gon.end;
    let all_date = [];
    let pos_count = 0;
    let neg_count = 0;
    let neutral_count = 0;
    let pos_line = {};
    let neg_line = {};

    for (
        let d = new Date(start); d <= new Date(end); d.setDate(d.getDate() + 1)
    ) {
        formatDt = `${new Date(d).getFullYear()}-${
      new Date(d).getMonth() + 1
    }-${new Date(d).getDate()}`;
        all_date.push(formatDt);
    }

    all_date.forEach((d) => {
        pos_line[d] = 0;
        neg_line[d] = 0;
    });

    gon.result.forEach((e) => {
        d_result = `${new Date(e.created_at).getFullYear()}-${
      new Date(e.created_at).getMonth() + 1
    }-${new Date(e.created_at).getDate()}`;

        if (e.volume === "positive") {
            pos_count += 1;
            pos_line[d_result] += 1;
        } else if (e.volume === "negative") {
            neg_count += 1;
            neg_line[d_result] += 1;
        } else {
            neutral_count += 1;
        }
    });
    // pie chart
    const ctx_pie = document.getElementById("volumePieChart").getContext("2d");
    const pieChart = new Chart(ctx_pie, {
        type: "pie",
        data: {
            labels: ["正面", "負面", "中立"],
            datasets: [{
                label: "（主文）情緒長條圖",
                data: [pos_count, neg_count, neutral_count],
                backgroundColor: ["lightgreen", "tomato", "lightblue"],
            }, ],
        },
    });

    // bar chart
    const ctx_bar = document.getElementById("volumeBarChart").getContext("2d");
    const barChart = new Chart(ctx_bar, {
        type: "bar",
        data: {
            labels: ["正面", "負面", "中立"],
            datasets: [{
                label: "情緒長條圖",
                data: [pos_count, neg_count, neutral_count],
                backgroundColor: ["lightgreen", "tomato", "lightblue"],
            }, ],
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        callback: function(value, index, values) {
                            return value + " 則";
                        },
                        beginAtZero: true,
                    },
                }, ],
            },
        },
    });

    // line chart
    const ctx_line = document
        .getElementById("volumeLineChart")
        .getContext("2d");
    const lineChart = new Chart(ctx_line, {
        type: "line",
        data: {
            labels: all_date,
            datasets: [{
                    label: "正面聲量",
                    data: Object.values(pos_line),
                    backgroundColor: "#8FC31F",
                    fill: false,
                    pointRadius: 5,
                    borderColor: "#8FC31F",
                },
                {
                    label: "負面聲量",
                    data: Object.values(neg_line),
                    backgroundColor: "red",
                    fill: false,
                    pointRadius: 5,
                    borderColor: "red",
                },
            ],
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        callback: function(value, index, values) {
                            return value + " 則";
                        },
                        beginAtZero: true,
                        stepSize: 1,
                    },
                }, ],
            },
        },
    });
});