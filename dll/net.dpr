library net;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  NetInterfaceUnit in 'NetInterfaceUnit.pas',
  UtilUnit in 'UtilUnit.pas',
  ClientKeyUnit in 'ClientKeyUnit.pas',
  datapack in 'datapack.pas',
  cm_datetime in 'command\cm_datetime.pas';

{$R *.res}

exports
  CheckOnLine,
  CreateNet
;

begin


end.
