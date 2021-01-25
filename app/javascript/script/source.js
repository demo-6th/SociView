function source_chart(gon) {
    let start = gon.start;
    let end = gon.end;
    let board = gon.board;
    let dcard = gon.dcard_result;
    let ptt = gon.ptt_result;
    let all_date = [];
    let ptt_line = [];
    let dcard_line = [];
    let all_board = [];
    let ptt_board = []
    let dcard_board = []

    //source
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
                ptt_line[d_result] += 1;
            } else if (e.alias.includes('dcard')) {
                dcard_line[d_result] += 1;
            }
        });
    }

    //board
    board.forEach((e) => {
        all_board.push(e.alias)
    })

    all_board.forEach((e) => {
        ptt_board[e] = 0;
        dcard_board[e] = 0;
    });

    if (dcard !== undefined) {
        dcard.forEach((e) => {
            board.forEach((b) => {
                if (e.alias === b.alias) {
                    dcard_board[e.alias] += 1;
                }
            })
        })
    }
    if (ptt !== undefined) {
        ptt.forEach((e) => {
            board.forEach((b) => {
                if (e.alias === b.alias) {
                    ptt_board[e.alias] += 1;
                }
            })
        })
    }
    // console.log(Object.values(dcard_board))

    let keysSorted = Object.keys(dcard_board).sort(function(a, b) { return dcard_board[a] - dcard_board[b] })
    console.log(keysSorted.reverse().map(key => dcard_board[key]));

    //source
    const total_result = Object.values(ptt_line).map(function(n, i) { return n + Object.values(dcard_line)[i]; });
    const ptt_divsion = Object.values(ptt_line).map(function(n, i) { return n / total_result[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const dcard_divsion = Object.values(dcard_line).map(function(n, i) { return n / total_result[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const ptt_bgc = ptt_divsion.map(x => x = "rgba(0,0,0,0.5)")
    const dcard_bgc = dcard_divsion.map(x => x = "rgba(0,106,166,0.5)")

    //board






    ///
    if (document.getElementById("sourceBarChart")) {
        // source
        const ctx_bar = document
            .getElementById("sourceBarChart")
            .getContext("2d");
        const sourcebarChart = new Chart(ctx_bar, {
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
                            return data.datasets[tooltipItems.datasetIndex].label + ': ' + tooltipItems.yLabel + ' A';
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
                        stacked: true,
                    }, ],
                },
                title: {
                    display: true,
                    text: "社群來源長條圖",
                },
                legend: {
                    display: false,
                },
            },
        });

        // board
        const ctx_bar_ptt = document
            .getElementById("pttBarChart")
            .getContext("2d");
        const pttbarChart = new Chart(ctx_bar_ptt, {
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
                        stacked: true,
                    }, ],
                },
                title: {
                    display: true,
                    text: "PTT討論版來源長條圖",
                },
                legend: {
                    display: false,
                },
            },
        });

        // board
        const ctx_bar_dcard = document
            .getElementById("dcardBarChart")
            .getContext("2d");
        const dcardbarChart = new Chart(ctx_bar_dcard, {
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
                    },
                    {
                        label: 'Dcard',
                        backgroundColor: dcard_bgc,
                        data: dcard_divsion
                    },
                    {
                        label: 'Dcard',
                        backgroundColor: dcard_bgc,
                        data: dcard_divsion
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
                        stacked: true,
                    }, ],
                },
                title: {
                    display: true,
                    text: "Dcard討論版來源長條圖",
                },
                legend: {
                    display: false,
                },
            },
        });
    };
};

export default source_chart;