layer.states =
	one:
		scale:1.5
		rotation: 15
		backgroundColor: "rgba(194,255,199,1)"
		borderRadius: 0
	two:
		scale:.75
		rotation: -15
		borderRadius: 8
		backgroundColor: "rgba(255,255,239,1)"
	three:
		scale:1
		rotation: 0
		backgroundColor: "rgba(234,255,89,1)"
		borderRadius: 6

layer.animationOptions =
	curve: Spring(damping: 0.5)		

layer.onTap ->
	layer.stateCycle("one","two","three")

button.states.a=
	y: 400
button.states.b=
	y: 550
button.animate "a"
button.onAnimationEnd ->
	button.stateCycle("a","b")

button.onTap ->
	layer.stateCycle("one","two","three")
		
	
	