module.exports = {
	all: -> Framer.CurrentContext.getLayers()

	withName: (name) ->
 		matchingLayers = _.filter @all(), (layer) -> 
 			layer if layer.name is name

	containing: (name) ->
		matchingLayers = _.filter @all(), (layer) -> 
			layer if layer.name.indexOf(name) isnt -1

	withWord: (name) ->
		matchingLayers = []
		both = '_'+name+'_'
		end = name+'_'
		start = '_'+name
		
		for layer in @containing name
			if layer.name is name
				if matchingLayers.indexOf layer is -1
					matchingLayers.push layer
			else if layer.name.indexOf(both) isnt -1
				if matchingLayers.indexOf layer is -1
					matchingLayers.push layer
			else if layer.name.indexOf(end) isnt -1
				if matchingLayers.indexOf layer is -1
					matchingLayers.push layer
			else if layer.name.indexOf(start) isnt -1
				if matchingLayers.indexOf layer is -1
					matchingLayers.push layer
		return matchingLayers
		
	startingWith: (name) ->
		matchingLayers = _.filter @all(), (layer) -> 
			layer if layer.name.substring(0,name.length) is name

	endingWith: (name) ->
		matchingLayers = _.filter @all(), (layer) -> 
			layer if layer.name.indexOf(name, layer.name.length - name.length) isnt -1

	withState: (state) -> 
		matchingLayers = _.filter @all(), (layer) ->
			layerStates = layer.states._orderedStates
			layer if layerStates.indexOf(state) isnt -1

	withCurrentState: (state) -> 
		matchingLayers = _.filter @all(), (layer) ->
			currentState = layer.states.current
			layer if currentState.indexOf(state) isnt -1

	withSuperLayer: (name) ->
		matchingLayers = []
		for layer in @withName(name)
			matchingLayers = matchingLayers.concat(layer.subLayers)
		return matchingLayers.reverse()

	withSubLayer: (name) ->
		matchingLayers = []
		for layer in @withName(name)
			if matchingLayers.indexOf(layer.superLayer) is -1
				matchingLayers.push(layer.superLayer) 
		return matchingLayers.reverse()

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