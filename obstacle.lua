function obstacle_load()
  skelPits = {}
  orbs = {}

  orb_image = love.graphics.newImage('assets/orb.png')
  orb_width = orb_image:getWidth()
  orb_height = orb_image:getHeight()

  skelPit_image = love.graphics.newImage('assets/skelpit.png')
  skelPit_width = skelPit_image:getWidth()
  skelPit_height = skelPit_image:getHeight()

  lastTimeSkelPit = 250
  lastTimeOrb = 350
end

function obstacle_update(dt)
  -- Generates skelPits.
	lastTimeSkelPit = lastTimeSkelPit - 1.5
	if lastTimeSkelPit <= 0 then
		-- Makes a random number between 40 - 175 to serve as the last time skelPit was generated.
		lastTimeSkelPit = love.math.random(60, 225)

 		-- Details of the newly created skelPit.
		newskelPit = { x = 800, y = 335 }
		table.insert(skelPits, newskelPit)
	end
	-- Moves skelPits.
	for i, skelPit in ipairs(skelPits) do
		skelPit.x = skelPit.x - 750 * dt
		-- skelPit off screen gets removed.
		if skelPit.x < 0 then
			table.remove(skelPit, i)
		end
	end

	-- Checks collision of skelPit and player.
	for i, skelPit in ipairs(skelPits) do
		if collisionObstacle(player.x, player.y, player.w, player.h, skelPit.x, skelPit.y, skelPit_image:getWidth(), skelPit_image:getHeight()) then
			gamestate = 'gameover'
		end
	end

  -- Generates orbs.
  lastTimeOrb = lastTimeOrb - 0.5
  if lastTimeOrb <= 0 then
    -- Makes a random number between 40 - 275 to serve as the last time orb was generated.
    lastTimeOrb = love.math.random(40, 175)

    -- Details of the newly created orb.
    newOrb = { x = 800, y = 155 }
    table.insert(orbs, newOrb)
  end

  -- Moves orbs.
  for i, orb in ipairs(orbs) do
    orb.x = orb.x - 1000 * dt
    -- orb off screen gets removed.
      if orb.x < 0 then
        table.remove(orb, i)
      end
    end

  -- Checks collision of orb and player.
  for i, orb in ipairs(orbs) do
      if collisionObstacle(player.x/1.25, player.y, player.w, player.h, orb.x, orb.y, orb_width, orb_height) then
        gamestate = 'gameover'
      end
  end

end

function obstacle_draw()
  -- Draws skelPits
  for i, skelPit in ipairs(skelPits) do
    love.graphics.draw(skelPit_image, newskelPit.x, newskelPit.y, 0, 1, sx)
  end
  -- Draws orbs
  for i, orb in ipairs(orbs) do
    love.graphics.draw(orb_image, newOrb.x, newOrb.y, 0, 1, sx)
	end
end

function collisionObstacle (x1,y1,w1,h1, x2,y2,w2,h2)
	return x1 < x2+w2 and
        x2 < x1+w1 and
        y1 < y2+h2 and
        y2 < y1+h1
end
