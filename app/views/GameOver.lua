--require "app/views/MainScene"

local size = cc.Director:getInstance():getWinSize()
local LineBreaksExample = "GAME OEVR !!\n"


function GameOver_onCreate()
    local scene = cc.Scene:create()
    --local layer = cc.Layer:create()
    local child = cc.Sprite:create(s_bg)
    local childSize = child:getContentSize()
    child:setPosition(size.width/2,size.height/2)
    --layer:addChild(child)
    scene:addChild(child,1)

    local pLable = cc.LabelBMFont:create(LineBreaksExample, "fonts/font-issue1343.fnt", size.width/1.5, cc.TEXT_ALIGNMENT_CENTER)
    pLable:setAnchorPoint(cc.p(0.5,0.5))
    local pLableSize = pLable:getContentSize()
    pLable:setPosition(childSize.width/2,childSize.height/2+50)
    --layer:addChild(pLable)
    child:addChild(pLable, 1)

	
	local function backMainScene(backScene)
        --local MainScene = require( "app/views/MainScene")
        --local scene = display.newScene(MainScene)
        --scene:addChild(self)
        --display.runScene(MainScene)
        --display.runScene(MainScene, TransitionJumpZoom, 1)
        -- local ret = MainScene:onCreate()
        -- ret:showWithScene()
        --ViewBase:showWithScene(MainScene)
       -- local ret = MainScene:onCreate()
       -- local scene = cc.Scene:create()
       -- scene:addChild(ret)
       local ret = SettingScene_onCreate()
        cc.Director:getInstance():replaceScene(ret) 
        
        --cc.Director:getInstance():replaceScene(ret) 
    end

    local menu = cc.Menu:create()
    menu:setPosition(cc.p(0, 0))
    cc.MenuItemFont:setFontName("Arial")
    cc.MenuItemFont:setFontSize(24)

    local backitem = cc.MenuItemFont:create("BackMainScene")
    backitem:registerScriptTapHandler(backMainScene)
    menu:addChild(backitem, 1) 
    backitem:setAnchorPoint(0.5,0.5)
    local backItemSize = backitem:getContentSize()
    backitem:setPosition(size.width/2,size.height/2-100)
    scene:addChild(menu,1)
    return scene
end