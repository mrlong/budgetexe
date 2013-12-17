unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient;

type
  TForm1 = class(TForm)
    btn1: TBitBtn;
    idtcpclnt1: TIdTCPClient;
    edt1: TEdit;
    edt2: TEdit;
    btn2: TButton;
    mmo1: TMemo;
    procedure btn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn2Click(Sender: TObject);
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
  mystr : string;
begin
  if idtcpclnt1.Connected then
  begin
    idtcpclnt1.SendCmd('world');
    mystr := idtcpclnt1.ReadString(3);
    mmo1.Lines.Add(mystr);
  end;
end;

end.
