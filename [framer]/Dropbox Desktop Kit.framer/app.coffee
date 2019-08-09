############### CONFIGURE ###############

# Set the Operating System 
# OPTIONS: macOS / windows10 / noOS
OS = macOS

# Enable wallpaper
# OPTIONS: true / false
wallpaper = true

# Enable animated click indicator 
# OPTIONS: true / false
animateClick = false

# Enable examples
# OPTIONS: 1 / 2 / 3 / false
showExample = false


############### FUNCTIONS ###############

# Desktops
# 🖥 Background
# Creates a resizable base layer to house the actual desktop environment

# 🌈 Cursor and device type
document.body.style.cursor = "auto"
Framer.Device.deviceType = "fullscreen"


# 🌈 Create the container for base
baseContainer = new Layer
	x: 0
	y: 0
	width: window.innerWidth
	height: window.innerHeight
	clip: true
	backgroundColor: "#000"


# 🌈 Create the base layer
base = new Layer
	parent: baseContainer
	x: 0
	y: 0
	width: 1440
	height: 900
	clip: true


# ⭐️ Function: Resize baseContainer and maintain ratio of base to keep prototype visible as window is resized
resizeBackground = () ->
	baseContainer.width = window.innerWidth
	baseContainer.height = window.innerHeight
	scaleWidth = Math.min(1, window.innerWidth / base.width)
	scaleHeight = Math.min(1, window.innerHeight / base.height)
	base.scale = Math.min(scaleWidth, scaleHeight)
	base.center()


# 💫 Run once at start and any time the window is resized
resizeBackground()
window.addEventListener("resize", resizeBackground, false);


# 🌈 If in noOS, the baseContainer should be the same color as the background
if OS == noOS
	baseContainer.backgroundColor = noOS.backgroundColor


# 🖥 Operating Sytems
# Defines the operating system and sets the wallpaper

# 🌈 Place the proper OS inside base
OS.props =
	parent: base
	x: 0
	y: 0

# 🌈 Create a target for applications to be added
if OS == macOS
	# Sets application container
	applicationContainer = macOSDesktop
	
	if wallpaper == true
		macOSWallpaper.props =
			parent: macOSBackground
			x: 0
			y: 0
		
else if OS == windows10
	applicationContainer = windows10Desktop
	
	if wallpaper == true
		windows10Wallpaper.props =
			parent: windows10Background
			x: 0
			y: 0

else if OS == noOS
	applicationContainer = noOS
# 🖥 Animate Clicks
# If enabled, fires an animation on click 

window.tmpCursor = null

createTap = (e) ->
	x = e.clientX
	y = e.clientY
	radius = 2
	
	tap = new Layer  
		x: x - radius - 96
		y: y - radius - 96
		scale: 0.2
		borderRadius: 640
		originX: 0.5
		originY: 0.5
		backgroundColor: "rgba(31, 170, 237, 0.7)"
	
	return tap

showTapTarget = (e) ->
	x = e.offsetX
	y = e.offsetY
	tap = createTap e
	window.tmpCursor = tap

showTap = (e, parent) ->
	e.stopPropagation()
	
	if window.tmpCursor?
		window.tmpCursor.destroy()
	
	tap = createTap e

	tap.animate
		properties: 
			scale: 0.5 
			opacity: 0
		curve: "spring(150,25, -3)"
		
	Utils.delay 1, ->
		tap.destroy()

if animateClick == true
	base.on Events.MouseUp, (e) -> 
		showTapTarget(e)    
	
	base.onClick (e) -> showTap(e)
# 🖥 Alerts
# When fired, slides out an alert

# 🌈 Create an invisible container for alerts
alertContainer = new Layer
	parent: OS
	width: 0
	height: 0

if OS == macOS
	alertContainer.x = Align.right(20)
	alertContainer.y = Align.top(40)

if OS == windows10
	alertContainer.x = Align.right(20)
	alertContainer.y = Align.bottom(-150)

