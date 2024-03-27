--[[
DDDDDDDDDDDDD                                                                                 UUUUUUUU     UUUUUUUUIIIIIIIIII
D::::::::::::DDD                                                                              U::::::U     U::::::UI::::::::I
D:::::::::::::::DD                                                                            U::::::U     U::::::UI::::::::I
DDD:::::DDDDD:::::D                                                                           UU:::::U     U:::::UUII::::::II
  D:::::D    D:::::D rrrrr   rrrrrrrrr   aaaaaaaaaaaaawwwwwww           wwwww           wwwwwwwU:::::U     U:::::U   I::::I  
  D:::::D     D:::::Dr::::rrr:::::::::r  a::::::::::::aw:::::w         w:::::w         w:::::w U:::::D     D:::::U   I::::I  
  D:::::D     D:::::Dr:::::::::::::::::r aaaaaaaaa:::::aw:::::w       w:::::::w       w:::::w  U:::::D     D:::::U   I::::I  
  D:::::D     D:::::Drr::::::rrrrr::::::r         a::::a w:::::w     w:::::::::w     w:::::w   U:::::D     D:::::U   I::::I  
  D:::::D     D:::::D r:::::r     r:::::r  aaaaaaa:::::a  w:::::w   w:::::w:::::w   w:::::w    U:::::D     D:::::U   I::::I  
  D:::::D     D:::::D r:::::r     rrrrrrraa::::::::::::a   w:::::w w:::::w w:::::w w:::::w     U:::::D     D:::::U   I::::I  
  D:::::D     D:::::D r:::::r           a::::aaaa::::::a    w:::::w:::::w   w:::::w:::::w      U:::::D     D:::::U   I::::I  
  D:::::D    D:::::D  r:::::r          a::::a    a:::::a     w:::::::::w     w:::::::::w       U::::::U   U::::::U   I::::I  
DDD:::::DDDDD:::::D   r:::::r          a::::a    a:::::a      w:::::::w       w:::::::w        U:::::::UUU:::::::U II::::::II
D:::::::::::::::DD    r:::::r          a:::::aaaa::::::a       w:::::w         w:::::w          UU:::::::::::::UU  I::::::::I
D::::::::::::DDD      r:::::r           a::::::::::aa:::a       w:::w           w:::w             UU:::::::::UU    I::::::::I
DDDDDDDDDDDDD         rrrrrrr            aaaaaaaaaa  aaaa        www             www                UUUUUUUUU      IIIIIIIIII
]]


