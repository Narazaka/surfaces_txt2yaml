### (C) 2018 Narazaka : Licensed under The MIT License - http://narazaka.net/license/MIT?2018 ###
fs = require 'fs'
argv = require 'argv'
SurfacesTxt2Yaml = require '../lib/surfaces_txt2yaml'

args = argv
.info '''
Usage : surfaces_txt2yaml [options] surfaces.txt

common: surfaces_txt2yaml -c ssp-lazy -o surfaces.yaml surfaces.txt
'''
.option [
	{
		name: 'output'
		short: 'o'
		type: 'path'
		description: 'output (default: stdout)'
	}
	{
		name: 'lint'
		short: 'v'
		type: 'boolean'
		description: 'validation only'
	}
	{
		name: 'compatible'
		short: 'c'
		type: 'string'
		description: 'set all options to parse surfaces.txt as [materia/ssp(default)/ssp-lazy] compatible'
	}
	{
		name: 'charset'
		short: 'C'
		type: 'boolean'
		description: 'enable charset setting parse'
	}
	{
		name: 'check_seriko'
		short: 'a'
		type: 'string'
		description: 'check seriko version [warn/throw]'
	}
	{
		name: 'allow_all_seriko'
		short: 'A'
		type: 'boolean'
		description: 'accept any seriko version with ignoring "version" property'
	}
	{
		name: 'surface_definition'
		short: 'S'
		type: 'string'
		description: 'parse surface definition as [materia/ssp/ssp-lazy] compatible'
	}
	{
		name: 'check_surface_scope_duplication'
		short: 'd'
		type: 'string'
		description: 'check surface scope duplication [warn/throw]'
	}
	{
		name: 'check_nonstandard_comment'
		short: 'n'
		type: 'string'
		description: 'check nonstandard comment [warn/throw]'
	}
	{
		name: 'comment_prefix'
		short: 'p'
		type: 'csv,string'
		description: 'comment prefix (default: "//")'
		example: '-p "//,#,;"'
	}
]
.run()

unless args.targets.length
	argv.help()
	process.exit()

txt_str = ''
for file in args.targets
	txt_str += fs.readFileSync file, 'utf8'
yaml = SurfacesTxt2Yaml.txt_to_yaml txt_str, args.options
if args.options.lint
	console.log 'LINT END'
else
	if args.options.output
		fs.writeFileSync args.options.output, yaml, 'utf8'
	else
		console.log yaml

