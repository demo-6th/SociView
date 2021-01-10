// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
const images = require.context("../images", true);
const imagePath = (name) => images(name, true);

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("styles");
require("script");
require("chart.js");
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
