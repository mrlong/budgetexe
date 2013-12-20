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
  uLkJSON;

type

  TNetCommand = (
    ncNone,
    ncDateTime,
    ncUpfile
  );

  TDataPack = class
    fver : Integer;
    fsuccess : Boolean;
    fmsg : string;
    fcommand : TNetCommand;
    fzip : Boolean;
    fencrypt:Boolean;
    fdata : TlkJSONobject;

  public
    constructor Create();overload;
    constructor Create(ACommand:TNetCommand);overload;
    destructor Destroy; override;

    function toJsonStr():string;        //转成json字符串
    function Parse(str:String):Boolean; //解释成对象

    property ver : Integer read fver;
    property success : Boolean read fsuccess write fsuccess;
    property msg : string read fmsg write fmsg;
    property command : TNetCommand read fcommand write fcommand;
    property zip :Boolean read fzip write fzip;
    property encrypt : Boolean read fencrypt write fencrypt;
    property data : TlkJSONobject read fdata write fdata;
  end;

const
  gc_VERSION = 1;
  gc_COMMANDSTR : array[ncNone..ncUpfile] of string = (
    '',
    'datetime',
    'upfile'
  );

implementation
uses
  SysUtils,Classes;

{ TDataPack }

constructor TDataPack.Create;
begin
  fver := gc_VERSION;
  fsuccess := True;
  fmsg := '';
  fcommand := ncNone;
  fzip     := False;
  fencrypt := False;
  fdata := TlkJSONobject.Create;
end;

constructor TDataPack.Create(ACommand: TNetCommand);
begin
  Create();
  fcommand := ACommand;
end;

destructor TDataPack.Destroy;
begin
  fdata.Free;
  inherited;
end;

function TDataPack.Parse(str: String): Boolean;
begin
  //
  Result := True;
end;

function TDataPack.toJsonStr: string;
var
  myJson : TlkJSONobject;
  mydatajson : TlkJSONobject;
  i : Integer;
  myfilename : string;
  myfs : TFileStream;
begin
  myJson := TlkJSONobject.Create;
  mydatajson := TlkJSONobject.Create;
  try
    myJson.Add('ver',fver);
    myJson.Add('success',fsuccess);
    myJson.Add('msg',fmsg);
    myJson.Add('command',gc_COMMANDSTR[fcommand]);
    myJson.Add('zip',fzip);
    myJson.Add('encrypt',fencrypt);

    //如是上传文件
    if fcommand = ncUpfile then
    begin
      myfilename := fdata.getString('filename');
      if FileExists(myfilename) then
      begin
        //流的大小
        myfs := TFileStream.Create(myfilename,fmOpenRead);
        try
          mydatajson.Add('filename',ExtractFileName(myfilename));
          mydatajson.Add('length',myfs.Size);
          mydatajson.Add('md5','');//文件的md5

          myJson.Add('data',mydatajson);
        finally
          myfs.Free;
        end;
      end;
    end
    else begin
      myJson.Add('data',fdata);
    end;

    //转成UTF8
    i := 0;
    Result := UTF8Encode(GenerateReadableText(myJson,i));

  finally
    myJson.Free;
  end;
end;

end.


