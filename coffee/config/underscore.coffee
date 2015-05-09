_.mixin
	getStackTrace: ->
		error = new Error
		return error.stack

		obj = {}
		Error.captureStackTrace obj, _.getStackTrace
		obj.stack
	log: ->
		trace =  _.getStackTrace()

		if trace
			needed = trace.split("\n")[3].trim()

			arr = []
			[].push.apply arr, arguments

			console.groupCollapsed.apply console, arr
			console.log.call console, needed
			console.groupEnd()
		else
			console.log.apply console, arguments