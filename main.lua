--*Basicamente esse é um projeto para criar um jogo onde o jogador controla o mouse e precisa evitar que bolas que vçao na direção dele
--* Encostem no mouse

local love = require("love")
local enemy = require("Enemy")
local menu_button = require("Button")

math.randomseed(os.time())


local game = {
    dificulty = 1,
    state =  "menu",
    points = 0,
    levels = {15, 30, 60, 120}
}

local player = {
    radius = 20,
    x = 30,
    y = 30
}

local buttons = {
    menu_states = {}
}

local enemies = {}

local function changeGameState(state)
    game.state = state
end

local function NewGame()
    changeGameState("running")
    game.points = 0

    enemies = {
        Enemy(1)
    }
end


function love.load()
    
    buttons.menu_states.play_game = Button("Play Game", NewGame, nil, 120, 40)
    buttons.menu_states.exit_game = Button("Exit", love.event.quit, nil, 120, 40)
    




        love.mouse.setVisible(false)
 
end

function love.mousepressed(x, y, button, istouch, presses)
   -- if not game.state == "running" then
        if game.state == "menu" then
            if button == 1 then
                for index in pairs(buttons.menu_states) do
                    buttons.menu_states[index]:checkPressed(x, y)
                end
            end
        --end
    end
 end

function love.update(dt)
    if game.state == "running" then
        for i = 1, #enemies do

            if not enemies[i]:checkToutched(player.x, player.y, player.radius) then
                enemies[i]:move(player.x, player.y)

                for g = 1, #game.levels do
                    if math.floor(game.points) == game.levels[g] then
                        table.insert(enemies, 1, Enemy(game.dificulty * (g + 1)))

                        game.points = game.points + 1
                    end
                end                
            else
                changeGameState("menu")
            end
            
        end
        game.points = game.points + dt
    end


end

function love.draw()

    player.x, player.y = love.mouse.getPosition()   --*Guandando o x e o y do mouse nas variáveis de nome bem criativo

    --*Definindo os diferentes estados do jogo

    if game.state == "running" then 
        love.graphics.setColor(1,1,1)
        love.graphics.printf(math.floor(game.points), love.graphics.newFont(16), 0, 10, love.graphics.getWidth(), "center")

        love.graphics.setColor(1,1,1)
        love.graphics.circle("fill", player.x, player.y, 20)

        for i = 1, #enemies do
            enemies[i]:draw()
        end

     elseif game.state == "menu" then
        buttons.menu_states.play_game:draw(10, 20, 17, 10)
        buttons.menu_states.exit_game:draw(200, 20, 17, 10)
     end

     if game.state == "menu" then
         love.graphics.circle("fill", player.x, player.y, 10)
     end
     
     if game.state == "game_over" then
         love.graphics.circle("fill", player.x, player.y, 10)
     end
end
