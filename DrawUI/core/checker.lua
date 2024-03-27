-- https://github.com/Blumlaut/FiveM-Resource-Version-Check-Thing/tree/master
Citizen.CreateThread( function()
    local updatePath = "/BDN-fr/DrawUI" -- your git user/repo path
    local resourceName = "DrawUI" -- the resource name
    if GetCurrentResourceName() ~= resourceName then
        resourceName = resourceName..' ('..GetCurrentResourceName()..')'
    end
    
    local function checkVersion(err,responseText, headers)
        local curVersion = LoadResourceFile(GetCurrentResourceName(), "version") -- make sure the "version" file actually exists in your resource root!
    
        if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
            print("###############################")
            print("\n"..resourceName.." is outdated, should be:\n"..responseText.."is:\n"..curVersion.."\nplease update it from https://github.com"..updatePath.."\n")
            print("###############################")
        elseif tonumber(curVersion) > tonumber(responseText) then
            print("You somehow skipped a few versions of "..resourceName.." or the git went offline, if it's still online i advise you to update ( or downgrade? )")
        end
    end
    
PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/main/DrawUI/version", checkVersion, "GET")
end)