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
    onChange: function(selectedDates, dateStr, instance) {
      endPicker.set('minDate', selectedDates[0]);
    }
  });
  endPicker = flatpickr(".datepicker_end", {});

})