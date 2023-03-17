unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Unit1;

type

  { TfrmChild }

  TOnMyNotifyEvent = procedure(Sender: TObject; AName: String) of object;

  TfrmChild = class(TForm)
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FOnMyNotifyEvent: TOnMyNotifyEvent;
  public
    property OnMyNotifyEvent: TOnMyNotifyEvent read FOnMyNotifyEvent write FOnMyNotifyEvent;
  end;

var
  frmChild: TfrmChild;

implementation

{$R *.lfm}

{ TfrmChild }

procedure TfrmChild.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  i: PtrInt;
begin
  CloseAction:= caFree;
  if Assigned(frmMain.frmChildList) then
    begin
      i:= frmMain.frmChildList.IndexOf(Self.Name);
      if (i <> -1) then frmMain.frmChildList.Delete(i);
    end;

  if Assigned(FOnMyNotifyEvent) then
    FOnMyNotifyEvent(Self, Self.Name + '(' + Self.ClassName + ')');
end;

procedure TfrmChild.FormDestroy(Sender: TObject);
begin
  //if Assigned(FOnMyNotifyEvent) then
  //  FOnMyNotifyEvent(Self, Self.Name + '(' + Self.ClassName + ')');
end;

procedure TfrmChild.FormCreate(Sender: TObject);
const
  offset = 50;
begin
  Self.Name:= 'frmChild_' + IntToStr(frmMain.Cnt);
  Self.Left:= frmMain.Left + frmMain.Cnt * 50 + offset;
  Self.Top:= frmMain.Top + frmMain.Cnt * 50 + + offset;
  Self.OnMyNotifyEvent:= @frmMain.OnNotifyEvent;
end;


end.

