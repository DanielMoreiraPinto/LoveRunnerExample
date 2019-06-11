require 'menu'
require 'ground'
require 'player'
require 'obstacle'
require 'score'
require 'gameover'
require 'pause'

function love.load()
	-- Sets the current gamestate to menu.
	gamestate = 'menu'
end

function love.update(dt)
	-- If the gamestate is menu, we reload all the assets.
	if gamestate == 'menu' then
		-- Loads all needed assets and variables.
		reload()
	end
	-- If the gamestate is game, we go to the game.
	if gamestate == 'game' then
		player_update(dt)
		obstacle_update(dt)
		score_update()
	end
	-- If the gamestate is pause, we go to the pause screen.
	if gamestate == 'pause' then
		pause_update()
	end
	-- If the gamestate is gameover, we go to the gameover screen.
	if gamestate == 'gameover' then
		gameover_update()
	end

end

function love.draw()
	-- If gamestate is menu, we go to the menu.
	if gamestate == 'menu' then
		love.graphics.setBackgroundColor(0, 0, 0)
		menu_draw()
	end
	-- If the gamestate is game, we go to the game.
	if gamestate == 'game' then
		love.graphics.setBackgroundColor(9, 36, 54)
		ground_draw()
		player_draw()
		obstacle_draw()
		score_draw()
	end
	-- If the gamestate is pause, we go to the pause screen.
	if gamestate == 'pause' then
		love.graphics.setBackgroundColor(0, 0, 0)
		pause_draw()
	end
	-- If the gamestate is gameover, we go to the gameover screen.
	if gamestate == 'gameover' then
		love.graphics.setBackgroundColor(0, 0, 0)
		gameover_draw()
	end
end

function love.keypressed(key)
	-- Controls for Menu State.
	if gamestate == 'menu' then
		-- For starting a new game.
		if key == 'return' then
			gamestate = 'game'
		end
		-- For quitting game.
		if key == 'escape'then
			love.event.quit()
		end
	-- Controls for Game State.
	elseif gamestate == 'game' then
		-- For jumping.
		if key == 'space' and player.isJumping == false then
			player.isJumping = true


			if player.y_velocity == 0 then
				player.y_velocity = player.jump_height
			end
		end
		-- For dashing.
		if player.canDash <= 0 then
			if key == 'z' and player.isJumping == true then
				player.canDash = player.maxCanDash
				player.isDashing = true
				player.y_velocity = 0
			end
		end
		-- For dash canceling.
		if player.isDashing == true and player.isJumping == true then
			if key == 'x' then
				player.isDashing = false
				player.isDashCanceling = true
				player.airTime = 0
			end
		end
		-- For pausing.
		if key == 'escape' then
			gamestate = 'pause'
		end
	-- Controls for Gameover State.
	elseif gamestate == 'gameover' then
		-- For restarting.
		if key == 'r' then
			gamestate = 'game'
			reload()
		end
		-- For quitting to menu.
		if key == 'escape' then
			gamestate = 'menu'
		end
	-- Controls for Pause State.
	elseif gamestate == 'pause' then
		-- For resuming game.
		if key == 'return' then
			gamestate = 'game'
		end
		-- For quitting to menu.
		if key == 'escape' then
			gamestate = 'menu'
		end
	end
end

function reload()
	menu_load()
	ground_load()
	player_load()
	obstacle_load()
	score_load()
	gameover_load()
	pause_load()
end