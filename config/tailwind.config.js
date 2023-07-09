const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Noto Sans', 'sans-serif'],
      },
    },
    colors: {
      'black-dark': '#0B090B',
      'black': '#120F14',
      'black-soft': '#252329',
      'grey': '#3C393F',
      'grey-soft': '#828282',
      'blue': '#3081ED',
      'white': '#ffffff',
      'red-soft': '#FDA4AF',
      'red': '#BE113C',
      'green-soft': '#BBF7D0',
      'green': '#18A34A'
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
