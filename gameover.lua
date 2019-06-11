function gameover_load()

end

function gameover_update()

end

function gameover_draw()
	love.graphics.print('Game Over!', 0, 0)
	love.graphics.print('Your final score is: ' .. score, 0, 20)
	love.graphics.print('Press [R] to Restart.', 0, 40)
	love.graphics.print('Press [Escape] to Go Back to Menu', 0, 60)
end