local menu = 'panel'
RegisterCommand(menu,function ()
    DrawUI.ForgetMenu(menu)
    DrawUI.CreateMenu(menu)
    DrawUI.AddRect(menu,'background',0.18,0.18,0.64,0.64,75,75,75,175)
    DrawUI.AddImg(menu,'img','img/test.png',0.2,0.2,0.6,0.6,0,255,255,255,150)
    local defaultx = 0.20
    local defaulty = 0.25
    local colomns = 0
    local lines = 0
    for i = 1, math.random(16), 1 do
        local x
        local y
        x = defaultx + ( 0.15 * colomns )
        y = defaulty + ( 0.15 * lines )
        DrawUI.AddRect(menu,'button'..i,x,y,0.1,0.1,25,25,25,255)
        DrawUI.AddButtonFromElement(menu, 'button'..i, 'button'..i, function (button)
            DrawUI.DeleteElement(menu,button.name)
            DrawUI.DeleteButton(menu,button.name)
        end)
        lines = lines + 1
        if lines == 4 then
            lines = 0
            colomns = colomns + 1
        end
    end
    DrawUI.DrawMenu(menu)
end)