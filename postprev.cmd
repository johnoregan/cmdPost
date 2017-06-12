@if (@X==@Y) @then
:: Batch
:: NB: html file made by prior run of this program will be silently overwritten
@echo off & setlocal enableextensions disabledelayedexpansion
(call;) %= resets errorlevel to 0 =%

:: error messages provided by jscript pop-ups
cscript //nologo //e:jscript "%~dpf0" "%~dpf1"
:: skip rest of batch if error detected...
if errorlevel 1 goto end

:: ...otherwise make html file and display in browser
set "fName=%~dpf1" %= input file written in markdown =%
set "oFile=%~dpn1.html" %= html output file =%

:: set pandoc options
set "opts=--ascii --atx-headers --columns=80 -S -s --wrap=preserve"
set "extsOff=-auto_identifiers-example_lists-tex_math_dollars-citations"
set "extsOn=+emoji+mmd_title_block"
:: pandoc cmd to generate html from markdown
pandoc %opts% -f markdown%extsOff%%extsOn% -t html "%fName%" -o "%oFile%"

:: convert path to file:/// url
set "oFile=%oFile::=|%" & set "oFile=%oFile:\=/%"
:: view html file in default browser
start "" "file:///%oFile%#header"

:end
endlocal & goto :EOF

@end // JScript

var args, mkdPath, mkdFile, htmlPath, htmlFile, scrFSO, btn, wsSh;

args = WScript.Arguments;
mkdPath = args(0).replace(/\\/g, '\\\\');
mkdFile = mkdPath.replace(/^.+\\\\(.+)$/, '$1');
htmlPath = mkdPath.replace(/^(.+\.).+$/, '$1html');
htmlFile = htmlPath.replace(/^.+\\\\(.+)$/, '$1');
scrFSO = WScript.CreateObject('Scripting.FileSystemObject');
wsSh = WScript.CreateObject('WScript.Shell');

if (scrFSO.GetFile(mkdPath).size == 0) {
    btn = wsSh.Popup('"' + mkdFile + '" is empty!', 5, 'Warning:', 4144);
    WScript.Quit(1);
} else if (!/^.+\.(?:md|mkd)$/i.test(mkdFile)) {
    btn = wsSh.Popup('Filename must have ".md" or ".mkd" extension.', 5,
        'Warning:', 4144);
    WScript.Quit(1);
} else if (scrFSO.FileExists(htmlPath)) {
    try {
        scrFSO.DeleteFile(htmlPath, true);
    } catch(e) {
        wsSh.Popup('Couldn\'t delete old copy of "' + htmlFile + '"!', 5,
            'Error:', 4112);
        WScript.Quit(1);
    } // try-catch
} // if

WScript.Quit(0); // no errors
