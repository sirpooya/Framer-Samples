box.pinchable.enabled=true
box.draggable.enabled=true

box.onPinchEnd ->
	box.animate
		rotation: 0
		scale: 1
		options: 
			curve: Spring(damping: .7)