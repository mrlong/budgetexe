/*
 * 测试连接功能
 * 
 *
 *
 *
 */
var tls = require('tls');
var fs  = require('fs');
var net = require('net');

var options = {
  key: fs.readFileSync('../../keys/client.key'),
  cert: fs.readFileSync('../../keys/client.crt'),
  ca:[fs.readFileSync('../../keys/ca.crt')],
  rejectUnauthorized : true
};

var client = tls.connect(1377,options,function(){
  console.log('client connected');
  //process.stdin.pipe(client);
  //process.stdin.resume();
  try{
    client.write('mrlong\r\n');
  } catch(e) {
   console.log('s');
  } finally{
    console.log('t');
  }
});

client.setEncoding('utf8');

client.on('data',function(data){
  console.log(data.toString());
  //client.end();
});

client.on('end',function(){
  console.log('client disconnected');
});

