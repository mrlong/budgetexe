/*
 * 用与客户端Delphi进行通过信息应用。
 * 作者:龙仕云 2013-12-17
 *
 * 修改记录
 *  编号    作者     时期        修改内容
 *   1     龙仕云  2013-12-17   创建文件
 *  
 *
 */

var net = require('net');
var settings = require('./settings');
var util = require('./util');
var clientdata = require('./data');
//var buffer = require('buffer');

var clients = [];  //客户端集合
var Option ={
  allowHalfOpen:false
};

var server = net.createServer(Option,function(socket){

  socket.name = socket.remoteAddress + ":" + socket.remotePort;
  clients.push(socket);
  socket.write( util.getTimeNow() + ' ' +  
    socket.name + ' in ' +
    settings.welcome + 
  '\r\n');
  
  socket.on('data', function(data) {
    console.log('长度' + data.length + '内容:' +data.toString() );
    clientdata.ClientData(this,socket,data);
  });

  socket.on('end', function() {
    clients.splice(clients.indexOf(socket), 1);
    console.log(socket.name + ' left end.');
  });

  socket.on('close', function(data) {
    console.log('close event');
  });

});

server.on('error', function (e) {
  if (e.code == 'EADDRINUSE') {
    console.log('Address in use, retrying...');
    setTimeout(function () {
      server.close();
      server.listen(settings.port, settings.host);
    }, 1000);
  }
});

server.on('drain',function(){
  console.log('server send data');
});


server.listen(settings.port,settings.host);
console.log('listen ' + settings.host + ':' + settings.port);
