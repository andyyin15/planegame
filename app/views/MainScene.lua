--require "HelpScene"
-- --require "MainScene"
-- require "SettingScene"
-- require "StartScene"
-- require "testResourse"
-- require "GameOver"


MainScene = class("MainScene", cc.load("mvc").ViewBase)
local size = cc.Director:getInstance():getWinSize()

local    kTagNode = 0
local    kTagGrossini = 1
local    kTagSequence = 2
local    scheduler = cc.Director:getInstance():getScheduler()
--local    size = cc.Director:getInstance():getWinSize()
local    start_tag = 10
local    setting_tag = 11
local    help_tag = 12
local    sceneFlag = -1
local  LineBreaksExample    = "Lorem ipsum dolor\nsit amet\nconsectetur\nadipisicing elit\nblah\nblah"
local    isplaying_tag = 1000
local    MUSIC_FILE = "background-music-aac.mp3"
local    myPlane_tag = 15
local    child_tag = 16
local    schedulerEntry = nil
local    schedulerEnemyEntry = nil
local    schedulerRemoveEnemyEntry = nil
local    bullet_tag = 10
local    bulletArray = {}
local    enemyArray = {}
local    grossarr = {}

scene_scene = nil


function MainScene:onCreate()
    local scene = cc.Scene:create()
   	AudioEngine.playMusic(MUSIC_FILE, true)
    local  child = cc.Sprite:create(s_bg)
    child:setPosition(size.width/2,size.height/2)
    scene:addChild(child, 1)
    local fileUtils = cc.FileUtils:getInstance()
    --print(fileUtils:addSearchPath("res1"))
    print(fileUtils:getSearchPaths())
    print("111111111111111111111111111111111111111111111111111111111")
    

    local function startCallBack(tag,menuItemSender)

            --sceneFlag =menuItemSender:getTag()
            if tag == start_tag then
                local ret = StartScene_onCreate()
                cc.Director:getInstance():pushScene(ret)
            elseif tag == setting_tag then
                local ret = SettingScene_onCreate()
                cc.Director:getInstance():pushScene(ret)
            elseif tag == help_tag then
                local ret = HelpScene_onCreate()
                cc.Director:getInstance():pushScene(ret)
            else
                print("xixixi")
            end
           
    end

    local menu = cc.Menu:create()
    --menu:setPosition(cc.p(0, 0))
    cc.MenuItemFont:setFontName("Arial")
    cc.MenuItemFont:setFontSize(24)

    local startgame = cc.MenuItemFont:create("START")
    startgame:setTag(start_tag)
    startgame:registerScriptTapHandler(startCallBack)
    --startgame:setPosition(size.width/2+100, size.height/2)
    menu:addChild(startgame, 1)

    local settingitem = cc.MenuItemFont:create("SETTING")
    settingitem:setTag(setting_tag)
    settingitem:registerScriptTapHandler(startCallBack)
    --item:setPosition(s.width/2+100, s.height/2)
    menu:addChild(settingitem, 2)

    local helpitem = cc.MenuItemFont:create("HELP")
    helpitem:setTag(help_tag)
    helpitem:registerScriptTapHandler(startCallBack)
    --item:setPosition(s.width/2+100, s.height/2)
    menu:addChild(helpitem, 3)
    menu:alignItemsVertically()
    menu:setAnchorPoint(0.5,0.5)
    menu:setPosition(size.width/2,size.height/2)
    scene:addChild(menu,2)
    print(type(self))
    self:addChild(scene)

    scene_scene = scene
    return scene
end


return MainScene


