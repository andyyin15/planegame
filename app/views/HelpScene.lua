local  LineBreaksExample    = "Lorem ipsum dolor\nsit amet\nconsectetur\nadipisicing elit\nblah\nblah"
local size = cc.Director:getInstance():getWinSize()

-- local HelpScene = class("HelpScene", cc.load("mvc").ViewBase)

function HelpScene_onCreate()
    local scene = cc.Scene:create()
    --local layer = cc.Layer:create()
    local child = cc.Sprite:create("bg.png")
    child:setPosition(size.width/2,size.height/2)
    --layer:addChild(child)
    scene:addChild(child,1)
	local childSize = child:getContentSize()
    
    local pLable = cc.LabelBMFont:create(LineBreaksExample, "fonts/markerFelt.fnt", size.width/1.5, cc.TEXT_ALIGNMENT_LEFT)
    pLable:setAnchorPoint(cc.p(0,0))
    local pLableSize = pLable:getContentSize()
    pLable:setPosition(size.width/2-(size.width-childSize.width)/2+120,childSize.height-pLableSize.height)
    --layer:addChild(pLable)
    scene:addChild(pLable, 2)
    

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
    return scene
end


