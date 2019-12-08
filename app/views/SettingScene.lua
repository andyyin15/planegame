local    MUSIC_FILE = "background-music-aac.mp3"
local    isplaying_tag = 1000
local size = cc.Director:getInstance():getWinSize()

function SettingScene_onCreate()
    local scene = cc.Scene:create()
    --local layer = cc.Layer:create()
    local child = cc.Sprite:create("bg.png")
    local childSize = child:getContentSize()
    child:setPosition(size.width/2,size.height/2)
    local btn1 = nil
    local btn2 = nil
    scene:addChild(child)

    local function turnOnOffMusic(menuItemSender)
        if isplaying_tag then
           AudioEngine.pauseMusic()
           isplaying_tag = nil
           btn2:setVisible(false)
           btn1:setVisible(true)
           
           

        elseif not isplaying_tag then

            isplaying_tag = 1000
            AudioEngine.playMusic(MUSIC_FILE, true)
            btn2:setVisible(true)
           btn1:setVisible(false)
        else
            print("xixixixixixi")
            
        end
    end
    

    local function backMainScene(backScene)
        
        cc.Director:getInstance():popScene() 
    end

    local menu = cc.Menu:create()
    menu:setPosition(cc.p(0, 0))
    cc.MenuItemFont:setFontName("Arial")
    cc.MenuItemFont:setFontSize(50)

    local backitem = cc.MenuItemFont:create("Back")
    backitem:registerScriptTapHandler(backMainScene)
    menu:addChild(backitem, 1) 
    backitem:setAnchorPoint(0.5,0.5)
    local backItemSize = backitem:getContentSize()
    backitem:setPosition(backItemSize.width, backItemSize.height)
    scene:addChild(menu)

    local playmusicitem = cc.MenuItemFont:create("PlayMusic")
    playmusicitem:registerScriptTapHandler(turnOnOffMusic)
    menu:addChild(playmusicitem, 2) 
    playmusicitem:setAnchorPoint(0.5,0.5)
    playmusicitem:setColor(cc.c3b(255, 0, 0))
    --local playmusicitemSize = playmusicitem:getContentSize()
    playmusicitem:setPosition(size.width/2, size.height/2)
    
   
    local stopmusicitem = cc.MenuItemFont:create("StopMusic")
    stopmusicitem:registerScriptTapHandler(turnOnOffMusic)
    menu:addChild(stopmusicitem, 3) 
    stopmusicitem:setAnchorPoint(0.5,0.5)
    stopmusicitem:setColor(cc.c3b(255, 0, 0))
    --local playmusicitemSize = playmusicitem:getContentSize()
    stopmusicitem:setPosition(size.width/2, size.height/2)
   
     if isplaying_tag then
        stopmusicitem:setVisible(true)
        playmusicitem:setVisible(false)
        btn1 = playmusicitem
        btn2 = stopmusicitem
    end
    return scene
end
