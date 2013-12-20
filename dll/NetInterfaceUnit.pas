///////////////////////////////////////////////////////////
//
//  网络连接库接口定义 开发版本: Delphi XE5
//  作者：龙仕云     2013-12-20
//
//  修改
// 编号     作者      时间       修改内容
//  1     龙仕云   2013-12-20   创建文件
//
//
///////////////////////////////////////////////////////////

unit NetInterfaceUnit;

interface

type

  INet = interface
    ['{2B71FED7-0CDF-4D6A-A3EE-D6CF3F37B29B}']

    //获取服务器时间
    function GetServerDataTime():widestring; stdcall;
  end;


implementation

end.
