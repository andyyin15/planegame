
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("res1")
-- cc.FileUtils:getInstance():addSearchPath("res/app/views")
print(package.path.."11111111111111111111111111111")
package.path = "E:/mygame/TableView1/src/app/views/?.lua" ..";"..package.path
--package.path = "E:/mygame/TableView1/src/app" .. package.path
print(package.path)
--E:/mygame/TableView1/src/app/views



require "config"

require "cocos.init"


local function main()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
