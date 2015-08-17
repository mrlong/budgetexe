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
 *  data:{}          //数据包内容,可能有类型不一样，包的内容不一样, 
 *                   //如是压缩的, 则是 {length:1253,md5:'xxxxxx',filename:''}等参数
 *                   //接着向后读取数据包. 
 * }
 * 
 * command:
 *   datetime = 取出服务器的日期 data:{datetime:""};
 *   login    = 登录 
 *
 */
var util = require('./util');
var fs = require('fs');
var zlib = require('zlib');
var LN = '\r\n';
var commandlist = []; //命令集合

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

//枚举出所有的命令集合
exports.enumcommand=function(){
  fs.readdir('./command', function(err, files){
    if(!err){
      files.forEach(function(item) {  
        var tmpPath = './command/' + item;
        debugger;
        if (fs.statSync(tmpPath).isFile() && tmpPath.indexOf('.js')>0){
          var commandname = item.substr(3,item.length-6);
          //console.log(commandname);
          var a =  require(tmpPath);
          commandlist.push([commandname,a.R]);
        };//isFile() 
      });
    };
  });
}

exports.ClientData = function(server,socket,data){
  //如data的包有压缩怎么处理
  var mydata = JSON.parse(data.toString());
  //路由
  for (var i = 0; i < commandlist.length; i++) {
    var command = null;
    if (commandlist[i][0]===mydata.command){
      command = commandlist[i];
      break;
    }
  }

  if(command){
    command[1](server,socket,mydata,function(dp){
      socket.write(JSON.stringify(dp));
      //注意，最后一定有回车。
      socket.write(LN);
    });  
  }
  else {
    var dp = new datapack({
      success:false,
      msg:'未定义的命令'
    });
    socket.write(JSON.stringify(dp));
    socket.write(LN);  
  }
};

exports.datapack=datapack;
exports.util=util;
exports.LN=LN;

