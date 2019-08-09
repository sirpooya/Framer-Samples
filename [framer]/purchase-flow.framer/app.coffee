# Background view
background = new Layer
	width: 375
	height: 667
	image: "images/background.png"

categories = new Layer
	width: 297
	height: 23
	image: "images/categories.png"
	y: 594
	x: 39

message_area = new Layer
	width: 286
	height: 23
	image: "images/message_area.png"
	y: 180
	x: 39

profile_picture = new Layer
	width: 62
	height: 62
	image: "images/profile_picture.png"
	y: 56
	x: 31

shopping_cart = new Layer
	width: 62
	height: 53
	image: "images/shopping_cart.png"
	y: 61
	x: 282

# Scrolling cards
scroll = new ScrollComponent
	width: 375
	height: 311
	y: 240
scroll.scrollVertical = false

card1 = new Layer
	width: 213
	height: 311
	image: "images/card1.png"
	x: 30
	parent: scroll.content

card2 = new Layer
	width: 213
	height: 311
	image: "images/card2.png"
	x: 260
	parent: scroll.content

card3 = new Layer
	width: 213
	height: 311
	image: "images/card3.png"
	x: 490
	parent: scroll.content

card4 = new Layer
	width: 213
	height: 311
	image: "images/card4.png"
	x: 720
	parent: scroll.content

detail_card = new Layer
	width: 315
	height: 462
	image: "images/detail_card.png"
	y: 161
	x: 33
	opacity: 0
	scale: 0.5
	visible: false

detail_card.states.a =
	opacity: 1
	scale: 1
	animationOptions:
		curve: Spring(damping: 0.5)
		time: 0.3

card1.states.a =
	opacity: 0

card2.states.a =
	opacity: 0

card3.states.a =
	opacity: 0

card4.states.a =
	opacity: 0

message_area.states.a =
	opacity: 0

sound2 = new Audio("sounds/Expand.m4a")

bringCard = (aLayer) ->
	aLayer.onTap (event, layer) ->
		card1.stateCycle()
		card2.stateCycle()
		card3.stateCycle()
		card4.stateCycle()
		message_area.stateCycle()
		detail_card.visible = true
		detail_card.stateCycle()
		sound2.play()

bringCard(card1)
bringCard(card2)
bringCard(card3)
bringCard(card4)

# Cart updates
cart_number = new Layer
	width: 24
	height: 24
	image: "images/cart_number.png"
	x: 306
	y: 67
	opacity: 0
	scale: 0

cart_number.states.a =
	scale: 1.00
	opacity: 1.00
	animationOptions:
		curve: Spring(damping: 0.5)
		time: 0.3

# cart_number.states.b =
# 	scale: 0

detail_card.onTap ->
	cart_number.stateCycle()
	detail_card.stateCycle()
	card1.stateCycle()
	card2.stateCycle()
	card3.stateCycle()
	card4.stateCycle()
	message_area.stateCycle()


# Cart view
order_card = new Layer
	width: 315
	height: 462
	image: "images/order_card.png"
	x: 30
	y: 165
	opacity: 0
	scale: 0.5

cart_menu = new Layer
	width: 290
	height: 19
	image: "images/cart_menu.png"
	x: 41
	y: 180
	opacity: 0

order_items = new Layer
	width: 246
	height: 246
	image: "images/order_items.png"
	x: 58
	y: 227
	scale: 0
	opacity: 0

payment_menu = new Layer
	width: 291
	height: 24
	image: "images/payment_menu.png"
	x: 40
	y: 558
	opacity: 0

shipping_menu = new Layer
	width: 290
	height: 23
	image: "images/shipping_menu.png"
	x: 41
	y: 508
	opacity: 0

order_card.states.a =
	opacity: 1
	scale: 1
	animationOptions:
		curve: Spring(damping: 0.5)
		time: 0.5

order_items.states.a =
	opacity: 1
	scale: 1
	animationOptions:
		curve: Spring(damping: 0.5)
		time: 0.8

cart_menu.states.a =
	opacity: 1
	animationOptions:
		curve: Spring(damping: 0.5)
		time: 0.6

shipping_menu.states.a =
	opacity: 1
	animationOptions:
		curve: Spring(damping: 0.5)
		time: 0.6

payment_menu.states.a =
	opacity: 1
	animationOptions:
		curve: Spring(damping: 0.5)
		time: 0.6

shopping_cart.onTap ->
	order_card.states.switch "a"
	order_items.states.switch "a"
	cart_menu.states.switch "a"
	shipping_menu.states.switch "a"
	payment_menu.states.switch "a"
	card1.states.switch "a"
	card2.states.switch "a"
	card3.states.switch "a"
	card4.states.switch "a"

# Switch to Shipping
address = new Layer
	width: 124
	height: 104
	image: "images/address.png"
	x: 64
	y: 292
	scale: 0
	opacity: 0

address.states.a =
	scale: 1.00
	opacity: 1.00

same_address = new Layer
	width: 260
	height: 31
	image: "images/same_address.png"
	x: 64
	y: 420
	scale: 0
	opacity: 0

same_address.states.a =
	scale: 1.00
	opacity: 1.00

shipping_menu.states.b =
	y: 225

shipping_menu.onTap ->
	detail_card.states.switch "a"
	order_items.stateCycle()
	shipping_menu.states.switch "b"
	card1.states.switch "a"
	card2.states.switch "a"
	card3.states.switch "a"
	card4.states.switch "a"
	address.states.switch "a"
	same_address.states.switch "a"

# Switch to payment
credit_card_area = new Layer
	width: 232
	height: 147
	image: "images/credit_card_area.png"
	x: 64
	y: 310
	scale: 0
	opacity: 0

order_button = new Layer
	width: 187
	height: 61
	image: "images/order_button.png"
	x: 97
	y: 500
	scale: 0
	opacity: 0

credit_card_area.states.a =
	opacity: 1
	scale: 1
	animationOptions:
		curve: Spring(damping: 0.5)
		time: 0.6

order_button.states.a =
	opacity: 1
	scale: 1
	animationOptions:
		curve: Spring(damping: 0.5)
		time: 0.6

payment_menu.states.b =
	y: 270

payment_menu.onTap ->
	address.stateCycle()
	same_address.stateCycle()
	credit_card_area.states.switch "a"
	order_button.states.switch "a"
	payment_menu.states.switch "b"

# Order success
order_success = new Layer
	width: 315
	height: 462
	image: "images/order_success.png"
	x: 32
	y: 161
	opacity: 0
	scale: 0

order_success.states.a =
	opacity: 1
	scale: 1
	animationOptions:
		curve: Spring(damping: 0.5)
		time: 0.5

sound = new Audio("sounds/Success2.m4a")

order_button.onTap ->
	order_success.states.switch "a"
	detail_card.states.switch "a"
	credit_card_area.stateCycle()
	order_button.stateCycle()
	order_card.stateCycle()
	sound.play()


# User area
user_card = new Layer
	width: 315
	height: 470
	image: "images/user_card.png"
	x: 33
	y: 161
	scale: 0
	opacity: 0

user_card.states.a =
	opacity: 1
	scale: 1
	animationOptions:
		curve: Spring(damping: 0.5)
		time: 0.5

profile_picture.onTap ->
	user_card.states.switch "a"
	card1.states.switch "a"
	card2.states.switch "a"
	card3.states.switch "a"
	card4.states.switch "a"
	message_area.states.switch "a"
