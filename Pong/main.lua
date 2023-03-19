


Class = require 'class'
push = require 'push'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280 
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432 
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Pong')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)

    scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    --comment

    love.graphics.setDefaultFilter('nearest', 'nearest')

    smallFont = love.graphics.newFont('font.ttf', 8)

    scoreFont = love.graphics.newFont('font.ttf', 32)

    victoryFont = love.graphics.newFont('font.ttf', 24)

    sounds = {
        ['paddle_hit'] = love.audio.newSource('paddle_hit.wav', 'static'),
        ['point_scored'] = love.audio.newSource('point_scored.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('wall_hit.wav', 'static')
    }

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    player1Score = 0
    player2Score = 0

    servingPlayer = math.random(2) == 1 and 1 or 2

    winningPlayer = 0

    ball = Ball(VIRTUAL_WIDTH / 2-2, VIRTUAL_HEIGHT / 2-2, 4, 4)
    if servingPlayer == 1 then
        ball.dx = 100
    else
        ball.dx = -100
    end

    player1 = Paddle(10, 30, 5, 20 ) 
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    gameState = 'start' 

end

function love.resize(w, h)
    push:resize(w, h)
end



function love.update(dt)

    if gameState == 'play' then

        -- AI paddle2 follows ball.x
        player2.y = ball.y - 6              --MUST MAKE SMOOTH TRACKING!


        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            sounds['paddle_hit']:play()


            -- keep velocity in same direction
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4

            sounds['paddle_hit']:play()

            if ball.dy < 0 then --deflect ball down
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
    

        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy

            sounds['wall_hit']:play()

        end


        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy

            sounds['wall_hit']:play()

        end
    end

    if ball.x < 0 then
        servingPlayer = 1
        player2Score = player2Score + 1

        sounds['point_scored']:play()

        ball:reset()

        if player2Score >= 3 then     -- CHANGE THIS NUMBER TO SET CAP
            gameState = 'victory'
            winningPlayer = 2
        else
            gameState = 'serve'
        end
    end
    
    if ball.x > VIRTUAL_WIDTH then
        servingPlayer = 2
        player1Score = player1Score + 1

        sounds['point_scored']:play()

        ball:reset()

        if player1Score >= 3 then       --CHANGE THIS NUMBER TO SET CAP
            gameState = 'victory'
            winningPlayer = 1
        else
            gameState = 'serve'
        end
    end
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED 
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end
    player1:update(dt)
    player2:update(dt)

end

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()

    elseif key == 'enter' or key == 'return' or key == 'space' then
        if gameState == 'start' then
            gameState = 'serve'
            player1Score = 0
            player2Score = 0
        elseif gameState == 'victory' then
            gameState = 'start'
        elseif gameState == 'serve' then
            gameState = 'play'

        end
    end
end

function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')

    love.graphics.clear(40 / 255 ,45 / 255, 52 / 255, 255 / 255) -- rgba values (colors), and mapping till last equals 1 ig

    love.graphics.setFont(smallFont)

    displayScore()

    if gameState == 'start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf("Welcome to Pong!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter to Play!", 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf("Player ".. tostring(servingPlayer) .. "'s turn!", 
            0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter to Serve!", 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'victory' then
        --vic msg
        love.graphics.setFont(victoryFont)
        love.graphics.printf("Player ".. tostring(winningPlayer) .. " wins!", 
            0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf("Press Enter to Serve!", 0, 42, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        --no UI msg
    end

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)

    player1:render()
    player2:render()

    ball:render()
    
    displayFPS()
   
    push:apply('end')

end

function displayFPS()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(smallFont)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 40, 20)
    love.graphics.setColor(1,1,1,1)
end

function displayScore()

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)
end




