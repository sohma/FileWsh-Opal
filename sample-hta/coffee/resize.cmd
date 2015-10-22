@set @junk=1 /* vim:set ft=javascript:
@cscript //nologo //e:jscript "%~f0" %*
@exit /b %errorlevel%
*/

var changeWindow, changeWindowTopLeft, moveWindow;

changeWindow = function(x, y) {
  return resizeTo(x, y);
};

moveWindow = function(x, y) {
  return moveTo(x, y);
};

changeWindowTopLeft = function(x, y) {
  resizeTo(x, y);
  return moveTo(0, 0);
};
