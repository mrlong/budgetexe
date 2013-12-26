///////////////////////////////////////////////////////////
//
//  �������ӿ�ӿڶ��� �����汾: Delphi XE5
//  ���ߣ�������     2013-12-20
//
//  ������Ȩ����Ҫ���⿽�����������ת��.
//
//  �޸�
// ���     ����      ʱ��       �޸�����
//  1     ������   2013-12-20   �����ļ�
//
//
///////////////////////////////////////////////////////////

unit NetInterfaceUnit;

interface
uses
  Windows;
type

  INet = interface
    ['{2B71FED7-0CDF-4D6A-A3EE-D6CF3F37B29B}']

    //���ӷ�����������ǰȷ���Ƿ����������ˡ�
    function Connect(Atimeout:integer):boolean;stdcall;
    procedure Disconnect();stdcall;
    function Connected():Boolean;stdcall;

    //��ȡ������ʱ��
    function GetServerDataTime():widestring; stdcall;
    //������ȡ������ֵ��
    // welcome =��ӭ��
    // authorized =true ��ʾ��������֤�ɹ�
    function GetValueByName(AName:widestring;var AValue:Variant):Boolean;stdcall;

  end;



  //Net.dll�ӿ�
  //
  // ����: AConfig
  // {
  //   ssl: true  ��ʾ����ssl���ӣ���ʱkey ,cert����д
  //   key: "����·��"
  //   cert: "����·��"
  //   host: "" ������ip
  //   port: 1377
  // }
  //
  function CreateNet(AHandle:HWND;AConfig:widestring): INet; stdcall; external 'net.dll';

  //�϶��Ƿ�����
  function CheckOnLine: Boolean; stdcall; external 'net.dll';

implementation

end.
