unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
 Vcl.StdCtrls ,
  NetInterfaceUnit;



type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Memo1: TMemo;
    Button3: TButton;
    Button5: TButton;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    fNet : INet;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;



implementation
uses
superobject;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  mystr : string;
  myvalue : Variant;
begin
  //

  if fNet.Connected then
    fNet.Disconnect;

  if fNet.connect(1000) then
  begin
    Memo2.Lines.Add('连接成功');
    if fNet.GetValueByName('welcome',myvalue) then
      Memo2.Lines.Add(myvalue);

    if fNet.GetValueByName('authorized',myvalue) and (myvalue=true) then
      Memo2.Lines.Add('authorized=true');

  end
  else
    ShowMessage('连接失败');


end;

procedure TForm1.Button2Click(Sender: TObject);
var
  mystr : string;
begin
  mystr := fNet.GetServerDataTime;
  Memo1.Lines.Add(mystr);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  //
  if CheckOnLine then
    showmessage('能上网')
  else
    showmessage('不能上网');
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
