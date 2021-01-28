document.addEventListener("turbolinks:load", () => {
  // flatpickr(".datepicker_start", {
  //   onClose: function(dateObj, dateStr, instance){
  //     // doSomething
  //  }
  // })

  // flatpickr(".datepicker_end", {
  //   onClose: function(dateObj, dateStr, instance){
  //     // doSomething
  //   }
  // })
  startPicker = flatpickr(".datepicker_start", {
    enable: [
      {
        from: "2021-01-14",
        to: "2021-01-21",
      },
    ],
    onChange: function (selectedDates, dateStr, instance) {
      endPicker.set("minDate", selectedDates[0]);
      endPicker.set("maxDate", "2021-01-21");
    },
  });
  endPicker = flatpickr(".datepicker_end", {});
});
