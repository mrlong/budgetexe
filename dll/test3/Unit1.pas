unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, Vcl.StdCtrls, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL;



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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  function CheckOnLine:Boolean;stdcall;external 'net.dll';

implementation
uses
datapack;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  mystr : string;
begin
  //
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
    //mydp.Free;
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

end.