# ⭐️ Function: Fire alert 
alertFire = (alert) ->
	alertContainer.opacity = 1
	
	# Put the selected alert inside the container
	alert.props =
		parent: alertContainer
		x: 20
		y: 0
	
	alert.animate
		x: -(alert.width + 40)
		options:
			time: 0.5
	
	# Hide the alert when clicked
	alert.onClick ->
		alertHide()

# ⭐️ Function: Hide alert
alertHide = () ->
	alertContainer.animate
		opacity: 0
		options:
			time: 0.2

# Applications
# 🚥 Application arrays
# These arrays help the application functions know which Design tab layers to target
# NOTE: The order of each item must be consistent across arrays

###################################

# 🖼 Window applications
# If you add a new Windows app, be sure to append a target to each of these arrays.

# The top app layer
windowsApplications = [fileExplorer, skype, outlook, edge] 

# The draggable area
windowsToolbars = [fileExplorerToolbar, skypeToolbar, outlookToolbar, edgeTabs]

# The toolbar icon to open/close the app
windowsToolbarIcons = [toolbarFileExplorer, toolbarSkype, toolbarOutlook, toolbarEdge]

# The close 'x' icon
windowsCloseIcons = [fileExplorerClose, skypeClose, outlookClose, edgeClose]


###################################


# 💻 Mac application arrays
# If you add a new Mac app, be sure to append a target to each of these arrays.

# The top app layer
macApplications = [finder, messages, mail, safari]

# The draggable area
macToolbars = [finderToolbar, messagesToolbar, mailToolbar, safariToolbar]

# The name for updating the menu bar
macApplicationNames = ["Finder", "Messages", "Mail", "Safari"]

# The dock icon
macDockIcons = [macDockFinder, macDockMessages, macDockMail, macDockSafari]

# The dock dot to show when it's open
macDockActiveDots = [macDockFinder_activeDot, macDockMessages_activeDot, macDockMail_activeDot, macDockSafari_activeDot]

# The red close traffic light
macCloseIcons = [finderToolbar_trafficLights_red, messagesClose, mailToolbar_trafficLights_red, safariToolbar_trafficLights_red]
# 🚥 Initialize applications
# Prepares the applications for opening and closing. If adding a new Windows or macOS appliction, you'll need to edit the arrays in the first 20 lines of this section.

# ⭐️ Function: Bring a window to the front
applicationBringToFront = (targetApplication, applicationNameString="Safari") ->	
	if OS == macOS
		targetApplication.placeBehind(macOSPlaceBehind)
		
		# Update the menubar text
		menuBar_appName.text = applicationNameString 
		menuBar_appMenu.x = menuBar_appName.width + 70
		
	else if OS == windows10
		targetApplication.placeBehind(windows10PlaceBehind)
	
	else if OS == noOS
		targetApplication.parent = base


# ⭐️ Function: Place an application on the Desktop with basic functionality
applicationInitialize = (handleLayer, applicationName, applicationNameString) ->
	
	# Make sure the application is inside the desktop frame
	applicationName.parent = applicationContainer
	applicationBringToFront(applicationName, applicationNameString)
	
	# Allow the application to be draggable only when clicking on the
	handleLayer.on Events.TouchStart, ->
		
		# Bring the application to the front
		applicationBringToFront(applicationName, applicationNameString)
		
		# Make the application draggable
		applicationName.draggable = true
		applicationName.draggable.overdrag = false
		applicationName.draggable.momentum = false
		
		# Set the drag constraints
		applicationName.draggable.constraints =
			x: applicationContainer.width * -1
			width: applicationContainer.width * 3
			height: applicationContainer.height * 2
	
	# Remove draggability when not on draggableLayer
	handleLayer.on Events.TouchEnd, ->
		applicationName.draggable = false
	
	# Bring application to the front on click
	applicationName.onClick -> 
		applicationBringToFront(applicationName, applicationNameString)
	
	# Set states for Open and Close
	applicationName.states =
		closed:
			opacity: 0
			scale: 0.4
			animationOptions:
				time: 0
				
		open:
			opacity: 1
			scale: 1
			animationOptions:
				curve: Bezier.linear
				time: 0.2
	
	# Start the application in a closed state
	applicationName.stateSwitch("closed")


