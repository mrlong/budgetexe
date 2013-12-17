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

var Option ={
  allowHalfOpen:false
};

var server = net.createServer(Option,function(socket){
  socket.write(util.getTimeNow() +' Echo server' + this.connections + '\r\n');
  socket.on('data', function(data) {
    console.log(data.toString());
  });

  socket.on('end', function() {
    console.log('server disconnected-' + socket.localAddress);
  });

});

server.on('error', function (e) {
  if (e.code == 'EADDRINUSE') {
    console.log('Address in use, retrying...');
    setTimeout(function () {
      server.close();
      server.listen(PORT, HOST);
    }, 1000);
  }
});

server.on('drain',function(){
  console.log('server send data');
});


server.listen(settings.port,settings.host);
console.log('listen ' + settings.host + ':' + settings.port);