module.exports = {
	all: -> Framer.CurrentContext.getLayers()
	withName: (name) ->
		matchingLayers = []
		for layer in Framer.CurrentContext.getLayers()
 			matchingLayers.push(layer) if layer.name.match(name)
 		return matchingLayers.reverse() # to match layerlist order
	withState: (state) -> # use regex, instead?
		matchingLayers = []
		for layer in Framer.CurrentContext.getLayers()
			layerStates = layer.states._orderedStates
			matchingLayers.push(layer) if layerStates.indexOf(state) isnt -1
		return matchingLayers.reverse()
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
}