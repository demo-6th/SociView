const colors = require('tailwindcss/colors')
module.exports = {
  purge: [
    // './src/**/*.html',
    //  './src/**/*.js',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    backgroundColor: theme => ({
      'aqua': '#00FFFF',
      'primary': '#3490dc',
      'secondary': '#ffed4a',
      'danger': '#e3342f',
     })
    extend: {},
    colors: {
      'aqua': '#00FFFF',
    }
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
