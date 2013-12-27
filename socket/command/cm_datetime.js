//
// 规定，文件名就是cm_命令的名称.js
// 获取系统时间
//
// 作者：龙仕云  2013-12-27
//
var DP = require('../datapack.js');
var util = DP.util;
var LN = DP.LN; //回车

exports.R=function(server,socket,json){
  
  var d = util.getTimeNow();
  var dp = new DP.datapack({
    success : true,
    command : json.command,
    data    : {datetime:d},
    pid     : process.pid // worker.id 
  });
  socket.write(JSON.stringify(dp));

  //注意，最后一定有回车。
  socket.write(LN);
};
