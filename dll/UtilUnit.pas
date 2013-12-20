///////////////////////////////////////////////////////////
//
//  �������ӿ�ӿڶ��� �����汾: Delphi XE5
//  ���ߣ�������     2013-12-20
//
//  �޸�
// ���     ����      ʱ��       �޸�����
//  1     ������   2013-12-20   �����ļ�
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

    //�ӿ�����
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
    flags       : DWORD ; //������ʽ
    flag        : Integer;
    m_bOnline   : Boolean;
  begin
    //1.ȡintere����������
    ConnectState:= 0;
    StateSize:= SizeOf(ConnectState);
    result:= false;
    if InternetQueryOption(nil, INTERNET_OPTION_CONNECTED_STATE,
      @ConnectState, StateSize) then
    if (ConnectState and INTERNET_STATE_DISCONNECTED) <> 2 then
      result:= true;

    if not Result then Exit;


    //2.ȷ�����������Ƿ��
    flags := INTERNET_CONNECTION_MODEM+INTERNET_CONNECTION_LAN+INTERNET_CONNECTION_PROXY;
    m_bOnline :=InternetGetConnectedState(@flags,0);
    if m_bOnline then
    begin
      Result :=  ((flags and INTERNET_CONNECTION_MODEM)=INTERNET_CONNECTION_MODEM) or
               ((flags and INTERNET_CONNECTION_LAN)=INTERNET_CONNECTION_LAN) or
               ((flags and INTERNET_CONNECTION_PROXY)=INTERNET_CONNECTION_PROXY);
    end
    else begin
      // ��ʱ InternetGetConnectedState ������,������һ���ܷ���ֵ
      //��ˮ�����������
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
