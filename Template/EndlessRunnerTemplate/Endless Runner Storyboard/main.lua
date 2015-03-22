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


--Initial Settings
display.setStatusBar( display.HiddenStatusBar ) --Hide status bar from the beginning


-- Import sqlite and storyboard
local sqlite3 = require("sqlite3")
local storyboard = require "storyboard"
storyboard.purgeOnSceneChange = true --So it automatically purges for us.


--Create a constantly looping background sound...
local bgSound = audio.loadStream("sounds/bgSound.mp3")
audio.reserveChannels(1)   --Reserve its channel
audio.play(bgSound, {channel=1, loops=-1}) --Start looping the sound.



--Create a database table for holding the high scores in.
--We only need a small database to hold the highscore and the furthest distance run.
--Nice and simple database!
local dbPath = system.pathForFile("levelScores.db3", system.DocumentsDirectory)
local db = sqlite3.open( dbPath )	

--Current 10 levels. 
local tablesetup = [[ 
		CREATE TABLE scores (id INTEGER PRIMARY KEY, highscore, distance); 
		INSERT INTO scores VALUES (NULL, '0', '0' ); 
	]]
db:exec( tablesetup ) --Create it now.
db:close() --Then close the database



--Now change scene to go to the menu.
storyboard.gotoScene( "menu", "fade", 400 )