-- Functions
DrawUI = {
    Menus = {},

    GetIndexID = function (menu, index, value)
        for i, v in ipairs(DrawUI.Menus[menu].index[index]) do
            if v == value then
                return i
            end
        end
    end,

    GetElement = function (menu, element) -- ex. For modify an element : DrawUI.GetElement('menu', 'rect').x = 0.2
        return DrawUI.Menus[menu].elements[element]
    end,

    GetCursorPosition = function()
        return GetControlNormal(0, 239), GetControlNormal(0, 240)
    end,

    IsPressed = function()
        return IsControlPressed(0,  24) or IsDisabledControlPressed(0,  24)
    end,

    CreateMenu = function(name, parentMenu, closeFunc)
        if not parentMenu then parentMenu = false end
        if not closeFunc then closeFunc = function() end end
        DrawUI.Menus[name] = {parentMenu = parentMenu, index = {elements = {}, buttons = {}, lists = {}, keys = {},},elements = {}, buttons = {}, lists = {}, keys = {}, onClose = closeFunc}
    end,

    --[[
    ForgetMenu = function(menu) -- Clear the menu from the memory of the Player
        if DrawUI.Menus[menu] and not DrawUI.Menus[menu].open then
            --table.remove(DrawUI.Menus[menu]) -- NOT WORKING
        end
    end,
    ]]

    DeleteElement = function (menu, element)
        if DrawUI.Menus[menu].elements[element] then
            table.remove(DrawUI.Menus[menu].index['elements'], DrawUI.GetIndexID(menu,'elements',element))
        end
    end,

    DeleteButton = function (menu, button)
        if DrawUI.Menus[menu].buttons[button] then
            table.remove(DrawUI.Menus[menu].index['buttons'], DrawUI.GetIndexID(menu,'buttons',button))
        end
    end,

    AddRect = function(menu, name, x, y, w, h, r, g, b, a)
        if DrawUI.Menus[menu] then
            DrawUI.Menus[menu].elements[name] = {
                type = 'rect',
                name = name,
                x = x,
                y = y,
                width = w,
                height = h,
                colors = {r = r, g = g, b = b},
                a = a,
                hidden = false
            }
            table.insert(DrawUI.Menus[menu].index['elements'],name)
        end
    end,

    AddImg = function(menu, name, file, x, y, w, h, heading, r, g, b, a)
        if DrawUI.Menus[menu] then
            DrawUI.Menus[menu].elements[name] = {
                type = 'img',
                name = name,
                file = file,
                x = x,
                y = y,
                width = w,
                height = h,
                heading = heading,
                colors = {r = r, g = g, b = b},
                a = a,
                hidden = false
            }
            table.insert(DrawUI.Menus[menu].index['elements'],name)
        end
    end,

    AddTxt = function(menu, name, text, size, x, y, r, g, b, a, parameters) -- parameters = {font = 0, shadows = {distance=1, r=1, g=1, b=1, a=255}, edges = {size=3, r=0, g=0, b=0, a=255}, wraps = {left=0, right=1}, justification = 'center'}
        if DrawUI.Menus[menu] then
            if parameters.wraps.left == 0 then parameters.wraps.left = 0.00001 end
            if parameters.wraps.right == 1 then parameters.wraps.right = 0.99999 end
            -- 0 and 1 just don't work, idk why
            DrawUI.Menus[menu].elements[name] = {
                type = 'txt',
                name = name,
                text = text,
                font = parameters.font or 0,
                size = size,
                colors = {r = r, g = g, b = b},
                a = a,
                shadows = {distance = parameters.shadows.distance or 1, r = parameters.shadows.r or 1, g = parameters.shadows.g or 1, b = parameters.shadows.b or 1, a = parameters.shadows.a or 255},
                edges = {size = parameters.edges.size or 3, r = parameters.edges.r or 0, g = parameters.edges.g or 0, b = parameters.edges.b or 0, a = parameters.edges.a or 255},
                wraps = {left = parameters.wraps.left or 0.00001, right = parameters.wraps.right or 0.99999},
                justification = parameters.justification or 'center',
                x = x,
                y = y,
                hidden = false
            }
            table.insert(DrawUI.Menus[menu].index['elements'],name)
        end
    end,

    AddButton = function(menu, name, x, y, w, h, clickAction, hoverAction)
        if DrawUI.Menus[menu] then
            DrawUI.Menus[menu].buttons[name] = {name = name, x = x, y = y, width = w, height = h, clickAction = clickAction, hoverAction = hoverAction}
            table.insert(DrawUI.Menus[menu].index['buttons'],name)
        end
    end,

    AddButtonFromElement = function(menu, name, element, clickAction, hoverAction) -- ONLY img or rect
        if DrawUI.Menus[menu] and DrawUI.Menus[menu].elements[element] then
            element = DrawUI.Menus[menu].elements[element]
            DrawUI.AddButton(menu, name, element.x, element.y, element.width, element.height, clickAction, hoverAction)
        end
    end,

    AddKeyAction = function(menu, name, padIndex, control, action, inputText, inputKey, inputDescription)
        if DrawUI.Menus[menu] then
            DrawUI.Menus[menu].keys[name] = {
                name = name,
                padIndex = padIndex,
                control = control,
                action = action,
                inputText = inputText,
                inputKey = inputKey,
                inputDescription = inputDescription
            }
            table.insert(DrawUI.Menus[menu].index['keys'],name)
        end
    end,

    CreateList = function (menu, name)
        if DrawUI.Menus[menu] then
            if DrawUI.Menus[menu].lists[name] then
                DrawUI.Menus[menu].lists[name] = {}
                return
            end
            DrawUI.Menus[menu].lists[name] = {elements = {}}
            table.insert(DrawUI.Menus[menu].index['lists'],name)
        end
    end,

    SetElementInList = function (menu, element, list, toggle)
        local list = DrawUI.Menus[menu].lists[list]
        if DrawUI.Menus[menu] and DrawUI.Menus[menu].elements[element] and list then
            if not toggle then print('[DrawUI] ERROR : You have to set the toggle true or false') return end
            if toggle then
                table.insert(list, element)
            else
                for i, v in ipairs(list) do
                    if v == element then
                        table.remove(i)
                    end
                end
            end
        end
    end,

    HideElement = function (menu, element, toggle)
        if DrawUI.Menus[menu] and DrawUI.Menus[menu].elements[element] then
            local state = DrawUI.GetElement(menu, element).hidden
            if not toggle then
                toggle = not state
            end
            state = toggle
        end
    end,

}

-- Code

