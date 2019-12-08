
local    kTagNode = 0
local    kTagGrossini = 1
local    kTagSequence = 2
local    scheduler = cc.Director:getInstance():getScheduler()
--local    s = cc.Director:getInstance():getWinSize()
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
local    size = cc.Director:getInstance():getWinSize()
local    pointnumber = 0

function StartScene_onCreate()
    local scene = cc.Scene:create()
    --local layer = cc.Layer:create()
    local child = cc.Sprite:create("bg.png")
    local childSize = child:getContentSize()
    child:setPosition(size.width/2,size.height/2)
    childSizeX = childSize.width

    local point = ccui.Text:create("得分:","fonts/bitmapFontChinese.fnt",24)
    point:setColor(cc.c3b(255, 0, 0))
    point:setPosition(childSize.width-50,childSize.height-20)
    child:addChild(point,1,1000000)

   
    scene:addChild(child)
    local bulletPosX = size.width/2
    local bulletPosY = 25
    local removeMyPlane
    local removeRectEnemy
    local removeRectBullet
    local myPlane_Location
    local point_num
    

    local function removeBullet()

        for i=1,#bulletArray do
            if bulletArray[i]:getContentSize().height > size.height then
                table.remove(bulletArray,i)
            
            end  
        end
    end

    local function addBullet()
            local i = 2
            i = i+1
           local bullet = cc.Sprite:create("components/Projectile.png", cc.rect(0, 0, 20, 20))
            bullet:setAnchorPoint(0.5,0.5)
            scene:addChild(bullet,i)
            --removeRectBullet = bullet
            bullet:setPosition(bulletPosX,25)

            local length = size.height + bullet:getContentSize().height / 2 - 25
            local velocity = 250 --飞行速度
            local moveTime = length/velocity
            local actionMove = CCMoveTo:create(moveTime,cc.p(bulletPosX,size.height  + bullet:getContentSize().height / 2))

            local actionDone = CCCallFuncN:create(removeBullet)
            local sequence = cc.Sequence:create(actionMove,actionDone)
            bullet:runAction(sequence)
            table.insert(bulletArray,bullet)
        
    end

    local function removeEnemy()
        for i=1,#enemyArray do
            if enemyArray[i]:getContentSize().height < -40 then
                table.remove(enemyArray,i)
            end  
        end
    end

    local function addEnemy()
        local i = 2
        i = i+1
        local enemy = cc.Sprite:create("components/Target.png")
        enemy:setAnchorPoint(0.5,0.5)
        scene:addChild(enemy,i)
        --removeRectEnemy = enemy

        local enemyPosX = math.random(293,293+childSizeX)
        enemy:setPosition(enemyPosX,size.height+50)

       	local length = size.height + enemy:getContentSize().height / 2 - 50
        local velocity = 50 --飞行速度
        local moveTime = length/velocity
        local actionMove = CCMoveTo:create(moveTime,cc.p(enemyPosX,-50))
        local actionDone = CCCallFuncN:create(removeEnemy)
        local sequence = cc.Sequence:create(actionMove,actionDone)
        enemy:runAction(sequence)
        table.insert(enemyArray,enemy)

    end

    local function updateEnemy()
            local collins = false
            local z= 0
            for i = #enemyArray,1,-1 do
                local enemy = enemyArray[i]
                local rectEnemy = enemyArray[i]:getBoundingBox()
            
                if collins == false then
                    local j
                    for j = #bulletArray,1,-1 do
                        local bullet = bulletArray[j] 
                        local ptBullet = cc.p( bullet:getPosition() )
                        if cc.rectContainsPoint(rectEnemy, ptBullet) then
                            bullet:removeFromParent()
                            table.remove(bulletArray, j)
                            enemy:setVisible(false)
                            --scene:stopAction(enemy)
                            --enemy:removeFromParent()
                            --z = z+1
                            pointnumber = pointnumber+1
                            --print(pointnumber)
                            --print(z)
                            point_num = ccui.Text:create(pointnumber,"fonts/enligsh-chinese.fnt",24)
                            point_num:setColor(cc.c3b(255, 0, 0))
                            point_num:setPosition(childSize.width-25,childSize.height-20)
                            child:addChild(point_num,1,pointnumber)
                            child:getChildByTag(pointnumber-1):removeFromParent()
                        end

                    end
                end

                if cc.rectContainsPoint(rectEnemy, myPlane_Location) then
            		local ret = GameOver_onCreate()
                	cc.Director:getInstance():replaceScene(ret)
            	end
            end

	end
    
    
    
    local function onNodeEvent(event)
        if event == "enter" then
            
            schedulerEntry = scheduler:scheduleScriptFunc(addBullet, 0.3, false)
            schedulerEnemyEntry = scheduler:scheduleScriptFunc(addEnemy, 1, false)
            schedulerRemoveEnemyEntry = scheduler:scheduleScriptFunc(updateEnemy, 0.3, false)

        elseif event == "exit" then
            if schedulerEntry ~= nil  then
                scheduler:unscheduleScriptEntry(schedulerEntry)
                scheduler:unscheduleScriptEntry(schedulerEnemyEntry)
                scheduler:unscheduleScriptEntry(schedulerRemoveEnemyEntry)
            end
        end
    end
    scene:registerScriptHandler(onNodeEvent)

    local myPlane = cc.Sprite:create("components/Player.png", cc.rect(0, 0, 27, 40))
    myPlane:setAnchorPoint(0.5,0.5)
    myPlane:setPosition(cc.p(size.width/2,25))
    myPlane:setTag(15)
    scene:addChild(myPlane,2,myPlane_tag)


    local function onTouchBegan(touch, event)
        local location = touch:getLocation()

        if location.x > 293 and location.x < 293+childSizeX  then
            bulletPosX =location.x
        else
            --bulletPosX = s.width/2
        end
        return true
    end

    local function onTouchEnded(touch, event)
        local location = touch:getLocation()
        myPlane_Location = location
        --print(location.x,location.y)

        local s = scene:getChildByTag(myPlane_tag)

        myPlaneLocation = location
        if location.x > 293 and location.x < 293+childSizeX and location.y <50 then
            s:runAction(cc.MoveTo:create(0.2, cc.p(location.x, 25)))
            --myPlane_LocationX,myPlane_LocationY =location.x,25
        elseif location.x < 293 and location.y <50 then
            s:runAction(cc.MoveTo:create(0.2, cc.p(293, 25)))
            --myPlane_LocationX,myPlane_LocationY =location.x,25
        elseif location.x > 293+childSizeX and location.y <50 then
            s:runAction(cc.MoveTo:create(0.2, cc.p(293+childSizeX, 25)))
            --myPlane_LocationX,myPlane_LocationY =location.x,25
        elseif location.x > 293+childSizeX then
            s:runAction(cc.MoveTo:create(0.2, cc.p(293+childSizeX, 25)))
            --myPlane_LocationX,myPlane_LocationY =location.x,25
        elseif location.x < 293  then
        	s:runAction(cc.MoveTo:create(0.2, cc.p(293, 25)))
        	--myPlane_LocationX,myPlane_LocationY =location.x,25
        else
            s:runAction(cc.MoveTo:create(0.2, cc.p(293+childSizeX/2, 25)))
            --myPlane_LocationX,myPlane_LocationY =location.x,25
        end

        
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = child:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, child)


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
