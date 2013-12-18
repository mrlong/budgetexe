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
var cluster = require('cluster');
var numCPUs = require('os').cpus().length; //cpu核数

var clients = [];  //客户端集合
var Option ={
  allowHalfOpen:false
};

if(cluster.isMaster){
  for (var i = 0; i < numCPUs; i++) {
    var worker = cluster.fork();
    worker.on('online', function() {
      util.log('on line wid:' + worker.process.pid);
    });
  }
  util.log('cluster.isMaster');
  
  cluster.on('exit', function(worker, code, signal) {
    util.log('worker ' + worker.process.pid + ' died ('+ (signal || code) +'). restarting...');
    cluster.fork();
  });

} else if (cluster.isWorker) {

  var server = net.createServer(Option,function(socket){
    socket.name = socket.remoteAddress + ":" + socket.remotePort;
    clients.push(socket);
    socket.write( util.getTimeNow() + ' ' +  
      socket.name + ' in ' +
      settings.welcome + '\r\n');
  
    socket.on('data', function(data) {
      util.log('长度' + data.length + '内容:' +data.toString());
      clientdata.ClientData(this,socket,data);
    });

    socket.on('end', function() {
      clients.splice(clients.indexOf(socket), 1);
      util.log(socket.name + ' 离开. 目前在线人数:' + clients.length);
    });

    // socket.on('close', function(data) {
    //   util.log('close event');
    // });

  });

  server.on('error', function (e) {
    if (e.code == 'EADDRINUSE') {
      util.log('Address in use, retrying...');
      setTimeout(function () {
        server.close();
        server.listen(settings.port, settings.host);
      }, 1000);
    }
  });

  server.on('drain',function(){
    util.log('server send data');
  });

  server.listen(settings.port,settings.host);
  util.log('listen ' + settings.host + ':' + settings.port + ' pid:' + process.pid);

} // cluster.isMaster