# 💫 Initialize applications
# Runs through the app arrays to prep each app
if OS == windows10
	for i in [0...windowsApplications.length]
		applicationInitialize(windowsToolbars[i], windowsApplications[i])
		
		if i == 0
			fileBrowser = windowsApplications[i]
		else if i == 1
			chat = windowsApplications[i]
		else if i == 2
			email = windowsApplications[i]
		else
			browser = windowsApplications[i]
			browserContent = edgeContent
		
else
	for i in [0...macApplications.length]
		applicationInitialize(macToolbars[i], macApplications[i], macApplicationNames[i])	
		
		if i == 0
			fileBrowser = macApplications[i]
		else if i == 1
			chat = macApplications[i]
		else if i == 2
			email = macApplications[i]
		else
			browser = macApplications[i]
			browserContent= safariContent


# 🌈 Sets default desktop alignment for each app
fileBrowser.x = Align.left(20)
fileBrowser.y = Align.top(30)

chat.x = Align.right(-20)
chat.y = Align.bottom(-40)
	
email.x = Align.left(60)
email.y = Align.bottom(-20)

browser.x = Align.center
browser.y = Align.center
# 🚥 Application open/close functions
# Functions for opening and closing applications

# ⭐️ Function: Open an app
appOpen = (app) ->
	
	app.visible = true
	
	if OS == windows10
		i = windowsApplications.indexOf app
		toolbarIcon = windowsToolbarIcons[i]
		
		app.animate("open")
		applicationBringToFront(app, null)
		toolbarIcon.backgroundColor = '#0078D6'
		
	else
		i = macApplications.indexOf app
		appName = macApplicationNames[i]
		appActivityDot = macDockActiveDots[i]
		
		app.animate("open")
		applicationBringToFront(app, appName)
		appActivityDot.visible = true


# ⭐️ Function: Close an app
appClose = (app) ->
	app.animate("closed")
	
	Utils.delay 1, ->
		app.visible = false
	
	if OS == windows10
		i = windowsApplications.indexOf app
		toolbarIcon = windowsToolbarIcons[i]
		toolbarIcon.backgroundColor = 'rgba(0,0,0,0)'
	else
		i = macApplications.indexOf app
		appActivityDot = macDockActiveDots[i]
		appActivityDot.visible = false
	
	if app == safari
		for child in browserContent.subLayers
			child.x = 9999
		
	if app == edge
		for child in browserContent.subLayers
			child.x = 9999


# 💫 Click listener: Open applications when clicking on app icons
for icon in macDockIcons
	icon.on Events.Click,(e, layer) ->
		i = macDockIcons.indexOf layer
		appOpen(macApplications[i])

for icon in windowsToolbarIcons
	icon.on Events.Click,(e, layer) ->
		i = windowsToolbarIcons.indexOf layer
		appOpen(windowsApplications[i])

# 💫 Click listener: Close applications when clicking on close icons
for icon in macCloseIcons
	icon.on Events.Click,(e, layer) ->
		i = macCloseIcons.indexOf layer
		appClose(macApplications[i])

for icon in windowsCloseIcons
	icon.on Events.Click,(e, layer) ->
		i = windowsCloseIcons.indexOf layer
		appClose(windowsApplications[i])
# 🚥 Application helper functions
# Specialized functions for certain applications

# ⭐️ Function: Create email (look at Example 1 for help using this)
emailNew = (emailContent, sender, subject, preview) ->
	if OS == windows10
		# Update text fields on Windows 10 Outlook
		outlookNew_sender.text = sender
		outlookContent_sender.text = sender
		outlookNew_subject.text = subject
		outlookContent_subject.text = subject
		outlookNew_preview.text = preview
		
		# Plop the email canvas in
		emailContent.props =
			parent: outlookContent_canvas
			x: Align.center
			y: 0
	
	else
		# Update text fields on macOS Mail
		mailNew_sender.text = sender
		mailContent_sender.text = sender
		mailNew_subject.text = subject
		mailContent_subject.text = subject
		mailNew_preview.text = preview
		
		# Plop the email canvas in
		emailContent.props =
			parent: mailContent_canvas
			x: Align.center
			y: 0


