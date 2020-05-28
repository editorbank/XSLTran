rem /* (c)2013 Ed *%/ XSLt Transformator version 1.1
@echo off
set rem=%*
if not defined rem goto :help
cscript //E:JScript //nologo "%~dpnx0" %*
::echo rem /* return code %errorlevel% *%/
goto :eof
:help
echo Use:
echo   %~n0 /xsl:^<template.xsl^> /xml:^<input.xml^> /out:^<output.xml^> [/encoding:^<"utf-8"^|"windows-1251"^|"utf-16"^|...^>] [/msxml_version:^<".6.0"^|...^>]
goto :eof
/*/=(function(){
var xsl="";Arg("xsl");
var xml="";Arg("xml");
var out="";Arg("out");
var encoding="";Arg("encoding");
var msxml_version=".6.0";Arg("msxml_version");
function Arg(name){eval("if(WScript.Arguments.Named.Exists(\""+name+"\"))"+name+"=WScript.Arguments.Named.Item(\""+name+"\");");}
var xsltDoc=null;
try{
  xsltDoc=new ActiveXObject("Msxml2.FreeThreadedDOMDocument"+msxml_version);
}catch(e){
  msxml_version="";
  try{
    xsltDoc=new ActiveXObject("Msxml2.FreeThreadedDOMDocument"+msxml_version);
  }catch(e){WScript.StdErr.Write("Error "+e.number+" - "+e.description+"\n");WScript.Quit(e.number);};
};
try{
  xsltDoc.async=false;
  xsltDoc.load(xsl);
  var xslTemplate=new ActiveXObject("Msxml2.XSLTemplate"+msxml_version);
  xslTemplate.stylesheet=xsltDoc;
  var xslProc=xslTemplate.createProcessor();
  xslProc.input=new ActiveXObject("Msxml2.FreeThreadedDOMDocument"+msxml_version);
  xslProc.input.async=false;
  xslProc.output=new ActiveXObject("Msxml2.FreeThreadedDOMDocument"+msxml_version);
  xslProc.output.async=false;
  if(""!=msxml_version&&""!=encoding)xslProc.encoding=encoding; 
  xslProc.input.load(xml);
  xslProc.transform();
  xslProc.output.save(out);
}catch(e){WScript.StdErr.Write("Error "+e.number+" - "+e.description+"\n");WScript.Quit(e.number);};
})();
//*//
