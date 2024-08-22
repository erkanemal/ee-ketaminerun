fx_version 'cerulean'
game 'gta5'

author 'Erkanpl'
description 'A simple drug run mission for FiveM using ox_lib and ox_target'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}
