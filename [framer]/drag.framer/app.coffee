box.draggable.enabled=true
box.draggable.overdrag=false
box.draggable.bounce=false
box.draggable.vertical=false

box.draggable.constraints=
	x:32
	width: 300
	
box.onDragStart ->
	box.animate
		scale: 1.2
		options: 
			curve: Spring(damping: .3)

box.onDragEnd ->
	box.animate
		scale: 1
		options: 
			curve: Spring(damping: .3)

