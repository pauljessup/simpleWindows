local function loadQuads(gw, gh, iw, ih)
    local quads={top={}, middle={}, bottom={}}
    local x,y=0,0
    for i,v in pairs(quads) do
        quads[i].left=love.graphics.newQuad(x, y, gw, gh, iw, ih)
        x=x+gw
        quads[i].center=love.graphics.newQuad(x, y, gw, gh, iw, ih)
        x=x+gw
        quads[i].right=love.graphics.newQuad(x, y, gw, gh, iw, ih)        
        y=y+gh
    end
end

function createSimpleWindow(name, image, x, y, w, h)
    local graphic=love.graphics.newImage(image)
    --get the graphic pieces/tiles for display and quads of the window
    local gw, gh=math.floor(graphic:getWidth()/3), math.floor(graphic:getHeight()/3)
    --the height here is the number of "tiles" to draw, so to speak. Same with width.
    --the window width/height divided image width/height for the window graphic /3 (to get the corners, etc)
    local ww, wh=math.floor(w/gw), math.floor(h/gh)
    return {
                name=name,
                graphic=graphic,
                imageName=image,
                quads=loadQuads(gw, gw, ww, wh),
                w=ww,
                h=wh,
                x=x,
                y=y,
                state="closed", --can be opening, closing, opened, closed.
                animating={isAnimating=false, position={w=0, h=0}, direction=1}, --direction is 1 or -1. -1 is closing, 1 is opening.
                open=function(self) end,
                close=function(self) end,
                isOpen=function(self) if self.state=="opened" then return true else return false end end,
                isClosed=function(self) if self.state=="closed" then return true else return false end end,
                isOpeing=function(self) if self.state=="opening" then return true else return false end end,
                isClosing=function(self) if self.state=="closing" then return true else return false end end,
                getAnimationSpeed=function(self) return self.animating.speed end,
                setAnimationSpeed=function(self, amt) self.animating.speed=amt end,
                animate=function(self, direction)
                    self.animating.isAnimating=true 
                    self.animating.position={w=0, h=0}
                    self.animating.direction=direction
                end,
                changeSize=function(self, w, h)
                    
                end,
                getWindowImage=function(self)
                    return {name=self.imageName, image=self.graphic}
                end,
                update=function(self, dt)
                    local anim=self.animating
                    if anim.isAnimating==true then
                        --TODO: add a cooldown here using dt so we can create variable speed open and close.
                        anim.w=anim.w+direction
                        anim.h=anim.h+dirctions
                        if anim.direction==1 then
                            if anim.w>self.w then anim.w=self.w end
                            if anim.h>self.h then anim.h=self.h end
                            if anim.h==self.h and anim.w==self.w then anim.isAnimating=false end
                        else
                            if anim.w<0 then anim.w=0 end
                            if anim.h<0 then anim.h=0 end
                            if anim.h==0 and anim.w==0 then anim.isAnimating=false end
                        end
                    end
                end,
                drawRow=function(self, row)
                    local anim=self.animating
                    love.graphics.draw(self.graphic, row.left, self.x, self.y)
                    for i=0, anim.w do
                        love.graphics.draw(self.graphic, row.center, self.x, self.y)
                    end
                    love.graphics.draw(self.graphic, row.right, self.x, self.y)
                end,
                draw=function(self)
                    local anim=self.animating
                    --draw the top.
                    self:drawRow(self.quads.top)
                    --draw the middle
                    for i=0, anim.h do
                        self:drawRow(self.quads.middle)
                    end                    
                    --draw the bottom.
                    self:drawRow(self.quads.bottom)
                end,
                changeGraphic=function(self, graphic)
                    local gw, gh=math.floor(graphic:getWidth()/3), math.floor(graphic:getHeight()/3)
                    self.graphic=love.graphics.newImage(graphic)
                    self.w, self.h=math.floor(w/gw), math.floor(h/gh)
                    self.quads=loadQuads(gw, gw, self.w, self.h)
                end,
    }
end