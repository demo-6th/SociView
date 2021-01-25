document.addEventListener("turbolinks:load", () => {
    let start = gon.start;
    let end = gon.end;
    let board = gon.board;
    let dcard = gon.dcard_result;
    let ptt = gon.ptt_result;
    let all_date = [];
    let ptt_line = [];
    let dcard_line = [];
    let all_board = [];
    let ptt_board_cal = [];
    let dcard_board_cal = [];
    let dcard_board = []
    let ptt_board = [];
    let dcard_source1 = []
    let dcard_source2 = []
    let dcard_source3 = []
    let dcard_source4 = []
    let dcard_source5 = []
    let ptt_source1 = []
    let ptt_source2 = []
    let ptt_source3 = []
    let ptt_source4 = []
    let ptt_source5 = []

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
        dcard_source1[d] = 0
        dcard_source2[d] = 0
        dcard_source3[d] = 0
        dcard_source4[d] = 0
        dcard_source5[d] = 0
        ptt_source1[d] = 0
        ptt_source2[d] = 0
        ptt_source3[d] = 0
        ptt_source4[d] = 0
        ptt_source5[d] = 0
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

    const total_result = []
    Object.keys(ptt_line).forEach(function(time) {
        total_result[time] |= 0
        total_result[time] += ptt_line[time]
        total_result[time] += dcard_line[time]

    })

    const ptt_divsion = Object.values(ptt_line).map(function(n, i) { return n / Object.values(total_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const dcard_divsion = Object.values(dcard_line).map(function(n, i) { return n / Object.values(total_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const ptt_bgc = ptt_divsion.map(x => x = "rgba(0,0,0,0.5)")
    const dcard_bgc = dcard_divsion.map(x => x = "rgba(0,106,166,0.5)")
    console.log(total_result)
    console.log(ptt_divsion)
        //board
    board.forEach((e) => {
        all_board.push(e.alias)
    })

    all_board.forEach((e) => {
        ptt_board_cal[e] = 0;
        dcard_board_cal[e] = 0;
    });

    if (dcard !== undefined) {
        dcard.forEach((e) => {
            board.forEach((b) => {
                if (e.alias === b.alias) {
                    dcard_board_cal[e.alias] += 1;
                }
            })
        })
    }
    if (ptt !== undefined) {
        ptt.forEach((e) => {
            board.forEach((b) => {
                if (e.alias === b.alias) {
                    ptt_board_cal[e.alias] += 1;
                }
            })
        })
    }

    for (const [key, value] of Object.entries(dcard_board_cal)) {
        dcard_board.push([key, value])
    }

    for (const [key, value] of Object.entries(ptt_board_cal)) {
        ptt_board.push([key, value])
    }

    dcard_board.sort(function(a, b) {
        return b[1] - a[1];
    });

    ptt_board.sort(function(a, b) {
        return b[1] - a[1];
    });

    if (gon.result !== undefined) {
        gon.result.forEach((e) => {
            let d_result = `${new Date(e.created_at).getFullYear()}-${
          new Date(e.created_at).getMonth() + 1
        }-${new Date(e.created_at).getDate()}`;
            if (e.alias === dcard_board.slice(0, 5)[0][0]) {
                dcard_source1[d_result] += 1;
            } else if (e.alias === dcard_board.slice(0, 5)[1][0]) {
                dcard_source2[d_result] += 1;
            } else if (e.alias === dcard_board.slice(0, 5)[2][0]) {
                dcard_source3[d_result] += 1;
            } else if (e.alias === dcard_board.slice(0, 5)[3][0]) {
                dcard_source4[d_result] += 1;
            } else if (e.alias === dcard_board.slice(0, 5)[4][0]) {
                dcard_source5[d_result] += 1;
            }
        });
    }

    if (gon.result !== undefined) {
        gon.result.forEach((e) => {
            let d_result = `${new Date(e.created_at).getFullYear()}-${
          new Date(e.created_at).getMonth() + 1
        }-${new Date(e.created_at).getDate()}`;
            if (e.alias === ptt_board.slice(0, 5)[0][0]) {
                ptt_source1[d_result] += 1;
            } else if (e.alias === ptt_board.slice(0, 5)[1][0]) {
                ptt_source2[d_result] += 1;
            } else if (e.alias === ptt_board.slice(0, 5)[2][0]) {
                ptt_source3[d_result] += 1;
            } else if (e.alias === ptt_board.slice(0, 5)[3][0]) {
                ptt_source4[d_result] += 1;
            } else if (e.alias === ptt_board.slice(0, 5)[4][0]) {
                ptt_source5[d_result] += 1;
            }
        });
    }

    const dcard_result = []
    Object.keys(dcard_source1).forEach(function(time) {
        dcard_result[time] |= 0
        dcard_result[time] += dcard_source1[time]
        dcard_result[time] += dcard_source2[time]
        dcard_result[time] += dcard_source3[time]
        dcard_result[time] += dcard_source4[time]
        dcard_result[time] += dcard_source5[time]
    })

    const ptt_result = []
    Object.keys(ptt_source1).forEach(function(time) {
        ptt_result[time] |= 0
        ptt_result[time] += ptt_source1[time]
        ptt_result[time] += ptt_source2[time]
        ptt_result[time] += ptt_source3[time]
        ptt_result[time] += ptt_source4[time]
        ptt_result[time] += ptt_source5[time]
    })

    // const dcard_result = [dcard_source1, dcard_source2, dcard_source3, dcard_source4, dcard_source5].reduce(function(rs, source) {
    //     return Object.keys(source).reduce(function(result, time) {
    //         result[time] |= 0
    //         result[time] += source[time]
    //         return result
    //     }, rs)
    // }, {})

    const dcard_source1_divsion = Object.values(dcard_source1).map(function(n, i) { return n / Object.values(dcard_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const dcard_source2_divsion = Object.values(dcard_source2).map(function(n, i) { return n / Object.values(dcard_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const dcard_source3_divsion = Object.values(dcard_source3).map(function(n, i) { return n / Object.values(dcard_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const dcard_source4_divsion = Object.values(dcard_source4).map(function(n, i) { return n / Object.values(dcard_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const dcard_source5_divsion = Object.values(dcard_source5).map(function(n, i) { return n / Object.values(dcard_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const dcard_source1_bgc = dcard_source1_divsion.map(x => x = "rgba(244,143,177,0.7)")
    const dcard_source2_bgc = dcard_source2_divsion.map(x => x = "rgba(129,212,250,0.7)")
    const dcard_source3_bgc = dcard_source3_divsion.map(x => x = "rgba(178,151,196,0.7)")
    const dcard_source4_bgc = dcard_source4_divsion.map(x => x = "rgba(245,203,116,0.7)")
    const dcard_source5_bgc = dcard_source5_divsion.map(x => x = "rgba(55,71,79,0.7)")

    const ptt_source1_divsion = Object.values(ptt_source1).map(function(n, i) { return n / Object.values(ptt_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const ptt_source2_divsion = Object.values(ptt_source2).map(function(n, i) { return n / Object.values(ptt_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const ptt_source3_divsion = Object.values(ptt_source3).map(function(n, i) { return n / Object.values(ptt_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const ptt_source4_divsion = Object.values(ptt_source4).map(function(n, i) { return n / Object.values(ptt_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const ptt_source5_divsion = Object.values(ptt_source5).map(function(n, i) { return n / Object.values(ptt_result)[i]; }).map(x => Math.round(x * 10000) / 100 || 0);
    const ptt_source1_bgc = ptt_source1_divsion.map(x => x = "rgba(255,0,0,0.5)")
    const ptt_source2_bgc = ptt_source2_divsion.map(x => x = "rgba(255,255,0,0.5)")
    const ptt_source3_bgc = ptt_source3_divsion.map(x => x = "rgba(0,255,0,0.5)")
    const ptt_source4_bgc = ptt_source4_divsion.map(x => x = "rgba(0,0,0,0.5)")
    const ptt_source5_bgc = ptt_source5_divsion.map(x => x = "rgba(255,0,255,0.5)")


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
                            return data.datasets[tooltipItems.datasetIndex].label + ': ' + tooltipItems.yLabel + '%';
                        }
                    }
                },
                scales: {
                    yAxes: [{
                        stacked: true,
                        ticks: {
                            max: 100,
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
                    fontSize: 30,
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
                        label: dcard_board.slice(0, 5)[0][0],
                        backgroundColor: dcard_source1_bgc,
                        fillColor: "#000000",
                        data: dcard_source1_divsion
                    },
                    {
                        label: dcard_board.slice(0, 5)[1][0],
                        backgroundColor: dcard_source2_bgc,
                        data: dcard_source2_divsion
                    },
                    {
                        label: dcard_board.slice(0, 5)[2][0],
                        backgroundColor: dcard_source3_bgc,
                        data: dcard_source3_divsion
                    },
                    {
                        label: dcard_board.slice(0, 5)[3][0],
                        backgroundColor: dcard_source4_bgc,
                        data: dcard_source4_divsion
                    },
                    {
                        label: dcard_board.slice(0, 5)[4][0],
                        backgroundColor: dcard_source5_bgc,
                        data: dcard_source5_divsion
                    },
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
                            max: 100,
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
                    text: "Dcard 討論版來源長條圖",
                    fontSize: 30,

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
                        label: ptt_board.slice(0, 5)[0][0],
                        backgroundColor: ptt_source1_bgc,
                        fillColor: "#000000",
                        data: ptt_source1_divsion
                    },
                    {
                        label: ptt_board.slice(0, 5)[1][0],
                        backgroundColor: ptt_source2_bgc,
                        data: ptt_source2_divsion
                    },
                    {
                        label: ptt_board.slice(0, 5)[2][0],
                        backgroundColor: ptt_source3_bgc,
                        data: ptt_source3_divsion
                    },
                    {
                        label: ptt_board.slice(0, 5)[3][0],
                        backgroundColor: ptt_source4_bgc,
                        data: ptt_source4_divsion
                    },
                    {
                        label: ptt_board.slice(0, 5)[4][0],
                        backgroundColor: ptt_source5_bgc,
                        data: ptt_source5_divsion
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
                            max: 100,
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
                    text: "PTT 討論版來源長條圖",
                    fontSize: 30,
                },
                legend: {
                    display: false,
                },
            },
        });
    };
})