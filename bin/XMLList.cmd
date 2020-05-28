rem /* (c)2013 Ed *%/ XML List version 1.1
@echo off
set rem=%*
if not defined rem goto :help
cscript //E:JScript //nologo "%~dpnx0" %*
::echo rem /* return code %errorlevel% *%/
goto :eof
:help
echo Use:
echo   %~n0 /xml:^<input.xml^>
goto :eof
/*/=(function(){
var xml="";Arg("xml");
var out="";Arg("out");
var encoding="";Arg("encoding");
var msxml_version=".6.0";Arg("msxml_version");
function Arg(name){eval("if(WScript.Arguments.Named.Exists(\""+name+"\"))"+name+"=WScript.Arguments.Named.Item(\""+name+"\");");}

var dom=null;
try{
  dom=new ActiveXObject("Msxml2.FreeThreadedDOMDocument"+msxml_version);
}catch(e){
  msxml_version="";
  try{
    dom=new ActiveXObject("Msxml2.FreeThreadedDOMDocument"+msxml_version);
  }catch(e){WScript.StdErr.Write("Error "+e.number+" - "+e.description+"\n");WScript.Quit(e.number);};
};
try{
  dom.async=false;
  dom.setProperty("SelectionLanguage", "XPath");
  dom.load(xml);

var Quote="\"";
var NoViewAttr=true;
var XPathMode=false;

function node_to_XPath(node){
  if(null==(node)) return "";
  var str="";
  if(!NoViewAttr)for(var a=0;a<node.attributes.length;a++){
    if(""!=str) str+=(XPathMode?" and ":"");
    str+=(XPathMode?"@":" ")+node.attributes.item(a).name+"="+Quote+node.attributes.item(a).value+Quote;
  }
  if(""!=str) str=(XPathMode?"[":"")+str+(XPathMode?"]":"");
  str=(XPathMode?"/":"<")+node.nodeName+str+(XPathMode?"":">");
  return str;
};
function node_get_text(node){
  for(var i=0;i<node.childNodes.length;i++)
    if(node.childNodes.item(i).nodeType==3) 
      return node.childNodes.item(i).text;
  return null;
}

function node_path(node){
  if(null==node) return "";
  path="";
  var tx=node_get_text(node);
  if(tx!=null) path=(XPathMode?"[.="+Quote:"")+( tx )+(XPathMode?Quote+"]":"</"/*+node.nodeName+">"*/);
  for(;(null!=node)&&(""!=node.baseName);node=node.parentNode,path=""+path){
    path=node_to_XPath(node)+path;
  }
  return path;
};

var isDebug=true;
function debug(text){
  if(isDebug) WScript.StdOut.writeLine(text);
};
function view(text){
  WScript.StdOut.writeLine(text);
};
  var XPath="//*"
  var nodelist = dom.documentElement.selectNodes(XPath);
  debug("Found node(s):" + nodelist.length );
  for(var i=0;i<nodelist.length;i++){
    var node=nodelist.item(i);
    view( node_path(node) );
  }
}catch(e){WScript.StdErr.Write("Error "+e.number+" - "+e.description+"\n");WScript.Quit(e.number);};
})();
//*//
