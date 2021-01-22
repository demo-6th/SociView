document.addEventListener("turbolinks:load", () => {
  let vterm = gon.vterm;
  let vfreq = gon.vfreq;
  let nterm = gon.nterm;
  let nfreq = gon.nfreq;
  let adjterm = gon.adjterm;
  let adjfreq = gon.adjfreq;

  if (document.getElementById("verbCount")) {
    const verb_bar = document.getElementById("verbCount").getContext("2d");
    const verbBar = new Chart(verb_bar, {
      type: "horizontalBar",
      data: {
        labels: vterm,
        datasets: [
          {
            label: "動詞長條圖",
            data: vfreq,
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
          text: "動詞詞頻長條圖",
        },
        legend: {
          display: false,
        },
      },
    });

    const noun_bar = document.getElementById("nounCount").getContext("2d");
    const nounBar = new Chart(noun_bar, {
      type: "horizontalBar",
      data: {
        labels: nterm,
        datasets: [
          {
            label: "名詞長條圖",
            data: nfreq,
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
          text: "名詞詞頻長條圖",
        },
        legend: {
          display: false,
        },
      },
    });

    const adj_bar = document.getElementById("adjCount").getContext("2d");
    const adjBar = new Chart(adj_bar, {
      type: "horizontalBar",
      data: {
        labels: adjterm,
        datasets: [
          {
            label: "形容詞長條圖",
            data: adjfreq,
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
          text: "形容詞詞頻長條圖",
        },
        legend: {
          display: false,
        },
      },
    });
  }
});
