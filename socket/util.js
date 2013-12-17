/*
 * 项目: 客户端Delphi连接模块
 * 公共方法模块
 *
 * 作者：龙仕云 2013-12-17
 *
 * 修改记录
 *  编号    作者     时期        修改内容
 *   1     龙仕云  2013-12-17   创建文件
 *  
 *
 */

//日期的格式
Date.prototype.Format = function (fmt) { 
  var o = {
    "M+": this.getMonth() + 1, //月份 
    "d+": this.getDate(),      //日 
    "h+": this.getHours(),     //小时 
    "m+": this.getMinutes(),   //分 
    "s+": this.getSeconds(),   //秒 
    "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
    "S": this.getMilliseconds() //毫秒 
  };
  if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
  for (var k in o){
    if (new RegExp("(" + k + ")").test(fmt)){
      fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    }    
  };
  return fmt;
};

exports.getTimeNow = function(){
  return new Date().Format('yyyy-MM-dd hh:mm:ss');//  toUTCString();
};