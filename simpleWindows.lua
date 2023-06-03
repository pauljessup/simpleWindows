local function loadQuads(gw, gh, iw, ih)
    local quads={}
    local x,y=0,0
    for i=1, 3 do
        quads[i]={}
        x=0
        quads[i].left=love.graphics.newQuad(x, y, gw, gh, iw, ih)
        x=x+gw
        quads[i].center=love.graphics.newQuad(x, y, gw, gh, iw, ih)
        x=x+gw
        quads[i].right=love.graphics.newQuad(x, y, gw, gh, iw, ih)        
        y=y+gh
    end
    return quads
end

function createSimpleWindow(name, image, x, y, w, h)
    local graphic=love.graphics.newImage(image)
    --get the graphic pieces/tiles for display and quads of the window
    local gw, gh=math.floor(graphic:getWidth()/3), math.floor(graphic:getHeight()/3)
    --the height here is the number of "tiles" to draw, so to speak. Same with width.
    --the window width/height divided image width/height for the window graphic /3 (to get the corners, etc)
    local ww, wh=math.floor(w/gw), math.floor(h/gh)
    return {
                fade=0.0,
                name=name,
                graphic=graphic,
                imageName=image,
                quads=loadQuads(gw, gw, graphic:getWidth(), graphic:getHeight()),
                tileSize={w=gw, h=gh},
                middle={w=math.floor(w/2), h=math.floor(h/2)},  --get the center of the window
                w=ww,
                h=wh,
                x=x,
                y=y,
                state="closed", --can be opening, closing, opened, closed.
                animating={isAnimating=false, w=0, h=0, direction=1}, --direction is 1 or -1. -1 is closing, 1 is opening.
                open=function(self) 
                    self.state="opening"
                    self:animate(1)
                end,
                close=function(self) 
                    self.state="closing"
                    self:animate(-1)
                end,
                isOpen=function(self) if self.state=="open" then return true else return false end end,
                isClosed=function(self) if self.state=="closed" then return true else return false end end,
                isOpening=function(self) if self.state=="opening" then return true else return false end end,
                isClosing=function(self) if self.state=="closing" then return true else return false end end,
                getAnimationSpeed=function(self) return self.animating.speed end,
                setAnimationSpeed=function(self, amt) self.animating.speed=amt end,
                animate=function(self, direction)
                    self.fade=1.0
                    self.animating.isAnimating=true 
                    self.animating.position={w=0, h=0}
                    self.animating.direction=direction
                end,
                getWindowImage=function(self)
                    return {name=self.imageName, image=self.graphic}
                end,
                update=function(self, dt)
                    local anim=self.animating
                    if anim.isAnimating==true then
                        --TODO: add a cooldown here using dt so we can create variable speed open and close.
                        self.fade=self.fade-0.04
                        if self.fade<0.0 then self.fade=0.0 end

                        anim.w=anim.w+anim.direction
                        anim.h=anim.h+anim.direction
                        if anim.direction==1 then
                            if anim.w>self.w then anim.w=self.w end
                            if anim.h>self.h then anim.h=self.h end
                            if anim.h==self.h and anim.w==self.w then
                                anim.isAnimating=false 
                                if self:isOpening() then self.state="open" end
                            end
                        else
                            if anim.w<0 then anim.w=0 end
                            if anim.h<0 then anim.h=0 end
                            if anim.h==0 and anim.w==0 then 
                                if self:isClosing() then self.state="closed" end
                                anim.isAnimating=false 
                            end
                        end
                    end
                end,
                drawRow=function(self, row, ypos)
                    local anim=self.animating
                    local xAt=self.x+((self.middle.w)-((anim.w*(self.tileSize.w/2)))) --calculate from center back, based on animation at.
                    local yAt=self.y+((self.middle.h)-((anim.h*(self.tileSize.h/2)))) --do the same for height
                    love.graphics.draw(self.graphic, row.left, xAt, yAt+ypos)
                    local xpos=0
                    for i=0, anim.w-1 do
                        xpos=xpos+self.tileSize.w
                        love.graphics.draw(self.graphic, row.center, xAt+xpos, yAt+ypos)
                    end
                    xpos=xpos+self.tileSize.w
                    love.graphics.draw(self.graphic, row.right, xAt+xpos, yAt+ypos)
                end,
                draw=function(self)
                    local col={}
                    if self:isClosed() then return false end
                    if self.animating.isAnimating then
                        col[1], col[2], col[3], col[4]=love.graphics.getColor()
                        local fade=self.fade
                        if self.animating.direction==1 then fade=1.0-self.fade end
                        love.graphics.setColor(col[1], col[2], col[3], fade)
                    end
                    local ypos=0
                    local anim=self.animating
                    --draw the top.
                    for i,v in ipairs(self.quads) do
                             --draw the middle
                            if i==2 then
                                for i=0, anim.h do
                                    ypos=ypos+self.tileSize.h
                                    self:drawRow(v, ypos)
                                end                    
                            --draw the bottom.
                            ypos=ypos+self.tileSize.h
                            else 
                                self:drawRow(v, ypos)
                            end
                    end
                    if self.animating.isAnimating then
                        love.graphics.setColor(col[1], col[2], col[3], col[4])
                    end
                end,
                changeGraphic=function(self, graphic)
                    self.graphic=love.graphics.newImage(graphic)
                end,
    }
end