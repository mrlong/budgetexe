var tls = require('tls');
var net = require('net');
var fs  = require('fs');

var Options ={
  key: fs.readFileSync('../../keys/server.key'),
  cert: fs.readFileSync('../../keys/server.crt'),
  ca:[fs.readFileSync('../../keys/ca.crt')],
  requestCert:true,
  rejectUnauthorized : false
}

var server = tls.createServer(Options,function(stream){
    console.log('server connected',stream.authorized ?'authorized':'unauthorized');
    stream.write('welcome!\r\n');
    stream.setEncoding('utf8');
    stream.pipe(stream);  
});

server.listen(8000,function(){
  console.log('server bound');
});