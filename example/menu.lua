local menu = 'panel'
local defaultx, defaulty = 0.20, 0.25
local listOfWorlds = {'You\'ve made your first scroll !', 'The 2nd scroll', 'the 3rd', '4', '5', 'You can count ?', 'Yeah obviously', 'You can might stop scrolling ?', 'To go outside for example', 'and ...', 'TOUCH GRASS', 'STOOPPP SCROLLING DOWN', 'This is the last text...'}

Wait(1) -- You NEED this wait
DrawUI.CreateMenu(menu)
DrawUI.AddRect(menu,'background',0.18,0.18,0.64,0.64,75,75,75,175)
DrawUI.AddImg(menu,'img','img/test.png',0.2,0.05,0.35,0.15,0,255,255,255,150)
DrawUI.AddTxt(menu, 'Hide-img', 'Press [E] for hide this image', 0.5, 0.4, 0.20, 255, 255, 255, 255)
DrawUI.AddRect(menu, 'ListsRect',0.8,0.4,0.18,0.2,255,255,255,255)
DrawUI.AddTxt(menu, 'ListsTxt', 'Access "list" menu', 0.3 ,0.85, 0.5, 0, 0, 0, 255, {justification = 'left'})
DrawUI.AddButtonFromElement(menu,'lists','ListsRect',function ()
    DrawUI.Menus[menu].open = false
    DrawUI.DrawMenu('list')
end)
DrawUI.AddKeyAction(menu, 'Hide-img', 0, 51, function ()
    DrawUI.HideElement(menu, 'img')
    DrawUI.HideElement(menu, 'Hide-img')
end)

DrawUI.CreateMenu('list',menu)
DrawUI.AddTxt('list','txt','You are at scroll 0',0.7,0.2,0.2,255,255,255,255,{justification = 'left'})
DrawUI.CreateList('list','list',function (scrollAmount)
    DrawUI.SetVariable('list','elements','txt','text',listOfWorlds[scrollAmount] or ('You are at scroll '.. scrollAmount))
    if scrollAmount > 1000 then
        DrawUI.SetVariable('list','lists','list','scrollAmount',0)
        DrawUI.SetVariable('list','elements','txt','text','You have scrolled very long time for nothing :)')
        print('You have scrolled very long time for nothing')
    end
end)

RegisterCommand(menu,function ()
    local columns = 0
    local lines = 0
    for i = 1, 16, 1 do
        local x = defaultx + ( 0.15 * columns )
        local y = defaulty + ( 0.15 * lines )
        DrawUI.AddRect(menu,'button'..i,x,y,0.1,0.1,25,25,25,255)
        DrawUI.AddButtonFromElement(menu, 'button'..i, 'button'..i, function ()
            DrawUI.DeleteElement(menu,'button'..i)
            DrawUI.DeleteButton(menu,'button'..i)
        end)
        lines = lines + 1
        if lines == 4 then
            lines = 0
            columns = columns + 1
        end
    end
    DrawUI.DrawMenu(menu)
end)