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

unit UtilUnit;

interface
uses
  SysUtils,Windows,Classes,
  IdIOHandler, IdIOHandlerSocket,IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  NetInterfaceUnit;

type

  TNet = class(TInterfacedObject,INet)
  private
    fHandle  : THandle;
    fIdSSLIOHandler : TIdSSLIOHandlerSocketOpenSSL;
  public
    constructor Create(AHandle:THandle;AConfig:string);
    destructor Destroy; override;

    //接口内容
    function GetServerDataTime():widestring; stdcall;
  end;

  function CreateNet(AHandle:HWND;AConfig:widestring): INet; stdcall;
  function CheckOnLine: Boolean; stdcall;

implementation
uses
  Vcl.forms,
  IdTCPClient,
  WinInet;

  function IsNetworkAlive(var varlpdwFlagsLib:Integer):Integer;stdcall;external 'sensapi.dll';

  function CreateNet(AHandle:HWND;AConfig:WideString): INet; stdcall;
  begin
    Result := TNet.Create(AHandle,AConfig);
  end;

  function CheckOnLine: Boolean; stdcall;
  var
    ConnectState: DWORD;
    StateSize   : DWORD;
    flags       : DWORD ; //上网方式
    flag        : Integer;
    m_bOnline   : Boolean;
  begin
    //1.取intere的配置内容
    ConnectState:= 0;
    StateSize:= SizeOf(ConnectState);
    result:= false;
    if InternetQueryOption(nil, INTERNET_OPTION_CONNECTED_STATE,
      @ConnectState, StateSize) then
    if (ConnectState and INTERNET_STATE_DISCONNECTED) <> 2 then
      result:= true;

    if not Result then Exit;


    //2.确定物理连接是否对
    flags := INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;
    m_bOnline :=InternetGetConnectedState(@flags,0);
    if m_bOnline then
    begin
      Result :=  ((flags and INTERNET_CONNECTION_MODEM)=INTERNET_CONNECTION_MODEM) or
               ((flags and INTERNET_CONNECTION_LAN)=INTERNET_CONNECTION_LAN) or
               ((flags and INTERNET_CONNECTION_PROXY)=INTERNET_CONNECTION_PROXY);
    end
    else begin
      // 有时 InternetGetConnectedState 不好有,有连网一样能返回值
      //华水市政就这情况
      IsNetworkAlive(flag);
      Result := (flag=1{NETWORK_ALIVE_LAN}) or
                (flag=2{ConstNETWORK_ALIVE_WAN}) or
                (flag=4{ConstNETWORK_ALIVE_AOL});
    end;

    if not Result then Exit;

    Result := InternetCheckConnection('http://www.baidu.com',1,0);
    //if not Result then
    //  Result := InternetCheckConnection('http://www.163.com',1,0);
  end;



{ TNet }

constructor TNet.Create(AHandle: THandle; AConfig: string);
begin
  fHandle := Application.Handle;
  Application.Handle := AHandle;
  fIdSSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  //fIdSSLIOHandler.SSLOptions.CertFile :=

end;

destructor TNet.Destroy;
begin
  fIdSSLIOHandler.Free;
  Application.Handle := fHandle;
  inherited;
end;

function TNet.GetServerDataTime: widestring;
begin
  //
end;

end.