DrawUI.DrawMenu = function(menu)
    DrawUI.Menus[menu].open = true
    Citizen.CreateThread(function ()
        local txd = CreateRuntimeTxd('DrawUI-'..menu)

        for k,v in pairs(DrawUI.Menus[menu].elements) do
            if v.type == 'img' then
                CreateRuntimeTextureFromImage(txd, v.name, v.file)
            end
        end

        if not HasStreamedTextureDictLoaded('DrawUI-'..menu) then
            RequestStreamedTextureDict('DrawUI-'..menu, true)
        end

        while DrawUI.Menus[menu].open do
            Citizen.Wait(1)
            SetMouseCursorActiveThisFrame()
            DisableControlAction(0, 1, false)
            DisableControlAction(0, 2, false)
            DisableControlAction(0, 24, false)
            EnableControlAction(0,239, true)
            EnableControlAction(0,240, true)
            for i,v in ipairs(DrawUI.Menus[menu].index['elements']) do
                local e = DrawUI.Menus[menu].elements[v]
                if e.type == 'rect' then
                    DrawRect(e.x+(e.width/2), e.y+(e.height/2), e.width, e.height, e.colors.r, e.colors.g, e.colors.b, e.a)
                elseif e.type == 'img' then
                    DrawSprite('DrawUI-'..menu, e.name, e.x+(e.width/2), e.y+(e.height/2), e.width, e.height, e.heading, e.colors.r, e.colors.g, e.colors.b, e.a)
                elseif e.type == 'txt' then
                    SetTextFont(e.font)
                    SetTextProportional(1)
                    SetTextScale(0.0, e.size)
                    SetTextColour(e.colors.r, e.colors.g, e.colors.b, e.a)
                    SetTextDropshadow(e.shadows.distdance, e.shadows.r, e.shadows.g, e.shadows.b, e.shadows.a)
                    SetTextEdge(e.edges.size, e.edges.r, e.edges.g, e.edges.b, e.edges.a)
                    SetTextWrap(e.wraps.left, e.wraps.right)
                    local justification
                    if e.justification == 'center' then
                        justification = 0
                    elseif e.justification == 'left' then
                        justification = 1
                    elseif e.justification == 'right' then
                        justification = 2
                    else
                        justification = e.justification
                    end
                    SetTextJustification(justification) -- 0: Center-Justify  1: Left-Justify  2: Right-Justify  Right-Justify requires SET_TEXT_WRAP
                    SetTextEntry('STRING')
                    AddTextComponentString(e.text)
                    DrawText(e.x, e.y)
                end
            end
        end
        DrawUI.Menus[menu].onClose()
    end)
    Citizen.CreateThread(function ()
        while DrawUI.Menus[menu].open do
            Citizen.Wait(50)

            -- Back / Close
            if IsControlPressed(0, 177) then
                DrawUI.Menus[menu].open = false
                if DrawUI.Menus[menu].parentMenu then
                    DrawUI.DrawMenu(parentMenu)
                end
            end

            -- Keys
            for i,v in ipairs(DrawUI.Menus[menu].index['keys']) do
                local e = DrawUI.Menus[menu].keys[v]
                if IsControlPressed(v.padIndex, v.control) or IsDisabledControlPressed(v.padIndex, v.control) then
                    e.action()
                end
                --if e.inputText then
                --    
                --end
            end

            -- Buttons
            if #DrawUI.Menus[menu].index['buttons'] then
                for i,v in ipairs(DrawUI.Menus[menu].index['buttons']) do
                    local e = DrawUI.Menus[menu].buttons[v]
                    local posx, posy = DrawUI.GetCursorPosition()
                    if posx >= e.x and posx <= e.x + e.width and posy >= e.y and posy <= e.y + e.height then
                        if e.hoverAction then
                            e.hoverAction(e)
                        end
                        --SetMouseCursorSprite(5)
                        if DrawUI.IsPressed() then
                            while DrawUI.IsPressed() do
                                Citizen.Wait(1)
                            end
                            if e.clickAction then
                                e.clickAction(e)
                            else
                                print('[DrawUI] WTF : Your button don\'t have an action ???')
                            end
                        end
                    --else
                        --SetMouseCursorSprite(1)
                    end
                end
            --else
                --SetMouseCursorSprite(1)
            end
        end
    end)
end

-- Scaleform
-- https://forum.cfx.re/t/scaleforms/99874

