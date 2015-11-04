# Layers for Framer.js

Inspired by jQuery's selectors, this module makes it easier to find and target layers in Framer.js. Find all layers in your project, target layers that shares the same name, create custom naming schemes for default behaviors, find layers with a certain state defined and more.
Some methods require the .name property to be set (automatically done if you import from PS/Sketch).

## Installation

1. Download the Layers.coffee file
2. Drop it inside the code editor of a framer studio project


More info about modules in Framer and how to install them: [FramerJS Docs - Modules](http://framerjs.com/docs/#modules)


## Methods

Each method on the Layers object returns an array with layers:

.all() - All layers in your project

.withName(string) - Layers with exact name as string

.withWord(string) - Layers with name containing string separated by underscores

.get(string) - Same as .withName, but returns the first match

.containing(string) - Layers with name containing string

.startingWith(string) - Layers with name that starts with string

.endingWith(string) - Layers with name that ends with string

.withState(string) - Layers with matching state defined

.withCurrentState(string) - Layers with match state currently active

.withSuperLayer(string) - Layers with matching superLayer

.withSubLayer(string) - Layers with matching subLayer

.where(obj) - Layers matching properties and values

The following methods are also added to your layers:

.findSubLayer(string) - Traverse down the tree and return first matching layer

.findSuperLayer(string) - Traverse up the tree and return first matching layer

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
	for layer in Layers.endingWith '_drag'
		layer.draggable.enabled = true 
		layer.draggable.speedX = 0

	for layer in Layers.endingWith '_btn_wip'
		layer.on Events.Click, -> 
			print "This feature is still work in progress"

	for layer in Layers.containing 'person|animal'
		layer.opacity = .5
		
	layer.visible = false for layer in Layers.endingWith '_hide'

### Switch to the "popup" state on layers where it has been defined
	for layer in Layers.withState 'popup'
		layer.states.switch 'popup'

### Find layers inside a dropzone and disable draggable
	for layer in Layers.withSuperLayer 'dropzone'
		layer.draggable.enabled = false

### Travel up and down the layer tree 
	for card in Layers.startingWith 'card'
		card.findSubLayer('delete').on Events.Click, ->
			@findSuperLayer('card').destroy()

### Find layers by their current values
	layer.opacity = 0.2 for layer in Layers.where opacity: 1


##Contact

Twitter: [@andreaswah](http://twitter.com/andreaswah)
