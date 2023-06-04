# simpleWindows
A simple window box inspired by snes and psx jrpg's for Love2d

It's fairly simple to set up and use. Just include the lua file-

require("simpleWindows.lua")

then use this function to build a window, using the graphic of your choice as the background. The graphic must be a multiple of 3. It can be any size, but it grabs imagesize/3 quads, and uses this to create the window. See the example iamges for ideas. These are made up of 9 8x8 grids. Three across, three down, each 8x8 pixels. As you can see there are corners and a center, etc. You can make the image 3 sets of 12x12, or 16x16 or whatever.

I know this probably sounds more complicated than it is, but it's very simple. Just look at the images to see what I mean.

 myWindow=createSimpleWindow("test", "windowExample1.png", 10, 10, 200, 45, 0.5)
 
 Test is the name of the window (you can name it whatever you want), windowExample1.png is the image, x=10, y=10, 200 pixels width, 45 pixels height. 0.5 is the window speed, this is medium speed. It's a number between 1 and 0. 1 being fastest, 0 being sludgy death metal slow.

 Next, you will call update in love's update-

 myWindow:update(dt)

 And then draw whenever you want to draw it-
 myWindow:draw()

 You can have multiple windows, windows that move about, etc. You can change the window graphic that it uses as well, any time, and the image can be different sizes than the one before.

 Other than that, check out the example in main.lua, and enjoy. When combined with something like SYSL-Text (which doesn't have a windowing system), this can be very powerful. Some updates in the future will include being able to make it look like a comic style box, as well as different sorts of animations.


-there are only a handful of functions you need. 
 local window=createSimpleWindow("test", "windowExample1.png", 10, 10, 200, 45, 0.5) returns a window to use
 window:update(dt) will update that window
 window:open() will open the window
 window:close() will close the window
 windor:draw() will draw the window
 window:isOpened() will check to see if it's opened
 window:isClosed() will check to see if it's closed
 window:changeGraphic() will change the image used as the background of the window
 that's it! Super simple stuff.