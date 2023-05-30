const express = require('express');
const path = require('path');
const morgan = require('morgan');
const mysql = require('mysql');
const myConnection = require('express-myconnection');
const app = express();
const compraRoutes = require('./routes/compra');
const productosRoutes = require('./routes/productos');
const customerRoutes = require('./routes/customer');

app.set('port', process.env.PORT || 5000);
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.use(morgan('dev'));
app.use(myConnection(mysql, {
  host: 'localhost',
  user: 'root',
  password: '',
  port: 3306,
  database: 'customersdb'
}, 'single'));
app.use(express.urlencoded({ extended: false }));

app.use('/customer', customerRoutes);
app.use('/productos', productosRoutes);
app.use('/compra', compraRoutes);
app.use(express.static(path.join(__dirname, 'public')));

app.listen(app.get('port'), () => {
  console.log('Server running on port', app.get('port'));
});
