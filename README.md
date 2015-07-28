# Layers for Framer.js

Proof-of-concept-module that makes it easier to find and target layers in Framer.js. Find all layers in your project, target layers that shares the same name, create custom naming schemes for default behaviors, find layers with a certain state defined and more.
Some methods require the .name property to be set (automatically set if you import from PS/Sketch).

## Installation

1. Download the Layers.coffee file
2. Drop it inside the code editor of a framer studio project


More info about modules in Framer and how to install them: [FramerJS Docs - Modules](http://framerjs.com/docs/#modules)


## Methods

Each method returns an array with layers:

.all() - All layers in your project

.withName(string) - Layers with matching name (regex, case-sensitive)

.withState(string) - Layers with matching state defined

.withSuperLayer(string) - Layers with matching superLayer

.withSubLayer(string) - Layers with matching subLayer


## Examples

### Fade-in all layers 
	for layer,i in Layers.all()
		layer.opacity = 0
		layer.scale = .5
		layer.animate
			properties:
				opacity: 1
				scale: 1
			time: 0.5
			delay: i/20
		
### Create custom naming schemes with default behaviors
	for layer in Layers.withName '_drag'
		layer.draggable.enabled = true 
		layer.draggable.speedX = 0

	for layer in Layers.withName '_btn_wip'
		layer.on Events.Click, -> 
			print "This feature is still work in progress"

	for layer in Layers.withName 'person|animal'
		layer.opacity = .5
		
	layer.visible = false for layer in Layers.withName '_hide'

### Switch to the "popup" state on layers where it has been defined
	for layer in Layers.withState 'popup'
		layer.states.switch 'popup'

### Find layers inside a dropzone and disable draggable
	for layer in Layers.withSuperLayer 'dropzone'
		layer.draggable.enabled = false


##Contact

Twitter: [@andreaswah](http://twitter.com/andreaswah)
