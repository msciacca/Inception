const express = require('express')

const app = express()

app.use(express.static('public'))
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html');


app.listen(3000, () => {
    console.log("server running on port 3000")
})

app.get('/', function (req, res) {
    res.render('index', {});
  });

app.get('/mysite', function (req, res) {
    res.render('index', {});
  });