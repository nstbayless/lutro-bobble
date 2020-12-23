local inter = {}
inter.__index = inter

function newInter(n)
	n.type = "inter"
	n.t = 100
	return setmetatable(n, inter)
end

function inter:update(dt)
	if self.t > 0 then
		self.t = self.t - 1
		if self.t == 1 then
			ENTITIES = {}
			SOLIDS = {}
			EFFECTS = {}
			SHADOWS = {}
			MAP = {}
			PHASE = "game"

			load_map(STAGES[STAGE])

			if CHAR1.dead then
				table.insert(ENTITIES, newGhost({x=1*16,y=13*16,pad=1,direction="right"}))
			else
				CHAR1 = newCharacter({x=1*16,y=13*16,pad=1,direction="right"})
				table.insert(ENTITIES, CHAR1)
			end
			if CHAR2.dead then
				table.insert(ENTITIES, newGhost({x=18*16,y=13*16,pad=2,direction="left"}))
			else
				CHAR2 = newCharacter({x=18*16,y=13*16,pad=2,direction="left"})
				table.insert(ENTITIES, CHAR2)
			end
			-- table.insert(ENTITIES, newCharacter({x=3*16,y=7*16,pad=3}))

			love.audio.play(BGM_bgm)
		end
	end
end

function inter:draw()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	love.graphics.setFont(FNT_letters)
	local w = FNT_letters:getWidth("STAGE "..STAGE.."! READY ?")
	lutro.graphics.print("STAGE "..STAGE.."! READY?", SCREEN_WIDTH/2 - w/2, SCREEN_HEIGHT/2 - 16/2)
end

function inter:serialize()
	return {
		type = self.type,
		t = self.t,
	}
end

function inter:unserialize(n)
	self.type = n.type
	self.t = n.t
end
