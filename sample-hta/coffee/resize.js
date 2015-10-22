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
