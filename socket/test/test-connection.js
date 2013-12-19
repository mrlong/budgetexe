/*
 * 测试连接功能
 * 
 *
 *
 *
 */

var net = require('net');
var client = net.connect({host:'192.168.1.104',port:1377},function(){
  console.log('client connected');
  var jdata = {
    ver:1,
    success:true,
    msg:'',
    command:'datetime',
    zip:false,
    encrypt:false,
    data:{} 

  }
  var buf = new Buffer(jdata);
  client.write(buf);
});

client.on('data',function(data){

  console.log(data.toString());
  client.end();
});

client.on('end',function(){
  console.log('client disconnected');
});

