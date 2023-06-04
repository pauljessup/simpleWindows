# simpleWindows
A simple window box inspired by snes and psx jrpg's for Love2d

It's fairly simple to set up and use. Just include the lua file-

require("simpleWindows.lua")

then use this function to build a window, using the graphic of your choice as the background. The graphic must be a multiple of 3. It can be any size, but it grabs imagesize/3 quads, and uses this to create the window. See the example iamges for ideas. These are made up of 9 8x8 grids. Three across, three down, each 8x8 pixels. As you can see there are corners and a center, etc. You can make the image 3 sets of 12x12, or 16x16 or whatever.

 myWindow=createSimpleWindow("test", "windowExample1.png", 10, 10, 200, 45)
 
 Test is the name of the window (you can name it whatever you want), windowExample1.png is the image, x=10, y=10, 200 pixels width, 45 pixels height.
 The example will be scaled by 3, since it's using SNES style pixel art.

 Next, you will call update in love's update-

 myWindow:update(dt)

 And then draw whenever you want to draw it-
 myWindow:draw()

 You can have multiple windows, windows that move about, etc. You can change the window graphic that it uses as well, any time, and the image can be different sizes than the one before.

 Other than that, check out the example in main.lua, and enjoy. When combined with something like SYSL-Text (which doesn't have a windowing system), this can be very powerful. Some updates in the future will include being able to make it look like a comic style box, as well as different sorts of animations.