# ⭐️ Function: URL progress animation (automatically used with browserLoad() function)
animateUrlProgress = (animationLength = 1.2) ->
	if browser == safari
		safariToolbar_url_progress.width = 0
		safariToolbar_url_progress.opacity = 1
		
		urlAnimateHalf = new Animation safariToolbar_url_progress,
			width: safariToolbar_url.width / 4
			options: 
				curve: Bezier.easeInOut
				time: animationLength * 0.25
		
		urlAnimateFull = new Animation safariToolbar_url_progress,
			width: safariToolbar_url.width
			options: 
				curve: Bezier.easeInOut
				time: animationLength * 0.5
		
		urlAnimateFadeOut = new Animation safariToolbar_url_progress,
			opacity: 0
			options: 
				curve: Bezier.linear
				time: 0.3
				delay: 0.1
		
		urlAnimateHalf.start()
		urlAnimateHalf.on Events.AnimationEnd, urlAnimateFull.start
		urlAnimateFull.on Events.AnimationEnd, urlAnimateFadeOut.start
	
	else if browser == edge
		edge_tabDropbox_favicon.visible = false
		
		Utils.delay 0.6, ->
			edge_tabDropbox_favicon.visible = true


# ⭐️ Function: Load in a new web page
browserLoad = (targetPage, animationLength = 1.2) ->
	# Animate URL progress bar
	animateUrlProgress(animationLength)
	
	# Show specific page
	Utils.delay animationLength, ->
		# Hide previous page
		for child in browserContent.subLayers
			child.x = 9999
		
		# Put the target page inside the browser
		targetPage.parent = browserContent
		targetPage.x = 0
		targetPage.y = 0
		targetPage.visible = true

# Examples 
# NOTE: Enable these on line 17
# 💎 Example 1: Promotional email flow
# In this example, a user gets an email for Dropbox Showcase and clicks through to check it out

if showExample == 1

	# Create a new email using the design in the Design Tab
	emailNew(email_dropboxShowcase, "Dropbox", "Introducing Dropbox Showcase", "Hi Zach, Nobody likes burying their work in a pile of email attachements. Or const...")
	
	# Route based on current OS
	if OS == windows10
		# Fire an alert
		alertFire(windowsAlert_showcasePromo)
		
		# Open Outlook when the alert is clicked
		windowsAlert_showcasePromo.onClick -> 
			appOpen(outlook) 
		
		# Open Edge when email link is clicked
		btnShowcaseLaunch.onClick ->
			
			Utils.delay 0.1, ->
				appOpen(edge)
				browserLoad(pageShowcasePromo)
	
	else
		alertFire(macAlert_showcasePromo)
		
		# Open Mail when the alert is clicked
		macAlert_showcasePromo.onClick -> 
			appOpen(mail) 
		
		# Open Safari when email link is clicked
		btnShowcaseLaunch.onClick ->
			
			Utils.delay 0.1, ->
				appOpen(safari)
				browserLoad(pageShowcasePromo)

# 💎 Example 2: Onboarding with distractions!
# In this example, a bunch of distractions hit the user at once while they are trying to set up Dropbox

