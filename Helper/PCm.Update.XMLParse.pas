unit PCm.Update.XMLParse;

interface

uses
  Classes;//, PrjConst;

type
  TZMIUpdateVersion = class
    Major, Minor: Integer;
    Date: string;
    Description: string;
    Statements: TStringList;

    constructor Create;
    destructor Destroy; override;
  end;

  TZMIUpdateDatabase = class
    Name: string;
    Versions: TList;

    constructor Create;
    destructor Destroy; override;
  end;

function ReadDatabase(Alias: string): TZMIUpdateDatabase;

implementation

uses
  PCM.Update.libxml2, SysUtils;

constructor TZMIUpdateVersion.Create;
begin
  Statements := TStringList.Create;
end;

destructor TZMIUpdateVersion.Destroy;
begin
  Statements.Free;

  inherited;
end;

constructor TZMIUpdateDatabase.Create;
begin
  Versions := TList.Create;
end;

destructor TZMIUpdateDatabase.Destroy;
var
  i: Integer;
begin
  for i := 0 to Versions.Count - 1 do
    TZMIUpdateVersion(Versions[i]).Free;
  Versions.Free;

  inherited;
end;

function ReadDatabase(Alias: string): TZMIUpdateDatabase;
var
  doc: xmlDocPtr;
  cur, cur2: xmlNodePtr;
  s: String;
  ver: TZMIUpdateVersion;
begin
  Result := nil;

  // Dokument öffnen
  doc := xmlParseFile('pcmupdate.xml');

  if not Assigned(doc) then
  begin
    //ZMIDebugMsg(SXMLDokumentKonnteNichtGeparstWerden, DEB_ERROR);
  end
  else
  begin
    // Root-Element muss zmiupdate sein
    cur := xmlDocGetRootElement(doc);
    if Assigned(cur) then
    begin
      if lowercase(cur.name) = lowercase('pcmanagerupdate') then
      begin
        // datatabase-Element lesen
        cur := cur.children;

        while Assigned(cur) do
        begin
          if (lowercase(cur.name) = lowercase('database')) then
          begin
            // Wir haben den Alias gefunden!
            s := String(xmlGetProp(cur, 'name'));

            if Assigned(PChar(s)) and (s = Alias) then
            begin
              Result := TZMIUpdateDatabase.Create;
              Result.Name := String(s);

              // Versionen parsen
              cur := cur.children;

              while Assigned(cur) do
              begin
                if cur.name = 'version' then
                begin
                  ver := TZMIUpdateVersion.Create;
                  ver.Major := StrToIntDef(String(xmlGetProp(cur, 'major')), 0);
                  ver.Minor := StrToIntDef(String(xmlGetProp(cur, 'minor')), 0);
                  ver.Date := String(xmlGetProp(cur, 'date'));

                  // description und statements
                  cur2 := cur.children;

                  while Assigned(cur2) do
                  begin
                    if cur2.name = 'description' then
                      ver.Description := Utf8ToAnsi(xmlNodeListGetString(doc,
                        cur2.children, 1));
                    if cur2.name = 'statement' then
                      ver.Statements.Add(StringReplace(
                        AdjustLineBreaks(Utf8ToAnsi(xmlNodeListGetString(doc,
                          cur2.children, 1))), #13#10, ' ', [rfReplaceAll]));

                    cur2 := cur2.next;
                  end;

                  Result.Versions.Add(ver);
                end;
                cur := cur.next;
              end;

              Break;
            end;
          end;

          cur := cur.next;
        end;
      end
      else
        //ZMIDebugMsg(SXMLDokumentMussZmiupdateAlsRootElementHaben,DEB_ERROR);
    end
    else
      //ZMIDebugMsg(SXMLDokumentHatKeinRootElement, DEB_ERROR);

    xmlFreeDoc(doc);
  end;
end;

initialization
  xmlInitParser;
finalization
  xmlCleanupParser;
end.

