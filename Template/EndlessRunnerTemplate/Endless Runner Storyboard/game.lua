-------------------------------------------------------------------------
--T and G Apps Ltd.
--Created by Jamie Trinder
--www.tandgapps.co.uk

--CoronaSDK version 2012.935 was used for this template.

--The art was sourced from http://biffybeebe.net/graphics/
--Created by Biffy Beebe, you would have to purchase the indie Graphics bundle
--yourself in order to use the graphics in this template in your own game.

--You are not allowed to publish this template to the Appstore as it is. 
--You need to work on it, improve it and replace the graphics. 

--For questions and/or bugs found, please contact me using our contact
--form on http://www.tandgapps.co.uk/contact-us/
-------------------------------------------------------------------------


--Start off by requiring storyboard and creating a scene.
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

--Require physics
local physics = require("physics")	
physics.start(); physics.setGravity( 0, 20 ) --Start physics
--physics.setDrawMode( "hybrid" )

--We also require the section definitions.
--These controls positions etc of the Stars and platforms.
local sections = require("sectionData")

--Maths
local _W = display.contentWidth
local _H = display.contentHeight
local mR = math.random
local mF = math.floor

--Groups
local mainGroup, firstGroup, objectGroup, extraGroup

--Sounds
local starSound, overSound, jumpSound
local starChannel, jumpChannel, overChannel  --Channel vars, used to play sounds

--Game Vars
--All of these need to be reset when you click restart.
local singleJump, doubleJump = false, false --limits our jumping
local menuShown, gameOverCalled = false, false --Just incase an extra game over call is made.
local distChange, distChange2 = 0, 0 --Controls spawning etc of sections. In the gameloop.
local gameIsActive = false  --Set to true to start scrolling etc.
local distance, score = 0, 0
local levelSpeed = 8 --Increase to go faster.

--Images...
local bg1, bg2, ground1, ground2, extra1, extra2
local hudBar, distanceText, scoreText

--Functions Pre-declared
--This is done so runtime listeners can be easily removed/added 
--Also they need to be called from different sections.
local gameLoop, onCollision, playerJump, createGame, createSection 

--Player only vars.
local player
local playerSheet, playerSprite --Localised so we can remove the imageSheet etc.




