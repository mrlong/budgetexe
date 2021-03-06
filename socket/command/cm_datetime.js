//
// 规定，文件名就是cm_命令的名称.js
// 获取系统时间
//
// 作者：龙仕云  2013-12-27
//
var DP = require('../datapack.js');
var util = DP.util;
var LN = DP.LN; //回车

exports.R=function(server,socket,data,callback){
  
  var d = util.getTimeNow();
  var dp = new DP.datapack({
    success : true,
    command : data.command,
    data    : {datetime:d},
    pid     : process.pid // worker.id 
  });
  callback(dp);
};