if showExample == 2

	# First, let's add an email they might be tempted to check
	emailNew(email_dropboxShowcase, "Dropbox", "Introducing Dropbox Showcase", "Hi Zach, Nobody likes burying their work in a pile of email attachements. Or const...")
	
	if OS == windows10
		appOpen(outlook)
	else 
		appOpen(mail)
	
	# Second, we'll have a chat conversation with a friend going on in the background
	if OS == windows10
		appOpen(skype)
	else 
		appOpen(messages)
	
	# Third, let's remind them of a call they scheduled after they finish the second step
	btnTipOne.onClick ->
		Utils.delay 2, ->
			if OS == windows10
				alertFire(windowsAlert_calendar)
			
			else
				alertFire(macAlert_calendar)
	
	# Last, let's load in our Dropbox page and onboarding
	browserLoad(pageDropboxOnboarding) 
	
	if OS == windows10
		appOpen(edge)
	else 
		appOpen(safari)
	
	tipSpring = "spring(150,25, -3)"
	
	for tip in [tipOne, tipTwo, tipThree]
		tip.opacity = 0
		tip.y = tip.y + 20	
		
		# Give the tip a hover state
		tip.style.cursor = "pointer"
		
		# On click, hide the current tip
		tip.onClick -> 
			this.animate
				properties: 
					opacity: 0
				curve: tipSpring
	
	# Show the first tip (after 2 seconds)
	Utils.delay 2, ->
		tipOne.animate
			properties: 
				opacity: 1
				y: tipOne.y - 20
			curve: tipSpring
	
	# Show the second tip
	tipOne.onClick ->
		tipTwo.animate
			properties: 
				opacity: 1 
				y: tipTwo.y - 20
			curve: tipSpring
	
	# Show the third tip
	tipTwo.onClick ->
		tipThree.animate
			properties: 
				opacity: 1
				y: tipThree.y - 20
			curve: tipSpring
# 💎 Example 3: Drag a file into Dropbox
# In this example, a user drags a file into Dropbox and an alert prompts them to view the file on Dropbox.com

if showExample == 3

	# Open a file browser
	if OS == windows10
		appOpen(fileExplorer)
	else 
		appOpen(finder)
	
	# Place a dummy file on the desktop
	dummyFile.props =
		parent: applicationContainer
		x: Align.right(-60)
		y: Align.top(20)
	
	# Make the file draggable
	dummyFile.draggable.enabled = true
	dummyFile.draggable.overdrag = false
	dummyFile.draggable.momentum = false
	
	dummyFile.onDrag (event, layer) ->
		dummyFileThumbnail.backgroundColor = "rgba(0,0,0,.15)"
		dummyFileLabel.backgroundColor = "#0A71D1"
		dummyFileName.color = "#fff"
	
	# When the file is dragged into finder, send an alert
	dummyFile.onDragEnd () ->
		a = dummyFile
		
		if OS == macOS
			b = finderContent
			
			if a.x < b.x + b.width && a.x + b.width > b.x && a.y < b.y + b.height && a.height + a.y > b.y	
				# Snap into place
				dummyFile.props =
					parent: b
					x: Align.left(0)
					y: Align.top(120)
				
				# Sync it to Dropbox
				Utils.delay 1, ->
					dummyFileSyncIcon.visible = true
				
				# Send push notification
				Utils.delay 1.5, ->
					alertFire(macAlert_onboardingSuccess)
		
		if OS == windows10
			b = fileExplorerContent
			
			if a.x < b.x + b.width && a.x + b.width > b.x && a.y < b.y + b.height && a.height + a.y > b.y	
				# Snap into place
				dummyFile.props =
					parent: b
					x: Align.left(0)
					y: Align.top(120)
				
				# Sync it to Dropbox
				Utils.delay 1, ->
					dummyFileSyncIcon.visible = true
				
				# Send push notification
				Utils.delay 1.5, ->
					alertFire(windowsAlert_onboardingSuccess)
	
	for alert in [macAlert_onboardingSuccess, windowsAlert_onboardingSuccess]
		alert.onClick ->
			browserLoad(pageUploadSuccess)
			if OS == windows10
				appOpen(edge)
			else 
				appOpen(safari)
			
			tipFileUpload.opacity = 0
			tipFileUpload.y = tipFileUpload.y + 20
			
			Utils.delay 2, ->
				tipFileUpload.animate
					properties: 
						opacity: 1
						y: tipFileUpload.y - 20
					curve: "spring(150,25, -3)"


############### YOUR CODE ###############

# Start writing code here!

# To get started, try uncommenting this line
# appOpen(safari)




