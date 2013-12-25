unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, Vcl.StdCtrls, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL,NetInterfaceUnit,DBXJSON;



type
  TForm1 = class(TForm)
    IdTCPClient1: TIdTCPClient;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Memo1: TMemo;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    fNet : INet;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  function CheckOnLine:Boolean;stdcall;external 'net.dll';
  function CreateNet(AHandle:HWND;AConfig:widestring): INet; stdcall;external 'net.dll';

implementation
uses
superobject,
datapack;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  mystr : string;
begin
  //
  {
  if IdTCPClient1.Connected then
    IdTCPClient1.Disconnect;
  IdTCPClient1.Host := Edit1.Text;
  IdTCPClient1.Port := StrToInt(Edit2.Text);
  IdTCPClient1.Connect(Edit1.Text,IdTCPClient1.Port);

  if IdTCPClient1.Connected then
  begin
    ShowMessage('连接成功');
    mystr := IdTCPClient1.Socket.ReadLn;
    Memo1.Lines.Add(mystr);

  end
  else begin
    ShowMessage('连接失败');
  end;
   }


  if fNet.connect(1000) then
  begin
    ShowMessage('连接成功');
  end
  else
    ShowMessage('连接失败');


end;

procedure TForm1.Button2Click(Sender: TObject);
var
  mydp : TDataPack;
  mystr : string;
begin
  mydp := TDataPack.Create(ncDateTime);
  try
    mystr := mydp.toJsonStr();
    if IdTCPClient1.Connected then
    begin
      IdTCPClient1.Socket.Write(mystr);
      mystr := Utf8Decode(IdTCPClient1.Socket.ReadLn);
      Memo1.Lines.Add(mystr);
    end;
  finally
    mydp.Free;
  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  //
  if CheckOnLine then
    showmessage('能上网')
  else
    showmessage('不能上网');
end;

procedure TForm1.Button4Click(Sender: TObject);
const JSON_DATA = '{"ArrayData":['+
                    '{"DAT_INCL":"07/03/2012 17:33:03", "NUM_ORDE":1,"NUM_ATND":1, "NUM_ACAO":2, "NUM_RESU":3},'+
                    '{"DAT_INCL":"07/03/2012 17:33:05", "NUM_ORDE":2,"NUM_ATND":1, "NUM_ACAO":4, "NUM_RESU":5},'+
                    '{"DAT_INCL":"07/03/2012 17:33:05", "NUM_ORDE":3,"NUM_ATND":1, "NUM_ACAO":8, "NUM_RESU":null}'+
                   ']}';


var jsv   : TJsonValue;
    originalObject : TJsonObject;

    jsPair : TJsonPair;
    jsArr : TJsonArray;
    jso,LJsonObj : TJsonObject;
    i : integer;
begin

 try
        //parse json string
        jsv := TJSONObject.ParseJSONValue(JSON_DATA);
        try
            //value as object
            originalObject := jsv as TJsonObject;

            //get pair, wich contains Array of objects
            jspair := originalObject.Get('ArrayData');
            //pair value as array
            jsArr := jsPair.jsonValue as  TJsonArray;

            Memo1.Lines.Add('array size: ' + inttostr(jsArr.Size));
            //enumerate objects in array
            for i := 0 to jsArr.Size - 1 do begin
                Memo1.Lines.Add('element ' + inttostr(i));
                // i-th object
                jso := jsArr.Get(i) as TJsonObject;

                //enumerate object fields
                for jsPair in jso do begin
                    Memo1.Lines.Add('   ' + jsPair.JsonString.Value + ': ' + jsPair.JsonValue.Value);
                end;
            end;
        finally
            jsv.Free();
            //readln;
        end;
    except
        on E: Exception do
          Memo1.Lines.Add(E.ClassName + ': ' + E.Message);
    end;


    //LJsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes('{"name":"ssss"}'), 0) as TJSONObject;
    LJsonObj := TJSONObject.Create;
    LJsonObj.ParseJSONValue('{"name":"ssss"}');// as TJSONObject;
    Memo1.Lines.Add(inttostr(LJsonObj.Size));
    Memo1.Lines.Add(LJsonObj.Value);
    Memo1.Lines.Add(LJsonObj.ToString);
    //Memo1.Lines.Add(LJsonObj.GetValue('name').ToString);

end;


procedure SaveJson;
var
  json, json_sub: ISuperObject;
begin
  json := SO;

  json.S['name'] := 'Henri Gourvest';
  json.B['vip'] := TRUE;
  json.O['telephones'] := SA([]);
  json.A['telephones'].S[0] := '000000000';
  json.A['telephones'].S[1] := '111111111111';
  json.I['age'] := 33;
  json.D['size'] := 1.83;

  json.O['addresses'] := SA([]);

  json_sub := SO;
  json_sub.S['address'] := 'blabla';
  json_sub.S['city'] := 'Metz';
  json_sub.I['pc'] := 57000;
  json.A['addresses'].Add(json_sub);

  json_sub.S['address'] := 'blabla';
  json_sub.S['city'] := 'Nantes';
  json_sub.I['pc'] := 44000;
  json.A['addresses'].Add(json_sub);

  json.SaveTo('C:\json_out.txt');

  json := nil;
  json_sub := nil;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  SaveJson();
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  myJson : ISuperObject;
begin
  myJson := SO;
  myJson.S['key'] := 'D:\git\budgetexe\keys\client.key';
  myJson.S['cert']:= 'D:\git\budgetexe\keys\client.crt';
  myJson.B['ssl'] := true;
  myJson.S['host'] := Edit1.Text;
  myJson.I['port'] := 1377;
  fNet := CreateNet(Self.Handle,myJson.AsString);
  myJson := nil;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  fNet.Disconnect;
  fNet := nil;
end;

end.
