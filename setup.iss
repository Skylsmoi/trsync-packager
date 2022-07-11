; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Trsync"
#define MyAppVersion "0.1"
#define MyAppPublisher "Bastien Sevajol"
#define MyAppURL "https://github.com/buxx/trsync"
#define MyAppExeName "trsync-manager-systray.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F09009FF-131C-464F-B269-DB8FFF3DA90D}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Remove the following line to run in administrative install mode (install for all users.)
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=commandline
OutputBaseFilename=trsync
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: ".\trsync\target\release\trsync_manager_systray.exe"; DestDir: "{app}"; DestName: "trsync-manager-systray.exe"; Flags: ignoreversion
Source: ".\trsync-manager-configure\dist\trsync-manager-config.exe"; DestDir: "{app}"; DestName: "trsync-manager-config.exe"; Flags: ignoreversion
Source: ".\trsync.conf"; DestDir: "{localappdata}"; Flags: ignoreversion; AfterInstall: UpdateConfig()
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\trsync-manager-systray.exe"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\trsync-manager-systray.exe"; Tasks: desktopicon
Name: "{userstartup}\{#MyAppName}"; Filename: "{app}\trsync-manager-systray.exe"; WorkingDir: "{app}"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent;

[Code]
procedure UpdateConfig();
var
  LocalAppDataValue : string;
  FileName : string;
  MyFile : TStrings;
  MyText : string;
  TrsyncManagerConfigurePath : string;
begin  
  LocalAppDataValue := ExpandConstant('{localappdata}');
  FileName := LocalAppDataValue + '\trsync.conf';
  TrsyncManagerConfigurePath := ExpandConstant('{app}') + '\trsync-manager-config.exe';
  MyFile := TStringList.Create;
  try
    MyFile.LoadFromFile(FileName);
    MyText := MyFile.Text;

    { Only save if text has been changed. }  
    StringChangeEx(MyText, '__TRSYNC_MANAGER_CONFIGURE_PATH__', TrsyncManagerConfigurePath, True);
    StringChangeEx(MyText, '\', '\\', True);
    MyFile.Text := MyText;
    MyFile.SaveToFile(FileName);
  finally
    MyFile.Free;
  end;
end;
