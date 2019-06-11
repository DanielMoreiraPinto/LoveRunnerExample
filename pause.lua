function pause_load()

end

function pause_update()

end

function pause_draw()
	love.graphics.print("GAME IS PAUSED!",0 ,0)
	love.graphics.print("Press [Enter] to Resume",0 ,20)
	love.graphics.print("Press [Escape] to Quit to Menu",0 ,40)
end