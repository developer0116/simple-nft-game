var express = require('express');
var app = express();
app.set('view engine','ejs');
app.use('/assets', express.static(__dirname+'/js'));
app.get('/', function (req, res) {
    res.render('Welcome');
});
app.listen(3030);
