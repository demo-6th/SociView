document.addEventListener("turbolinks:load", () => {
    start = gon.start;
    end = gon.end;
    theme = gon.theme;
    theme1 = gon.theme1;
    count = gon.count;
    count1 = gon.count1;
    let all_date = [];
    let count_line = {};
    let count1_line = {};

    for (
        let d = new Date(start); d <= new Date(end); d.setDate(d.getDate() + 1)
    ) {
        formatDt = `${new Date(d).getFullYear()}-${
      new Date(d).getMonth() + 1
    }-${new Date(d).getDate()}`;
        all_date.push(formatDt);
    }

    all_date.forEach((d) => {
        count_line[d] = 0;
        count1_line[d] = 0;
    });
    //待改進
    gon.result.forEach((e) => {
        d_result = `${new Date(e.created_at).getFullYear()}-${
      new Date(e.created_at).getMonth() + 1
    }-${new Date(e.created_at).getDate()}`;
        count_line[d_result] += 1;
    });
    //待改進
    gon.result1.forEach((e) => {
        d_result = `${new Date(e.created_at).getFullYear()}-${
      new Date(e.created_at).getMonth() + 1
    }-${new Date(e.created_at).getDate()}`;
        count1_line[d_result] += 1;
    });

    // pie chart
    const ctx_pie = document.getElementById("volumePieChart").getContext("2d");
    const pieChart = new Chart(ctx_pie, {
        type: "pie",
        data: {
            labels: [gon.theme, gon.theme1],
            datasets: [{
                data: [count, count1],
                backgroundColor: ["lightgreen", "tomato"],
            }, ],
        },
        options: {
            title: {
                display: true,
                text: "聲量圓餅圖",
            },
        },
    });

    // bar chart
    const ctx_bar = document.getElementById("volumeBarChart").getContext("2d");
    const barChart = new Chart(ctx_bar, {
        type: "bar",
        data: {
            labels: [gon.theme, gon.theme1],
            datasets: [{
                data: [count, count1],
                backgroundColor: ["lightgreen", "tomato"],
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
            title: {
                display: true,
                text: "聲量長條圖",
            },
            legend: {
                display: false,
            },
        },
    });

    // line chart
    const ctx_line = document.getElementById("volumeLineChart").getContext("2d");
    const lineChart = new Chart(ctx_line, {
        type: "line",
        data: {
            labels: all_date,
            datasets: [{
                    label: `${theme}`,
                    data: Object.values(count_line),
                    backgroundColor: "#8FC31F",
                    fill: false,
                    pointRadius: 5,
                    borderColor: "#8FC31F",
                },
                {
                    label: `${theme1}`,
                    data: Object.values(count1_line),
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
            title: {
                display: true,
                text: "聲量折線圖",
            },
        },
    });
});