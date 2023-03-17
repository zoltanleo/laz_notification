unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Generics.Collections;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnCreateChildForm: TButton;
    procedure btnCreateChildFormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FCnt: PtrInt;
    FfrmChildList: TStringList;
    procedure SetfrmChildList(AValue: TStringList);
    //procedure OnNotifyEvent(Sender: TObject; AName: String);
  public
    property Cnt: PtrInt read FCnt;
    property frmChildList: TStringList read FfrmChildList write SetfrmChildList;
    procedure OnNotifyEvent(Sender: TObject; AName: String);
  end;

var
  frmMain: TfrmMain;

implementation

uses Unit2;

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.btnCreateChildFormClick(Sender: TObject);
var
   tmpFrm: TfrmChild = nil;
begin
  Inc(FCnt);
  tmpFrm:= TfrmChild.Create(Application);
  frmChildList.Add(tmpFrm.Name);
  //tmpFrm.OnNotifyEvent := @OnNotifyEvent;
  tmpFrm.Show;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if Assigned(frmChildList)
  then frmChildList.Free;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FCnt:= 0;
  FfrmChildList:= TStringList.Create;
end;

procedure TfrmMain.SetfrmChildList(AValue: TStringList);
begin
  if FfrmChildList=AValue then Exit;

  if Assigned(AValue) then FfrmChildList.Assign(AValue);
end;

procedure TfrmMain.OnNotifyEvent(Sender: TObject; AName: String);
begin
  if TObject(Sender).InheritsFrom(TfrmChild) then
  //ShowMessage(Format('%s has been removed', [AName]));
  Self.Caption:= 'child form count: ' + IntToStr(frmChildList.Count);
end;

end.

