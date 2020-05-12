'use strict';

var express = require('express'); // Web Framework
var app = express();
var sql = require('mssql'); // MS Sql Server client

// Connection string parameters.
var sqlConfig = {
    user: 'sa',
    password: 'Redhat0!',
    server: 'localhost',
    database: 'staffDB'
}

// Start server and listen on http://localhost:8085/
var server = app.listen(8085, function () {
    var host = server.address().address
    var port = server.address().port

    console.log("app listening at http://%s:%s", host, port)
});

app.get('/staff', function (req, res) {
    sql.connect(sqlConfig, function () {
        var request = new sql.Request();
        request.query('Select * from Staff', function (err, recordset) {
            if (err) console.log(err);
            res.end(JSON.stringify(recordset)); // Result in JSON format
        });
    });
})