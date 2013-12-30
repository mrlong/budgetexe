///* 协议包结构
// *
// * {
// *  ver: 1,          //表示包的版本号,结构版本
// *  success: true,   //=true表示成功
// *  msg: '信息说明',
// *  command:'',      //命令名
// *  zip : false,
// *  encrypt:true,    //=true 表示包是加密的包
// *  data:{}          //数据包内容,可能有类型不一样，包的内容不一样
// * }
// *
// * command:
// *   'datetime' = 取出服务器的日期
// *   'upfile'   = 上传文件
// *
// */

unit datapack;

interface
uses
  superobject ;

type
  TNetObjectCommand = class;
  TDataPack = class;

  TNetObjectCommandClass = class of TNetObjectCommand;

  TNetCommand = (
    ncNone,
    ncDateTime,
    ncUpfile
  );

  TDataPack = class
    fver : Integer;
    fsuccess : Boolean;
    fmsg : string;
    fcommand : TNetObjectCommand;
    fzip : Boolean;
    fencrypt:Boolean;
    fdata : ISuperObject;


  public
    constructor Create();overload;
    constructor Create(ACommand:TNetCommand);overload;
    destructor Destroy; override;

    function ToJsonStr():string;   //转成json字符串
    function Parse(str:String):Boolean; //解释成对象
    function LoadJsonStr(AStr:string):Boolean;//解出对象内容

    property ver : Integer read fver;
    property success : Boolean read fsuccess write fsuccess;
    property msg : string read fmsg write fmsg;
    property zip :Boolean read fzip write fzip;
    property encrypt : Boolean read fencrypt write fencrypt;
    property data : ISuperObject read fdata write fdata;
  end;

  //命令的基类
  TNetObjectCommand = class(TObject)
    fOwner : TDataPack;
    fCommandName : string;
    fCommand : TNetCommand;
  public
    constructor Create();
    function ToJsonStr():string; virtual;
    function LoadJsonStr(AStr:string):Boolean;virtual;
  end;



const
  gc_VERSION = 1;

implementation
uses
  SysUtils,
  cm_datetime,
  cm_upfile;

{ TDataPack }

constructor TDataPack.Create;
begin
  fver := gc_VERSION;
  fsuccess := True;
  fmsg := '';
  fzip     := False;
  fencrypt := False;
  fdata := SO;
end;

constructor TDataPack.Create(ACommand: TNetCommand);
begin
  Create();
  case ACommand of
    ncNone     : fcommand := TNetObjectCommand.Create;
    ncDateTime : fcommand := TDateTimeCommand.Create;
    ncUpfile   : fcommand := TUpFileCommand.Create;
  end;
  fcommand.fOwner := Self;

end;

destructor TDataPack.Destroy;
begin
  fdata := nil;
  inherited;
end;

function TDataPack.LoadJsonStr(AStr: string): Boolean;
begin
  Result := False;
  if Assigned(fCommand) then
  begin
    Result := fCommand.LoadJsonStr(AStr);
  end;
end;

function TDataPack.Parse(str: String): Boolean;
begin
  //
  Result := True;
end;

function TDataPack.toJsonStr: string;
begin
  Result := '';
  if Assigned(fcommand) then
  begin
    Result := fCommand.ToJsonStr;
  end;
end;

{ TNetObjectCommand }

constructor TNetObjectCommand.Create;
begin
  fCommandName := '';
end;

function TNetObjectCommand.LoadJsonStr(AStr: string): Boolean;
begin
  //子类重载
  Result := true;
end;

function TNetObjectCommand.ToJsonStr: string;
begin
  //子类重载
  Result := '';
end;







end.


