changeWindow = (x,y) ->
	resizeTo(x,y)

moveWindow = (x,y) ->
	moveTo(x,y)

changeWindowTopLeft = (x, y) ->
	resizeTo(x,y)
	moveTo(0,0)