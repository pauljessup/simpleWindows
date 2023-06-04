--all you need to do is require it, wherever you placed it.
require("simpleWindows")
love.graphics.setDefaultFilter("nearest","nearest")


function love.load() 
    --we're doing this global just for this example.
    --it's a basic factory class that creates and returns a table with the window stuff.
    --the args- name, image, x, y, w, h ..name is whatever you want to name it, image is the image you'll use for the background
    --(an image that is divisible by 3 in both h and width, it can be of any size, but works best when divisible by 3. Look at examples included)
    --x y is the location, w and h is the w and h of the window itself in pixels. The last number is speed, it's beween 0 and 1. 1 being fasest, 0.5 being medium.
    --if speed is not passed, it defaults to meduim speed.
    myWindow=createSimpleWindow("test", "windowExample1.png", 10, 10, 200, 45, 0.8)
    coolDown=0.0 --for the keyboard, so it doesn't change a billion times.
    window=1
    backgroundImage=love.graphics.newImage("Example3_0.png")
end

function love.update(dt)
    myWindow:update(dt)
    if love.keyboard.isDown("space") and coolDown<=0.0 then
        coolDown=1.0
        window=window+1
        myWindow:changeGraphic("windowExample" .. window ..".png")
        if window==3 then window=0 end
    end
    if love.keyboard.isDown("escape") then 
        if myWindow:isOpen()==true then
            myWindow:close()
        elseif myWindow:isClosed()==true then
            myWindow:open()
        end
    end
    if coolDown>0.0 then coolDown=coolDown-0.1 else coolDown=0.0 end
end

function love.draw()
    love.graphics.scale(3, 3)
    love.graphics.draw(backgroundImage)
    myWindow:draw()
    if myWindow:isOpen()==true then
        love.graphics.print("Press space to change window", 24, 24)
        love.graphics.print("Press esc to close window", 24, 44)
    end
    if myWindow:isClosed()==true then
        love.graphics.print("Press esc to open window", 24, 44)
    end

    love.graphics.print("Background art by Ivan Voirol")
end