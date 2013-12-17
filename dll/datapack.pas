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
// *
// */

unit datapack;

interface
uses
  uLkJSON;

type

  TNetCommand = (
    ncNone,
    ncDateTime
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

    function toJsonStr():string;        //ת��json�ַ���
    function Parse(str:String):Boolean; //���ͳɶ���

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
  gc_COMMANDSTR : array[ncNone..ncDateTime] of string = (
    '',
    'datetime'
  );

implementation

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
  i : Integer;
begin
  myJson := TlkJSONobject.Create;
  try
    myJson.Add('ver',fver);
    myJson.Add('success',fsuccess);
    myJson.Add('msg',fmsg);
    myJson.Add('command',gc_COMMANDSTR[fcommand]);
    myJson.Add('zip',fzip);
    myJson.Add('encrypt',fencrypt);
    myJson.Add('data',fdata);
    //ת��UTF8
    i := 0;
    Result := UTF8Encode(GenerateReadableText(myJson,i));
  finally
    myJson.Free;
  end;
end;

end.


