function source_chart(gon) {
    let start = gon.start;
    let end = gon.end;
    let all_date = [];
    let pos_count = 0;
    let neg_count = 0;
    let pos_line = [];
    let neg_line = [];
    let ptt_count = gon.ptt_count
    let dcard_count = gon.dcard_count


    for (
        let d = new Date(start); d <= new Date(end); d.setDate(d.getDate() + 1)
    ) {
        let formatDt = `${new Date(d).getFullYear()}-${
        new Date(d).getMonth() + 1
      }-${new Date(d).getDate()}`;
        all_date.push(formatDt);
    }

    all_date.forEach((d) => {
        pos_line[d] = 0;
        neg_line[d] = 0;

    });
    if (gon.result !== undefined) {
        gon.result.forEach((e) => {
            let d_result = `${new Date(e.created_at).getFullYear()}-${
              new Date(e.created_at).getMonth() + 1
            }-${new Date(e.created_at).getDate()}`;
            if (e.alias.includes('ptt')) {

                pos_count += 1;
                pos_line[d_result] += 1;
            } else if (e.alias.includes('dcard')) {
                neg_count += 1;
                neg_line[d_result] += 1;
            }
        });
    }
    const arr1 = Object.values(pos_line)
    const arr2 = Object.values(pos_line)
    console.log(arr1)
    console.log(arr2)
    var result = arr1.map(function(n, i) { return n / arr2[i]; });
    console.log(result)


    if (document.getElementById("sourcePieChart")) {
        // pie chart
        const ctx_pie = document
            .getElementById("sourcePieChart")
            .getContext("2d");
        const pieChart = new Chart(ctx_pie, {
            type: "pie",
            data: {
                labels: ["正面", "負面", "中立"],
                datasets: [{
                    label: "（主文）情緒長條圖",
                    data: [pos_count, neg_count],
                    backgroundColor: [
                        "rgba(75,192,192,0.5)",
                        "rgba(255,99,132,0.5)",

                    ],
                }, ],
            },
            options: {
                title: {
                    display: true,
                    text: "情緒圓餅圖",
                },
            },
        });

        // bar chart
        const ctx_bar = document
            .getElementById("sourceBarChart")
            .getContext("2d");
        const barChart = new Chart(ctx_bar, {
            type: "bar",
            data: {
                labels: all_date,
                datasets: [{
                        backgroundColor: ["rgba(75,192,192,0.5)", "rgba(75,192,192,0.5)", "rgba(75,192,192,0.5)"],
                        fillColor: "#000000",
                        data: Object.values(pos_line)
                    },
                    {
                        backgroundColor: ["rgba(255,99,132,0.5)", "rgba(255,99,132,0.5)", "rgba(255,99,132,0.5)"],
                        data: Object.values(neg_line)
                    }
                ],
            },
            options: {
                scales: {
                    yAxes: [{
                        stacked: true,
                        ticks: {
                            callback: function(value, index, values) {
                                return value * 100;
                            },
                            beginAtZero: true,
                        },
                    }, ],
                    xAxes: [{
                        barThickness: 160,
                        maxBarThickness: 200,
                        stacked: true,
                    }, ],
                },
                title: {
                    display: true,
                    text: "來源長條圖",
                },
                legend: {
                    display: false,
                },
            },
        });

        // line chart
        const ctx_line = document
            .getElementById("sourceLineChart")
            .getContext("2d");

        const lineChart = new Chart(ctx_line, {
            type: "line",
            data: {
                labels: all_date,
                datasets: [{
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
                ],
            },
            options: {
                scales: {
                    xAxes: [{
                        gridLines: {
                            borderDash: [8, 4],
                            color: "white",
                            drawBorder: true,
                        },
                    }, ],
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
                    text: "情緒折線圖",
                },
            },
        });
    };
};

export default source_chart;