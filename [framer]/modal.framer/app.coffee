flow = new FlowComponent
flow.showNext(screen1)

box.onTap ->
	flow.showNext(screen2)
	
back.onTap ->
	flow.showPrevious(screen1)

go.onTap ->
	flow.showNext(screen3)
back_1.onTap ->
	flow.showPrevious(screen2)

modalbox.onTap ->
	flow.showOverlayTop(modal)
# modal.onTap ->
# 	flow.showPrevious()

close_1.onTap ->
	flow.showPrevious()