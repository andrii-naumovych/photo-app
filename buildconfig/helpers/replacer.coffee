fs = require "fs"

_private =
	placeholderTPL: "##"
	replaceInFile: (path, criterion) ->
		fileContent = fs.readFileSync path, "utf-8"

		for i of criterion
			continue unless criterion.hasOwnProperty i
			regExp = new RegExp @placeholderTPL + i + @placeholderTPL.split("").reverse().join(""), "g"
			fileContent = fileContent.replace regExp, criterion[i]

		fs.writeFileSync path, fileContent, "utf-8"

	replaceInDir: (dirArr, criterion) ->
		dirArr.forEach (path) =>
			stat = fs.lstatSync path

			if stat.isDirectory()
				@replaceInDir fs.readdirSync(path).map (item) -> path + "/" + item
			else if stat.isFile()
				@replaceInFile path, criterion
			else
				console.error "No such file or dir: #{path}"

API =
	###
	# files: ["coffee"]
	###
	replace: (files, criterion) ->
		_private.replaceInDir files, criterion

module.exports = (config) ->
	_private.placeholderTPL = config.placeholderTPL if config.placeholderTPL

	API

