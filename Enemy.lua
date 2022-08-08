local love = require("love")

function Enemy(level)    --*Resumidamente o construtor
    local dice = 2--math.random(1,4)
    local _x, _y
    local _radius = 20
    
    

    --*Definindo as chances do inimigo surgir de cada lado

    --*Surge de cima da tela
    if dice == 1 then
        _x = math.random(0, love.graphics.getWidth())
        _y = - _radius * 4
        
    --*Da esquerda
    elseif dice == 2 then
        _x =  - _radius * 4
        _y =  math.random(0, love.graphics.getHeight())

    --*Da baixo
    elseif dice == 3 then 
        _x = math.random(0, love.graphics.getWidth())
        _y = love.graphics.getHeight() + (_radius * 4)

    --*Da direita 
    elseif dice == 4 then
        _x = love.graphics.getWidth() + (_radius * 4)
        _y = math.random(0, love.graphics.getWidth())

    end

    return {
        level = level or 1,
        radius = _radius,
        x = _x,
        y = _y,

        checkToutched = function (self, player_x, player_y, cursor_radius)
            return math.sqrt((self.x - player_x)^2 + (self.y - player_y)^2) <= cursor_radius * 2
        end,

        move = function (self, player_x, player_y)
            if player_x - self.x > 0 then
                self.x = self.x + self.level
                
            elseif player_x - self.x < 0 then
                self.x = self.x - self.level
            end            
        

            if player_y - self.y > 0 then
                self.y = self.y + self.level
                
            elseif player_y - self.y < 0 then
                self.y = self.y - self.level
            end            


        end,

        draw = function (self)
            love.graphics.setColor(1,0,0)
            love.graphics.circle("fill", self.x, self.y, self.radius)
        end

    }
end
return Enemy()