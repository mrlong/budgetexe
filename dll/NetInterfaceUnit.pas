///////////////////////////////////////////////////////////
//
//  网络连接库接口定义 开发版本: Delphi XE5
//  作者：龙仕云     2013-12-20
//
//  不经受权，不要随意拷贝网络与电子转发.
//
//  修改
// 编号     作者      时间       修改内容
//  1     龙仕云   2013-12-20   创建文件
//
//
///////////////////////////////////////////////////////////

unit NetInterfaceUnit;

interface
uses
  Windows;
type

  INet = interface
    ['{2B71FED7-0CDF-4D6A-A3EE-D6CF3F37B29B}']

    //连接服务器，连接前确定是否已在连接了。
    function Connect(Atimeout:integer):boolean;stdcall;
    procedure Disconnect();stdcall;
    function Connected():Boolean;stdcall;

    //获取服务器时间
    function GetServerDataTime():widestring; stdcall;
    //按名称取出变量值来
    // welcome =欢迎语
    // authorized =true 表示服务器认证成功
    function GetValueByName(AName:widestring;var AValue:Variant):Boolean;stdcall;

  end;



  //Net.dll接口
  //
  // 参数: AConfig
  // {
  //   ssl: true  表示采用ssl连接，这时key ,cert可填写
  //   key: "绝对路径"
  //   cert: "绝对路径"
  //   host: "" 服务器ip
  //   port: 1377
  // }
  //
  function CreateNet(AHandle:HWND;AConfig:widestring): INet; stdcall; external 'net.dll';

  //断定是否在线
  function CheckOnLine: Boolean; stdcall; external 'net.dll';

implementation

end.
