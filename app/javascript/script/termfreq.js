function termfreq_chart(gon) {
  console.log("aaa")
  let vterm = gon.vterm;
  let vfreq = gon.vfreq;
  let nterm = gon.nterm;
  let nfreq = gon.nfreq;
  let adjterm = gon.adjterm;
  let adjfreq = gon.adjfreq;

  function termfreqChart(pos, term, freq, pos_ch) {
    const posbar = document.getElementById(pos + "Count").getContext("2d");
    const barChart = new Chart(posbar, {
      type: "horizontalBar",
      data: {
        labels: term,
        datasets: [
          {
            data: freq,
            backgroundColor: "rgba(75,192,192,0.5)",
          },
        ],
      },
      options: {
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true,
              },
            },
          ],
          xAxes: [
            {
              barThickness: 100,
              maxBarThickness: 150,
            },
          ],
        },
        title: {
          display: true,
          text: pos_ch + "長條圖",
        },
        legend: {
          display: false,
        },
      },
    });
  }

  if (document.getElementById("verbCount")) {
    termfreqChart("verb", vterm, vfreq, "動詞");
    termfreqChart("noun", nterm, nfreq, "名詞");
    termfreqChart("adj", adjterm, adjfreq, "形容詞");
  }
}
export default termfreq_chart;
