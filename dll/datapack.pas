///* Э����ṹ
// *
// * {
// *  ver: 1,          //��ʾ���İ汾��,�ṹ�汾
// *  success: true,   //=true��ʾ�ɹ�
// *  msg: '��Ϣ˵��',
// *  command:'',      //������
// *  zip : false,
// *  encrypt:true,    //=true ��ʾ���Ǽ��ܵİ�
// *  data:{}          //���ݰ�����,���������Ͳ�һ�����������ݲ�һ��
// * }
// *
// * command:
// *   'datetime' = ȡ��������������
// *   'upfile'   = �ϴ��ļ�
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

    function ToJsonStr():string;   //ת��json�ַ���
    function Parse(str:String):Boolean; //���ͳɶ���
    function LoadJsonStr(AStr:string):Boolean;//�����������

    property ver : Integer read fver;
    property success : Boolean read fsuccess write fsuccess;
    property msg : string read fmsg write fmsg;
    property zip :Boolean read fzip write fzip;
    property encrypt : Boolean read fencrypt write fencrypt;
    property data : ISuperObject read fdata write fdata;
  end;

  //����Ļ���
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
  //��������
  Result := true;
end;

function TNetObjectCommand.ToJsonStr: string;
begin
  //��������
  Result := '';
end;







end.


