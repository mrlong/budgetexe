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
  IdTCPClient,
  NetInterfaceUnit,superobject;

type

  TNet = class(TInterfacedObject,INet)
  private
    fHandle  : THandle;
    fConfig  : ISuperObject;
    fIdTCPClient : TIdTCPClient;
    fIdSSLIOHandler : TIdSSLIOHandlerSocketOpenSSL;
  public
    constructor Create(AHandle:THandle);
    destructor Destroy; override;

    //�ӿ�����
    function Connect(Atimeout:integer):boolean;stdcall;
    procedure Disconnect();stdcall;
    function Connected():Boolean;stdcall;

    function GetServerDataTime():widestring; stdcall;


  end;

  //
  // ����: AConfig
  // {
  //   ssl: true  ��ʾ����ssl���ӣ���ʱkey ,cert����д
  //   key: "����·��"
  //   cert: "����·��"
  //   host: "" ������ip
  //   port: ""
  // }
  //
  function CreateNet(AHandle:HWND;AConfig:widestring): INet; stdcall;
  function CheckOnLine: Boolean; stdcall;

implementation
uses
  Vcl.forms,
  datapack,
  WinInet;

  function IsNetworkAlive(var varlpdwFlagsLib:Integer):Integer;stdcall;external 'sensapi.dll';

  function CreateNet(AHandle:HWND;AConfig:WideString): INet; stdcall;
  var
    i : integer;
    myNet : TNet;
    myjson : ISuperObject;
  begin
    myNet := TNet.Create(AHandle);
    myjson := SO(AConfig);
    if myNet.fConfig <> nil then
      myNet.fConfig := nil;
    myNet.fConfig := myjson.Clone;
    Result := myNet;
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

function TNet.Connect(Atimeout: integer): boolean;
var
  mykey : string;
  mycret : string;
  myhost : string;
  myport : integer;
  myssl : Boolean;
begin
  //
  mykey  := fConfig.S['key'];
  mycret := fConfig.S['cert'];
  myhost := fConfig.S['host'];
  myport := fConfig.I['port'];
  myssl  := fConfig.B['ssl'];

  if (myhost='') or (myport=0) then
  begin
    Result := False;
    Exit;
  end;

  if myssl and ((mykey='') or (mycret='') )  then
  begin
    Result := False;
    Exit;
  end;


  if myssl  then
  begin
    fIdSSLIOHandler.SSLOptions.CertFile := mycret;
    fIdSSLIOHandler.SSLOptions.KeyFile  := mykey;
    fIdSSLIOHandler.SSLOptions.Method   := sslvSSLv23;
    fIdTCPClient.IOHandler := fIdSSLIOHandler;
  end;

  fIdTCPClient.ConnectTimeout := Atimeout;
  fIdTCPClient.Port := myport;
  fIdTCPClient.Host := myhost;

  try
    fIdTCPClient.Connect;
    Result := fIdTCPClient.Connected;
  except on E: Exception do
    Result := False;
  end;
end;

function TNet.Connected: Boolean;
begin
  Result := fIdTCPClient.Connected;
end;

constructor TNet.Create(AHandle: THandle);
begin
  fHandle := Application.Handle;
  Application.Handle := AHandle;
  fIdSSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  fConfig := SO;
  fIdTCPClient := TIdTCPClient.Create(nil);
end;

destructor TNet.Destroy;
begin
  if fIdTCPClient.Connected then
    fIdTCPClient.Disconnect;
  fIdTCPClient.Free;
  fIdSSLIOHandler.Free;
  fConfig := nil;
  Application.Handle := fHandle;
  inherited;
end;

procedure TNet.Disconnect;
begin
  if fIdTCPClient.Connected then
    fIdTCPClient.Disconnect;
end;

function TNet.GetServerDataTime: widestring;
var
  mydp : TDataPack;
  mystr : string;
begin
  Result := '';
  mydp := TDataPack.Create(ncDateTime);
  try
    mystr := mydp.toJsonStr();
    if fIdTCPClient.Connected then
    begin
      fIdTCPClient.Socket.Write(mystr);
      //mystr := Utf8Decode(IdTCPClient1.Socket.ReadLn);

      //Memo1.Lines.Add(mystr);
    end;
  finally
    mydp.Free;
  end;

end;

end.
