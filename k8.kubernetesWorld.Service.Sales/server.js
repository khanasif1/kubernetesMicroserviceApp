'use strict';

var express = require('express'); // Web Framework
var app = express();

const request = require("request");
const urlProducts = "http://localhost:8082/api/Product";
const urlStaff = "http://localhost:8083/api/Staff";

//var sql = require('mssql'); // MS Sql Server client

//// Connection string parameters.
//var sqlstaffConnection = {
//    user: 'sa',
//    password: 'Redhat0!',
//    server: 'localhost',
//    database: 'staffDB'
//}
//var sqlproductConnection = {
//    user: 'sa',
//    password: 'Redhat0!',
//    server: 'localhost,1432',
//    database: 'productDB'
//}
// Start server and listen on http://localhost:8085/
var server = app.listen(8085, function () {
    var host = server.address().address
    var port = server.address().port

    console.log("app listening at http://%s:%s", host, port)
});

app.get('/', function (req, res) {
    var jsonstaffData = "";
    var jsonproductData = "";
    var salesresponse = [];


    request.get(urlProducts, (error, response, body) => {
        jsonproductData = JSON.parse(body);
        request.get(urlStaff, (error, response, body) => {
            jsonstaffData = JSON.parse(body);
            printResponse();
        });    
    });

    //request.get(urlStaff, (error, response, body) => {
    //    jsonstaffData = JSON.parse(body);   
    //    printResponse();
    //});    



    function printResponse() {
        //console.log(jsonproductData);
        //console.log(jsonstaffData);

        for (var x = 0; x < jsonproductData.length; x++) {            
            var seller = {
                sellerid: jsonstaffData[x].id,
                sellername: jsonstaffData[x].firstName + ' ' + jsonstaffData[x].lastName,
                saleitem: jsonproductData[x].id,
                saleitemname: jsonproductData[x].name
            };
            
            salesresponse.push(seller);
        }
        console.log(salesresponse);
        res.send(salesresponse);
    }   

    //sql.connect(sqlstaffConnection, function () {
    //    var request = new sql.Request();
    //    request.query('select * from staff', function (err, data) {
    //        if (err) console.log(err);
    //        console.log(data);
    //        //console.table(data.recordset)
    //        //console.log(data.rowsaffected);
    //        //console.log(data.recordset[0]);
    //        if (data != null) {
    //            jsonstaffData = data.recordset;
    //            console.log("length" + jsonstaffData.length);
    //            res.send(jsonstaffData);
    //        }
    //        else {
    //            res.send(data);
    //        }
    //    });
    //});

});

