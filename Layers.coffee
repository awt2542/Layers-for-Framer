module.exports = {

	all: -> Framer.CurrentContext.getLayers()

	withName: (name) ->
 		_.filter @all(), (layer) -> 
 			if layer.name is name then true

	containing: (name) ->
		_.filter @all(), (layer) -> 
			if layer.name.indexOf(name) isnt -1 then true

	withWord: (name, delimiter = '_') ->
		both = delimiter+name+delimiter
		end = name+delimiter
		start = delimiter+name

		_.filter @containing(name), (layer) ->
			if layer.name is name then true
			else if layer.name.indexOf(both) isnt -1 then true
			else if layer.name.indexOf(end) is 0 then true
			else if layer.name.indexOf(start) is layer.name.length-start.length then true
		
	startingWith: (name) ->
		_.filter @all(), (layer) -> 
			if layer.name.substring(0,name.length) is name then true

	endingWith: (name) ->
		_.filter @all(), (layer) -> 
			if layer.name.indexOf(name, layer.name.length - name.length) isnt -1 then true

	withState: (state) -> 
		_.filter @all(), (layer) ->
			layerStates = layer.states._orderedStates
			if layerStates.indexOf(state) isnt -1 then true

	withCurrentState: (state) -> 
		_.filter @all(), (layer) ->
			currentState = layer.states.current
			if currentState.indexOf(state) isnt -1 then true

	withSuperLayer: (name) ->
		matchingLayers = []
		for layer in @withName(name)
			matchingLayers = matchingLayers.concat(layer.subLayers)

	withSubLayer: (name) ->
		matchingLayers = []
		for layer in @withName(name)
			if matchingLayers.indexOf(layer.superLayer) is -1
				matchingLayers.push(layer.superLayer)

	where: (obj) ->
		_.where Framer.CurrentContext.getLayers(), obj

	get: (name) ->
		@withName(name)[0]
}

Layer::switchPrefix = (newPrefix, delimiter = '_') ->
	name = this.name
	newName = newPrefix + name.slice name.indexOf delimiter
	return module.exports.get newName

# By https://github.com/facebook/shortcuts-for-framer
Layer::findSubLayer = (needle, recursive = true) ->
  # Search direct children
  for subLayer in @subLayers
    return subLayer if subLayer.name.toLowerCase().indexOf(needle.toLowerCase()) isnt -1 
  # Recursively search children of children
  if recursive
    for subLayer in @subLayers
      return subLayer.findSubLayer(needle, recursive) if subLayer.findSubLayer(needle, recursive)
      
Layer::find = (needle, recursive = true ) -> @findSubLayer needle, recursive = true
      
Layer::findSuperLayer = (needle, recursive = true) ->
  # Search direct children
  return @superLayer if @superLayer.name.toLowerCase().indexOf(needle.toLowerCase()) isnt -1 
  # Recursively search children of children
  if recursive
  	return @superLayer.findSuperLayer(needle, recursive) if @superLayer.findSuperLayer(needle, recursive)