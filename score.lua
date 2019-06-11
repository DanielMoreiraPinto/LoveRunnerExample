function score_load()
	score = 0
end

function score_update()
	score = score + 1
end

function score_draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.print('Score: ' .. score, 700, 0)
end