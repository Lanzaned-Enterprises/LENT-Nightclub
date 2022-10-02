-- [[ Metadata ]] --
fx_version 'cerulean'
games { 'gta5' }

-- [[ Author ]] --
author 'Izumi S. <https://discordapp.com/users/871877975346405388>'
description 'Lananed Development | Nightclub heist'
discord 'https://discord.gg/kmKcHWGqbP'
github 'https://github.com/Lanzaned-Enterprises/LENT-Nightclub'
docs 'https://lanzaned-development.gitbook.io/lanzaned-development-or-documentation/'

-- [[ Version ]] --
version '1.0.0'

-- [[ Dependencies ]] --
dependencies {
    'qb-core',
    'qb-target',
    'PolyZone',
    'ps-ui',
}

-- [[ Files ]] --
shared_scripts {
    'shared/*.lua',
}

server_scripts {
    'server/*.lua',
}

client_scripts {
    -- Polyzone
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    -- Client Events
    'client/*.lua',
}

-- [[ Tebex ]] --
lua54 'yes'