--[[
function Scaleform.Request(scaleform)
    local scaleform_handle = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform_handle) do
        Citizen.Wait(0)
    end
    return scaleform_handle
end

function Scaleform.CallFunction(scaleform, returndata, the_function, ...)
    BeginScaleformMovieMethod(scaleform, the_function)
    local args = {...}

    if args ~= nil then
        for i = 1,#args do
            local arg_type = type(args[i])

            if arg_type == "boolean" then
                ScaleformMovieMethodAddParamBool(args[i])
            elseif arg_type == "number" then
                if not string.find(args[i], '%.') then
                    ScaleformMovieMethodAddParamInt(args[i])
                else
                    ScaleformMovieMethodAddParamFloat(args[i])
                end
            elseif arg_type == "string" then
                ScaleformMovieMethodAddParamTextureNameString(args[i])
            end
        end

        if not returndata then
            EndScaleformMovieMethod()
        else
            return EndScaleformMovieMethodReturnValue()
        end
    end
end

function RequestButtonScaleform()
    ButtonScaleformId = Scaleform.Request("instructional_buttons")
    DrawScaleformMovieFullscreen(ButtonScaleformId, 255, 255, 255, 0, 0)

    Scaleform.CallFunction(ButtonScaleformId, false, "SET_BACKGROUND_COLOUR", 0,0,0,80)
    Scaleform.CallFunction(ButtonScaleformId, false, "CLEAR_ALL")
    Scaleform.CallFunction(ButtonScaleformId, false, "SET_CLEAR_SPACE", 200)
end


function ClearInstructionalButtons()
    Scaleform.CallFunction(ButtonScaleformId, false, "CLEAR_ALL")
    Scaleform.CallFunction(ButtonScaleformId, false, "SET_CLEAR_SPACE", 200)
end

function SetInstructionalButtons(setArray)
    for i,k in pairs(setArray) do
        Scaleform.CallFunction(ButtonScaleformId, false, "SET_DATA_SLOT",i, k.input, k.text)
    end

    Scaleform.CallFunction(ButtonScaleformId, false, "DRAW_INSTRUCTIONAL_BUTTONS")
end
]]



--[[
888b     d888               888              888                   888888b.   8888888b.  888b    888           .d888
8888b   d8888               888              888                   888  "88b  888  "Y88b 8888b   888          d88P"
88888b.d88888               888              888                   888  .88P  888    888 88888b  888          888
888Y88888P888  8888b.   .d88888  .d88b.      88888b.  888  888     8888888K.  888    888 888Y88b 888          888888 888d888
888 Y888P 888     "88b d88" 888 d8P  Y8b     888 "88b 888  888     888  "Y88b 888    888 888 Y88b888          888    888P"
888  Y8P  888 .d888888 888  888 88888888     888  888 888  888     888    888 888    888 888  Y88888          888    888
888   "   888 888  888 Y88b 888 Y8b.         888 d88P Y88b 888     888   d88P 888  .d88P 888   Y8888          888    888
888       888 "Y888888  "Y88888  "Y8888      88888P"   "Y88888     8888888P"  8888888P"  888    Y888 88888888 888    888
                                                           888
                                                      Y8b d88P
                                                       "Y88P"
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                            ..............................................:....                     
                          ..:::::::::::::::::::::::::::::::::::::::::::::::::::..                   
                         .::-=================================================-::.                  
                       .::=======================================================:..                
                    ..::--=======================================================--:..              
                    ..:-===========================================================-...             
                    ..:-===========================================================-:..             
                    .::-===========================================================-:..             
                    ..:-===========================================================-:..             
                    ..:-===========================================================-:..             
                    ..:-===========================================================-:..             
                    ..:-===========================================================-:..             
                    ..:-===========================================================-:..             
                    ..:-===================-:::::::::::::::::::-===================-:..             
                    ..:-===================-::................:-===================-:..             
                    ..:-===================-..................:-===================-:..             
                    ..:-===================-:.:             ..:-===================-:..             
                    .::-===================-:.:             ..:-===================-:..             
                    .::-==-:::::::::::::-==-..:             ..:-===================-:..             
                    ..::----::::::::::::---:..:             ..:-===================-:..             
                    ..::::===============:::..:             ..:-===================-:..             
                  :::=========================::.           ..:-===================-:..             
               ..:--==========================--::..:.........:-===================-:..             
               ..:-==--================-========-::::::::::::::-===================-:..             
               ..:-=-..-==============:.:==========================================-:..             
             ..:=====..-==============:.:==========================================-:..             
             ..:=====---==============---==+=====:-================================-:..             
             :.:================================:.:================================-:..             
             :....-=====================-.......:==================================-:..             
             .::--:.....................:-=========================================-:..             
             ..:==-:::::::::::::::::::::-==========================================-:..             
             ..:===================================================================::..             
             ..:=================================================================::....             
             ..:==============================================================-::::...              
             .::==============================================================:..:..                
               .::-===========================::..........................::::.:..                  
               .:::::====================::::::..................................                   
                ...::-------------------::.....................................                     
                  ...::::::.......::::::::.....                                                     
                       ...................                                                          
                       ..................                                                           
]]