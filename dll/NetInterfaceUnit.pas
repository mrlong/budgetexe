///////////////////////////////////////////////////////////
//
//  �������ӿ�ӿڶ��� �����汾: Delphi XE5
//  ���ߣ�������     2013-12-20
//
//  �޸�
// ���     ����      ʱ��       �޸�����
//  1     ������   2013-12-20   �����ļ�
//
//
///////////////////////////////////////////////////////////

unit NetInterfaceUnit;

interface

type

  INet = interface
    ['{2B71FED7-0CDF-4D6A-A3EE-D6CF3F37B29B}']

    //���ӷ�����
    function Connect(Atimeout:integer):boolean;stdcall;
    procedure Disconnect();stdcall;
    function Connected():Boolean;stdcall;

    //��ȡ������ʱ��
    function GetServerDataTime():widestring; stdcall;


  end;


implementation

end.
