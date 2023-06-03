--all you need to do is require it, wherever you placed it.
require("simpleWindows")


function love.load() 
    --we're doing this global just for this example.
    --it's a basic factory class that creates and returns a table with the window stuff.
    --the args- name, image, x, y, w, h ..name is whatever you want to name it, image is the image you'll use for the background
    --(an image that is divisible by 3 in both h and width, it can be of any size, but works best when divisible by 3. Look at examples included)
    --x y is the location, w and h is the w and h of the window itself in pixels.
    myWindow=createSimpleWindow("test", "windowExample1.png", 10, 10, 100, 50)
end

function love.update(dt)
    myWindow:update(dt)
end

function love.draw()
    myWindow:draw()
end