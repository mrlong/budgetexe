/*
 * 测试连接功能
 * 
 *
 *
 *
 */

var net = require('net');
var client = net.connect({port:1377},function(){
  console.log('client connected');
  client.write('wrold!\r\n');
});

client.on('data',function(data){
  console.log(data.toString());
  client.end();
});

client.on('end',function(){
  console.log('client disconnected');
});

