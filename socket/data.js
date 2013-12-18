/*
 * 项目: 客户端Delphi连接模块
 *  处理客户端转过来的内容处理。
 *  
 * 作者:龙仕云 日期: 2013-12-17
 * 
 * 修改
 *  编号   作者   日期        修改内容
 *   1   龙仕云  2013-12-17   创建文件
 */

/* 协议包结构
 * 
 * {
 *  ver: 1,          //表示包的版本号,结构版本
 *  success: true,   //=true表示成功
 *  msg: '信息说明', 
 *  command:'',      //命令名
 *  zip:false,       //true 表示压缩过了
 *  encrypt:true,    //=true 表示包是加密的包 , 如有压缩是先压缩后解密
 *  data:{}          //数据包内容,可能有类型不一样，包的内容不一样
 * }
 * 
 * command:
 *   datetime = 取出服务器的日期 data:{datetime:""};
 *   login    = 登录 
 *
 */
var util = require('./util');
var LN = '\r\n';

function datapack(items){
  this.ver = 1;
  this.success = true;
  this.msg = '';
  this.command = '';
  this.encrypt = false;
  this.zip = false;
  this.data = {};
  if(items){
    cloneAll(items,this);
  };
};

//对象拷贝
function cloneAll(source,dirc){
  for(var key in source){
    if(typeof source[key] === "object"){
      dirc[key]= {};            
      cloneAll(source[key],dirc[key]);            
      continue;        
    }
    else{         
      dirc[key] = source[key]; 
    }   
  }   
};

datapack.prototype.clone=function(source){
  cloneAll(source,this);
  return this;
};


exports.ClientData = function(server,socket,data){
  var mydata = JSON.parse(data.toString());
  
  if (mydata.command ==='datetime'){
    Dodatetime(server,socket,mydata);
  } else {
    var dp = new datapack({
      success:false,
      msg:'未定义的命令'
    });
    socket.write(JSON.stringify(dp));
    socket.write(LN);
  }
};


//datetime
function Dodatetime(server,socket,json){
  var d = util.getTimeNow();
  var dp = new datapack({
    success : true,
    command : json.command,
    data    : {datetime:d},
    pid     : process.pid // worker.id 
  });
  socket.write(JSON.stringify(dp));
  socket.write(LN);
};