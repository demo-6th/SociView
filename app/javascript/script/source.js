document.addEventListener("turbolinks:load", () => {
    let start = gon.start;
    let end = gon.end;
    let all_date = [];
    let pos_count = 0;
    let neg_count = 0;
    let ptt_line = [];
    let dcard_line = [];
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
        ptt_line[d] = 0;
        dcard_line[d] = 0;

    });
    if (gon.result !== undefined) {
        gon.result.forEach((e) => {
            let d_result = `${new Date(e.created_at).getFullYear()}-${
              new Date(e.created_at).getMonth() + 1
            }-${new Date(e.created_at).getDate()}`;
            if (e.alias.includes('ptt')) {

                pos_count += 1;
                ptt_line[d_result] += 1;
            } else if (e.alias.includes('dcard')) {
                neg_count += 1;
                dcard_line[d_result] += 1;
            }
        });
    }
    const ptt_arr = Object.values(ptt_line)
    const dcard_arr = [100, 2000, 100, 100]
    console.log(ptt_arr)
    console.log(dcard_arr)
    const total_result = ptt_arr.map(function(n, i) { return n + dcard_arr[i]; });
    const ptt_divsion = ptt_arr.map(function(n, i) { return n / total_result[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const dcard_divsion = dcard_arr.map(function(n, i) { return n / total_result[i]; }).map(x => Math.round(x * 10000) / 100 || 0);

    console.log(ptt_divsion)
    console.log(dcard_divsion)
    const ptt_bgc = ptt_divsion.map(x => x = "rgba(0,0,0,0.5)")
    const dcard_bgc = dcard_divsion.map(x => x = "rgba(0,106,166,0.5)")

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
                        label: 'PTT',
                        backgroundColor: ptt_bgc,
                        fillColor: "#000000",
                        data: ptt_divsion
                    },
                    {
                        label: 'Dcard',
                        backgroundColor: dcard_bgc,
                        data: dcard_divsion
                    }
                ],
            },
            options: {
                tooltips: {
                    enabled: true,
                    mode: 'single',
                    callbacks: {
                        label: function(tooltipItems, data) {
                            return data.datasets[tooltipItems.datasetIndex].label + ': ' + tooltipItems.yLabel + ' %';
                        }
                    }
                },
                scales: {
                    yAxes: [{
                        stacked: true,
                        ticks: {
                            callback: function(value, index, values) {
                                return value + '%';
                            },
                            beginAtZero: true,
                            scaleLabel: {
                                display: true,
                            }
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
})