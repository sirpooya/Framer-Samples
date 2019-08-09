flow = new FlowComponent
flow.showNext(shit)


scroll = new ScrollComponent
	size: Screen.size
	scrollHorizontal: false
list.parent=scroll.content

# scroll.contentInset=
# 	bottom: 10

scroll.onScroll ->
	if scroll.scrollY > 20
		butk.animate
			y:50
			options: 
				time:.2
	if scroll.scaleY < 20
		butk.animate
			y:50
			options: 
				time:.2

butk.onTap ->
	list.parent=shit2.content
	flow.showNext(shit2)