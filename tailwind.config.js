module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        body: [
          'Hiragino Sans',
          'ヒラギノ角ゴシック',
          'メイリオ',
          'Meiryo',
          'MS Ｐゴシック',
          'MS PGothic',
          'sans-serif',
          'YuGothic',
          'Yu Gothic',
        ],
      },
      colors: {
        primary: "#222831",               
        secondary: "#31363F",              
        accent: "#c1ff72",           
        neutral: "#25262b",           
        white: "#eeeeee",            
        info: "#007be3",             
        success: "#6faf00",             
        warning: "#c67400",             
        error: "#f44561",
      },
    },
  },
  plugins: [require("daisyui")],
}