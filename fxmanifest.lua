fx_version 'cerulean'
game 'gta5'

author 'Erkanpl'
description 'A simple drug run mission for FiveM using ox_lib and ox_target'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    '@ox_lib/init.lua',
    'client/main.lua',
}

server_scripts {
    '@ox_lib/init.lua',
    'server/main.lua',
}

dependencies {
    'ox_lib',
    'ox_target',
    -- add 'qb-target' if you're using it as a dependency
}
