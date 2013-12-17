unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient,
  datapack;

type
  TForm1 = class(TForm)
    btn1: TBitBtn;
    idtcpclnt1: TIdTCPClient;
    edt1: TEdit;
    edt2: TEdit;
    btn2: TButton;
    mmo1: TMemo;
    btn3: TBitBtn;
    procedure btn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  mystr : string;
begin
  //
  if idtcpclnt1.Connected then
    idtcpclnt1.Disconnect;
  idtcpclnt1.Host := edt1.Text;
  idtcpclnt1.Port := StrToInt(edt2.Text);
  idtcpclnt1.Connect(2000);

  if idtcpclnt1.Connected then
  begin
    ShowMessage('连接成功');
    mystr := idtcpclnt1.ReadLn;
    mmo1.Lines.Add(mystr);

  end
  else begin
    ShowMessage('连接失败');
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if idtcpclnt1.Connected then
    idtcpclnt1.Disconnect;
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  i : Integer;
  mystr : string;
  data : array of Integer;
begin
  if idtcpclnt1.Connected then
  begin
    SetLength(data,10);
    for i:=0 to 9 do
      data[i] := i;
    idtcpclnt1.Write(UTF8Encode('{"data":"sssssssss在要地地"}'));
    mystr := Utf8Decode(idtcpclnt1.ReadLn);
    mmo1.Lines.Add(mystr);
  end;
end;

procedure TForm1.btn3Click(Sender: TObject);
var
  mydp : TDataPack;
  mystr : string;
begin
  mydp := TDataPack.Create(ncDateTime);
  try
    mystr := mydp.toJsonStr();
    if idtcpclnt1.Connected then
    begin
      idtcpclnt1.Write(mystr);
      mystr := Utf8Decode(idtcpclnt1.ReadLn);
      mmo1.Lines.Add(mystr);
    end;
  finally
    mydp.Free;
  end;

end;

end.
