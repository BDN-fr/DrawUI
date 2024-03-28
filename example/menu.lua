local menu = 'panel'
local defaultx = 0.20
local defaulty = 0.25

Wait(1) -- You NEED this wait
DrawUI.CreateMenu(menu)
DrawUI.AddRect(menu,'background',0.18,0.18,0.64,0.64,75,75,75,175)
DrawUI.AddImg(menu,'img','img/test.png',0.2,0.05,0.35,0.15,0,255,255,255,150)
DrawUI.AddTxt(menu, 'Hide-img', 'Press [E] for hide this image', 0.5, 0.4, 0.20, 255, 255, 255, 255)

DrawUI.AddKeyAction(menu, 'Hide-img', 0, 51, function ()
    DrawUI.HideElement(menu, 'img')
    DrawUI.HideElement(menu, 'Hide-img')
end)

RegisterCommand(menu,function ()
    local colomns = 0
    local lines = 0
    for i = 1, 16, 1 do
        local x = defaultx + ( 0.15 * colomns )
        local y = defaulty + ( 0.15 * lines )
        DrawUI.AddRect(menu,'button'..i,x,y,0.1,0.1,25,25,25,255)
        DrawUI.AddButtonFromElement(menu, 'button'..i, 'button'..i, function ()
            DrawUI.DeleteElement(menu,'button'..i)
            DrawUI.DeleteButton(menu,'button'..i)
        end)
        lines = lines + 1
        if lines == 4 then
            lines = 0
            colomns = colomns + 1
        end
    end
    DrawUI.DrawMenu(menu)
end)