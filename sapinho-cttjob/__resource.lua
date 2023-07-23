resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Script de entregas CTT para ESX 1.1'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'[SERVER]/sv_main.lua'
}

client_scripts {
	'[CLIENT]/cl_others.lua',
	'[CLIENT]/cl_main.lua'
}

shared_scripts {
	'[CONFIG]/config.lua'
}

dependencies {
	'es_extended',
	'okokNotify',
	'carrinha-ctt'
}