-----------------------------------------------
-- *** STORYBOARD SCENE EVENT FUNCTIONS ***
------------------------------------------------
-- Called when the scene's view does not exist:
-- Create all your display objects here.
function scene:createScene( event )
	print( "GAME: createScene event")
	local screenGroup = self.view

	--Create the groups and insert them into the view...
	firstGroup = display.newGroup()
	objectGroup = display.newGroup()
	extraGroup = display.newGroup()
	screenGroup:insert(firstGroup)
	screenGroup:insert(objectGroup)
	screenGroup:insert(extraGroup) 

	--Load the sounds.
	starSound = audio.loadSound("sounds/Collect.mp3")  
	overSound = audio.loadSound("sounds/Defeat2.mp3")
	jumpSound = audio.loadSound("sounds/Jump.mp3")


	--------------------------------------------
	-- ***HUD SETUP***
	-- Creates the HUD Bar, Score/Distance Text
	--------------------------------------------
	hudBar = display.newImageRect(extraGroup, "images/clearheader.png", 480,36)
	hudBar.x = _W*0.5; hudBar.y = 14; hudBar.alpha = 0.5

	distanceText = display.newText(extraGroup, "Distance: "..distance,0,0,"Arial",17)
	distanceText.anchorX = 1
	distanceText.anchorY = 0.5
	--distanceText:setReferencePoint(display.CenterRightReferencePoint); 
	distanceText:setFillColor(50/255)
	distanceText.x = _W-6; distanceText.y = 14

	scoreText = display.newText(extraGroup, "Score: "..score,0,0,"Arial",17)
	scoreText.anchorX = 0
	scoreText.anchorY = 0.5
	--scoreText:setReferencePoint(display.CenterLeftReferencePoint); 
	scoreText:setFillColor(50/255)
	scoreText.x = 6; scoreText.y = 14


	--------------------------------------------
	-- ***CREATE GAME FUNCTION.***
	--Create the scenery and the player/function
	--------------------------------------------
	function playerJump( event )
		if event.phase == "ended" then
			if doubleJump == false then 
				player:setLinearVelocity( 0, 0 )
				player:applyForce(0,-11, player.x, player.y)
				player:setSequence("jump")
				jumpChannel = audio.play(jumpSound)
			end

			if singleJump == false then singleJump = true 
			else doubleJump = true end
		end
		return true
	end

	--Create Section function.. Create platforms and stars etc
	--Using the required file at the top of the bank to randomly choose a section
	local lastSection = 0
	function createSection()
		--Create a random number. If its eqaul to the last one, random it again.
		local sectInt = mR(1,#sections)
		if sectInt == lastSection then sectInt = mR(1,#sections) end
		lastSection = sectInt

		--Get a random section from the sectionData file and then
		--Loop through creating everything with the right properties.
		local i
		for i=1, #sections[sectInt]["platforms"] do
			local object = sections[sectInt]["platforms"][i]
			local platform = display.newImageRect(objectGroup, "images/platform"..object["type"]..".png", object["widthHeight"][1], object["widthHeight"][2])
			platform.anchorX = 0.5
			platform.anchorY = 0
			--platform:setReferencePoint(display.TopCenterReferencePoint)
			platform.x = object["position"][1]+(480*object["screen"]); platform.y = object["position"][2]; platform.name = "platform"

			local rad = (platform.width*0.5)-2; local height = (platform.height*0.5)-4
			local physicsShape = { -rad, -height, rad, -height, rad, platform.height*0.5, -rad, platform.height*0.5 }
			physics.addBody( platform,  "static", { friction=0.1, bounce=0, shape=physicsShape} );
		end
		for i=1, #sections[sectInt]["stars"] do
			local object = sections[sectInt]["stars"][i]
			local star = display.newImageRect(objectGroup, "images/star.png", 30, 30)
			star.x = object["position"][1]+(480*object["screen"]); star.y = object["position"][2]; star.name = "star"
			physics.addBody( star, "static", { isSensor = true } )
		end
		for i=1, #sections[sectInt]["vines"] do
			local object = sections[sectInt]["vines"][i]
			local vine = display.newImageRect(objectGroup, "images/vine"..object["type"]..".png", object["widthHeight"][1], object["widthHeight"][2])
			vine.x = object["position"][1]+(480*object["screen"]); vine.y = object["position"][2]; vine.name = "vine"

			local rad = (vine.width*0.5)-8; local height = (vine.height*0.5)-8
			local physicsShape = { -rad, -height, rad, -height, rad, height, -rad, height }
			physics.addBody( vine, "static", { isSensor = true, shape = physicsShape } )
		end
	end

	--CreateGame makes all the backgrounds etc.
	--This is also called when we reset the game.
	function createGame()
		--If the game has just been reset we need to remake/delete all the below
		local i 
		for i=objectGroup.numChildren,1,-1 do
			local object = objectGroup[i]
			if object ~= nil then
				display.remove(objectGroup[i])
				objectGroup[i] = nil; 
			end
		end
		
		--display.remove(objectGroup);
		if player then display.remove(player); player = nil; playerSheet = nil; end
		if bg1 then display.remove(bg1); bg1 = nil; end
		if bg2 then display.remove(bg2); bg2 = nil; end
		if extra1 then display.remove(extra1); extra1 = nil; end
		if extra2 then display.remove(extra2); extra2 = nil; end
		if ground1 then display.remove(ground1); ground1 = nil; end
		if ground2 then display.remove(ground2); ground2 = nil; end
		

		--Background and grass and extras
		bg1 = display.newImageRect(firstGroup, "images/bg1.jpg", 480, 320)
		bg1.anchorX = 0.5
		bg1.anchorY = 0
		--bg1:setReferencePoint(display.TopCenterReferencePoint); 
		bg1.x = 240; bg1.y = 0
		bg2 = display.newImageRect(firstGroup, "images/bg2.jpg", 480, 320)
		bg2.anchorX = 0.5
		bg2.anchorY = 0
		--bg2:setReferencePoint(display.TopCenterReferencePoint); 
		bg2.x = 720; bg2.y = 0

		extra1 = display.newImageRect(firstGroup, "images/extra.png", 480, 90)
		extra1.anchorX = 0.5
		extra1.anchorY = 1
		--extra1:setReferencePoint(display.BottomCenterReferencePoint)
		extra1.x = 240; extra1.y = _H-40
		extra2 = display.newImageRect(firstGroup, "images/extra2.png", 480, 90)
		extra2.anchorX = 0.5
		extra2.anchorY = 1
		--extra2:setReferencePoint(display.BottomCenterReferencePoint)
		extra2.x = 720; extra2.y = _H-40

		local physicsShape = { -240, -20, 240, -20, 240, 22, -240, 22 }
		ground1 = display.newImageRect(extraGroup, "images/grass.png", 480, 45)
		ground1.x = 240; ground1.y = _H-22; ground1.name = "floor"
		physics.addBody( ground1,  "static", { friction=0.1, bounce=0, shape=physicsShape} )
		ground2 = display.newImageRect(extraGroup, "images/grass.png", 480, 45)
		ground2.x = 720; ground2.y = _H-22; ground2.name = "floor"
		physics.addBody( ground2,  "static", { friction=0.1, bounce=0, shape=physicsShape} )

		
		----------
		--Now create the player sprite!
		--We also add a Pre collision function so we can go through platforms.
		--------
		local options = 
		{
			width = 45, height = 62,
			numFrames = 4,
			sheetContentWidth = 180,
			sheetContentHeight = 62
		}
		playerSheet = graphics.newImageSheet( "images/playerSprite.png", options)
		playerSprite = { 
			{name="run", start=1, count=3, time = 400, loopCount = 0 },
			{name="jump", start=4, count=1, time = 1000, loopCount = 1 },
		}

		player = display.newSprite(playerSheet, playerSprite)
		player.anchorX = 0.5
		player.anchorY = 1
		--player:setReferencePoint(display.BottomCenterReferencePoint)
		player.x = 64; player.y = _H*0.6; player.name = "player";
		extraGroup:insert(player); player:play()

		physics.addBody( player,  "dynamic", { friction=0, bounce=0} )	
		player.isFixedRotation = true 	--To stop it rotating when jumping etc
		player.isSleepingAllowed = false --To force it to update and fall off playforms correctly.


		--Now pre-collision function.
		function player:preCollision( event )
		    local platform = event.other
		    if platform.name == "platform" then
		     	if player.y-4 > platform.y then 
		        	event.contact.isEnabled = false  -- Let player pass through platform
		        end
		    end
		end
		player:addEventListener( "preCollision" )

		--Add the jump listener
		Runtime:addEventListener("touch", playerJump)

		--Create a section straight away..
		createSection()
	end
	createGame()
end


-- Called immediately after scene has moved onscreen:
-- Start timers/transitions etc.
function scene:enterScene( event )
	print( "GAME: enterScene event" )
	local screenGroup = self.view


	-- Completely remove the previous scene/all scenes.
	-- Handy in this case where we want to keep everything simple.
	storyboard.removeAll()


	--------------------------------------------
	-- ***GAME LOOP FUNCTIONS***
	--Mover everything along and change distance
	--------------------------------------------
 	--Change text function..
	local function changeText(amount)
		if amount ~= nil then
			score = score + amount
			scoreText.text = "Score: "..score
			scoreText.anchorX = 0
			scoreText.anchorY = 0.5
			--scoreText:setReferencePoint(display.CenterLeftReferencePoint)
			scoreText.x = 6
		end
	end

	--Main gameLoop function
	function gameLoop( event )
		if gameIsActive == true then
			--Increase Distance..
			distance = distance + 1
			distanceText.text = "Distance: "..mF((distance*0.3)+(levelSpeed*0.5)) --So it goes up at a good speed.
			distanceText.anchorX = 1
			distanceText.anchorY = 0.5
			--distanceText:setReferencePoint(display.CenterRightReferencePoint)
			distanceText.x = _W-6

			
			--Move the other items and platforms. 
			--If they are far left of the screen we remove them.
			local i
			for i = objectGroup.numChildren,1,-1 do
				local object = objectGroup[i]
				if object ~= nil and object.y ~= nil then
					object:translate( -levelSpeed, 0)
					if object.x < -200 then 
						display.remove(object); object = nil;
					end
				end
			end

			--Move the backgrounds...
			--We then check to see if they need to be replaced.
			bg1:translate(-(levelSpeed*0.6),0) 	
			bg2:translate(-(levelSpeed*0.6),0) 
			ground1:translate(-levelSpeed,0)
			ground2:translate(-levelSpeed,0) 
			extra1:translate(-levelSpeed,0)
			extra2:translate(-levelSpeed,0)

			if ground1.x <= -240 then
				ground1.x = ground1.x + 960
				extra1.x = extra1.x + 960
			end
			if ground2.x <= -240 then
				ground2.x = ground2.x + 960
				extra2.x = extra2.x + 960
			end
			if bg1.x <= -240 then bg1.x = bg1.x + 960 end
			if bg2.x <= -240 then bg2.x = bg2.x + 960 end


			--Controls creating new sections. Done every 4 screens.
			distChange2 = distChange2 + levelSpeed
			if distChange2 >= 1440 then 
				distChange2 = 0
				createSection() 
			end


			--Change levelspeed too, only after a set distance though.
			distChange = distChange + 1 
			if distChange >= 300 then
				lvlChange = 0.8; 
				if distance >= 3000 then lvlChange = 0.6 end
				distChange = 0
				levelSpeed = levelSpeed + lvlChange
			end
		end
	end


	--------------------------------------------
	-- ***COLLISION FUNCTIONS AND START/STOP***
	--What happens when we get hit essentially
	--------------------------------------------
	--Game over and we died...
	local function gameOver()
		--Stop the players control..
		Runtime:removeEventListener("touch", playerJump) --Stop jumping
		player:pause() --Stop the sprite.


		--Rotate and make it look like a death animation..
		--After the delay/slow down we show the restart screen.
		local function nowEnd()
			if menuShown == false then
				menuShown = true
				gameIsActive = false

				--Get the highest score and distance...
				local newDistance = mF((distance*0.3)+(levelSpeed*0.5))
				local highScore, highDistance = 0, 0
				local dbPath = system.pathForFile("levelScores.db3", system.DocumentsDirectory)
				local db = sqlite3.open( dbPath )	
				for row in db:nrows("SELECT * FROM scores WHERE id = 1") do
					highScore = tonumber(row.highscore)
					highDistance = tonumber(row.distance)
				end
				
				--Compare what we got this run and save it if its higher..
				if score > highScore then
					highScore = score
					local update = "UPDATE scores SET highscore ='"..score.."' WHERE id = 1"
					db:exec(update)
				end
				if newDistance > highDistance then 
					highDistance = newDistance
					local update = "UPDATE scores SET distance ='"..newDistance.."' WHERE id = 1"
					db:exec(update)
				end
				db:close()

				--Show restart screen
				local gameOverGroup = display.newGroup()
				screenGroup:insert(gameOverGroup)

				local menu
				local function restartGame()
					--Stop the tap from happening again.
					menu:removeEventListener("tap", restartGame)

					--Transition the group off the screen and restart.
					local function resetVars()
						display.remove(gameOverGroup); gameOverGroup = nil
						distChange, distChange2 = 0, 0
						distance, score = 0, 0
						levelSpeed = 8
						
						menuShown, gameOverCalled = false, false
						createGame()
						gameIsActive = true
					end
					local trans = transition.to(gameOverGroup, {time=600, y=0, onComplete=resetVars})
				end
				menu = display.newImageRect(gameOverGroup, "images/gameOver.png",480, 260)
				menu.x = _W*0.5; menu.y = _H+130
				menu:addEventListener("tap", restartGame)

				local text1 = display.newText(gameOverGroup, "Score: "..score,0,0,native.sytemFontBold,17)
				text1.anchorX = 1
				text1.anchorY = 0.5
				--text1:setReferencePoint(display.CenterRightReferencePoint)
				text1.x = _W*0.46; text1.y = menu.y+5; text1:setFillColor(0)
				local text2 = display.newText(gameOverGroup, "Highscore: "..highScore,0,0,native.sytemFontBold,17)
				text2.anchorX = 0
				text2.anchorY = 0.5
				--text2:setReferencePoint(display.CenterLeftReferencePoint)
				text2.x = _W*0.54; text2.y = text1.y; text2:setFillColor(0)

				local text3 = display.newText(gameOverGroup, "Distance: "..newDistance,0,0,native.sytemFont,17)
				text3.anchorX = 1
				text3.anchorY = 0.5
				--text3:setReferencePoint(display.CenterRightReferencePoint)
				text3.x = _W*0.46; text3.y = text1.y+32; text3:setFillColor(0)
				local text4 = display.newText(gameOverGroup, "Furthest: "..highDistance,0,0,native.sytemFont,17)
				text4.anchorX = 0
				text4.anchorY = 0.5
				--text4:setReferencePoint(display.CenterLeftReferencePoint)
				text4.x = _W*0.54; text4.y = text3.y; text4:setFillColor(0)
				
				--Transition it all up..
				local trans = transition.to(gameOverGroup, {time=600, y=-260})
			end
		end
		player:setLinearVelocity( 0, 0 )
		player:applyForce(0,-4, player.x, player.y)
		local trans = transition.to(player, {time=1000, rotation=90, onComplete=nowEnd})
	end

	--Collision functon. Controls hitting the vines and stars etc. Also resets the jumping
	function onCollision(event)
		if event.phase == "began" and gameIsActive == true and gameOverCalled == false then
			local name1 = event.object1.name
			local name2 = event.object2.name 

			if name1 == "player" or name2 == "player" then 
				--Hit the floor, reset vars
				if name1 == "floor" or name2 == "floor" or name1 == "platform" or name2 == "platform" then
					singleJump, doubleJump = false, false
					player:setSequence("run")
					player:play()

				--Picking up bones and powerups...
				elseif name1 == "star" or name2 == "star" then
					if name1 == "star" then display.remove(event.object1); event.object1 = nil; 
					else display.remove(event.object2); event.object2 = nil; end
					changeText(50)
					starChannel = audio.play(starSound)

				--Player hits the obstacles
				elseif name1 == "vine" or name2 == "vine" then
					--Kill player...
					gameOverCalled = true
					gameOver()
				    overChannel = audio.play(overSound)
				end
			end
		end
	end



	--Start game running...
	--Simply change the var and add a few runtime listeners...
	gameIsActive = true
	Runtime:addEventListener("enterFrame",gameLoop)
	Runtime:addEventListener("collision",onCollision)
end



-- Called when scene is about to move offscreen:
-- Cancel Timers/Transitions and Runtime Listeners etc.
function scene:exitScene( event )
	print( "GAME: exitScene event" )

	--Stop the game from running.
	gameIsActive = false
	Runtime:removeEventListener("touch",playerJump)
	Runtime:removeEventListener("enterFrame",gameLoop)
	Runtime:removeEventListener( "collision", onCollision )

	--Stop the sounds..
	audio.stop(overChannel)
	audio.stop(starChannel)
	audio.stop(jumpChannel)
end


--Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print( "GAME: destroying view" )

	--Dipose of sounds..
	audio.dispose(overSound); overSound=nil
	audio.dispose(starSound); starSound=nil
	audio.dispose(jumpSound); jumpSound=nil
end



-----------------------------------------------
-- Add the story board event listeners
-----------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )



--Return the scene to storyboard.
return scene

