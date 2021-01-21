const images = require.context("../images", true);
const imagePath = (name) => images(name, true);

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("styles");
require("flatpickr")
import "flatpickr/dist/flatpickr.min.css";
require("chart.js");
require("script");