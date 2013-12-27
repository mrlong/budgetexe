//
//
// 取出系统的时间 cm_datetime
//
//

unit cm_datetime;

interface
uses
  superobject,
  datapack;

type

  //取出时间
  TDateTimeCommand = class(TNetObjectCommand)
    constructor Create();
    function ToJsonStr():string; override;
    function LoadJsonStr(AStr:string):Boolean;override;
  end;


implementation

{ TDateTimeCommand }

constructor TDateTimeCommand.Create;
begin
  inherited Create();
  fCommandName := 'datetime';
end;

function TDateTimeCommand.LoadJsonStr(AStr: string): Boolean;
var
  myJson : ISuperObject;
begin
  //
  Result := False;
  myJson := SO(AStr);
  if myJson.B['success'] then
  begin
    fOwner.fver := myJson.I['ver'];
    fOwner.fsuccess := myJson.B['success'];
    fOwner.fzip := myJson.B['zip'];
    fOwner.fencrypt := myJson.B['encrypt'];
    if fOwner.fdata <> nil then
    begin
      fOwner.fdata.Clear(true);
      fOwner.fdata := nil;
    end;
    fOwner.fdata := myJson.O['data'].Clone;
    Result := True;
  end;
end;

function TDateTimeCommand.ToJsonStr: string;
var
  myJson : ISuperObject;
  i : Integer;
  myfilename : string;
begin
  myJson := SO;
  try
    myJson.I['ver'] := fOwner.fver;
    myJson.B['success'] := fOwner.fsuccess;
    myJson.S['msg'] := fOwner.fmsg;
    myJson.S['command'] := fCommandName;
    myJson.B['zip'] := fOwner.fzip;
    myJson.B['encrypt'] := fOwner.fencrypt;
    myJson.O['data'] := fOwner.fdata.Clone;

    //转成UTF8
    Result := UTF8Encode(myJson.AsString);

  finally
    myJson := nil;
  end;
end;


end.
