function ground_load()
	ground_image = love.graphics.newImage('assets/ground.png')
end

function ground_draw()
	love.graphics.draw(ground_image, 0, 336, 0, 1, sx)
end