/*
 * 上传文件功能
 *
 *  作者：龙仕云 2013-12-30
 {
   ver:1,
   success:true,
   msg:'',
   command:'',
   zip:'',
   encrypt:'',
   data:{
     filename:'',
     length:121,
     md5:''
   }
  }
 */

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
