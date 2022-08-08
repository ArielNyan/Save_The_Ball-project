local love = require("love")

function Button(text, func, func_param, width, height)
    return{
        --*Definindo o botão
        width = width or 100,
        height = height or 100,
        func = func,
        func_param = func_param,
        text = text or "add a text",
        button_x = 0,
        button_y = 0,
        text_x = 0,
        text_y = 0,
        
        --*Definindo o comando para quando o botão for apertado
        checkPressed = function (self, mouse_x, mouse_y)
            if mouse_x >= self.button_x and mouse_x <= self.button_x + self.width then
                if mouse_y >= self.button_y and mouse_y <= self.button_y +self.height then
                    if self.func_param then
                        self.func(self.func_param)
                    else
                        self.func()
                    end
                end
                
            end
        end,
        
        --*Definindo como o botão será desenhado e como o texto será alinhado
        draw = function (self, button_x, button_y, text_x, text_y)
            self.button_x = button_x or self.button_x
            self.button_y = button_y or self.button_y
            
            if text_x then
                --*colocando o textX sempre dentro do botão
                text_x = text_x + button_x

            else
                text_x = button_x
            end
            
            if text_y then
                text_y = text_y + button_y

            else
                text_y = button_y
            end

            love.graphics.setColor(0.6, 0.6, 0.6)

            love.graphics.rectangle("fill", self.button_x, self.button_y, self.width, self.height)
            
            love.graphics.setColor(0,0,0)
            love.graphics.print(self.text, text_x, text_y)  --*Definindo como será desenhado o texto
            
            love.graphics.setColor(1,1,1)

        end,
    }
end
return Button()