function player_load()
	player = {}

	player.x = 80
	player.y = 229

	player.img = love.graphics.newImage('assets/player.png')

	player.w = player.img:getWidth()
	player.h = player.img:getHeight()

	player.ground = player.y

	player.y_velocity = 0

	player.jump_height = -325
	player.gravity = -1000

	player.maxCanDash = 5
	player.canDash = player.maxCanDash

	player.maxAirTime = 5
	player.airTime = player.maxAirTime

	player.isJumping = false
	player.isDashing = false
	player.isDashCanceling = false
end

function player_update(dt)
	-- Counts down. When 0 or less, player can now dash.
	player.canDash = player.canDash - dt

	-- If player is dashing, air time will count down. Gravity will apply after air time is 0.
	if player.isDashing == true then
		player.airTime = player.airTime - 2.5 * dt

		if player.airTime <= 0 then
			player.isDashing = false
			player.y_velocity = player.y_velocity - player.gravity * dt
			player.airTime = player.maxAirTime
		end
	end

	-- If player is canceling his dash, the timer for canDash will be set to 1.5.
	if player.isDashCanceling == true then
		player.canDash = 1.5 - dt
		player.isDashCanceling = false
	end

 	-- For falling while jumping.
	if player.y_velocity ~= 0 or player.airTime <= 0 then
		player.y = player.y + player.y_velocity * 2 * dt
		player.y_velocity = player.y_velocity - player.gravity * dt
	end

	-- When player is on the ground (again).x
	if player.y > player.ground then
		player.y_velocity = 0
    	player.y = player.ground
    	player.isJumping = false
    	player.airTime = player.maxAirTime
	end
end

function player_draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(player.img, player.x, player.y, 0, 1, sx)

	if player.canDash <= 0 then
		love.graphics.print("You can dash now.", 0, 0)
	else
		love.graphics.print("You cannot dash yet.", 0, 0)
	end

	love.graphics.print("Your Air Time: " .. player.airTime, 0, 18)
end