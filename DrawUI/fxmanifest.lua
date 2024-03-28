fx_version 'cerulean'
games { 'gta5' }

client_script 'core/core.lua'
server_script 'core/checker.lua'

files {'**.png', '**.jpg', '**.jpeg'}

--[[
In your fxmanifest you simply have to add :

    client_script '@DrawUI/core/core.lua'
    files {'**.png', '**.jpg', '**.jpeg'} -- For images
    dependency 'DrawUI'

]]