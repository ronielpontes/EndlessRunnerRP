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


--Localise the module. Elimates the need for module package seeall technique.
local M = {}


--This array holds each different sections information.
--E.g. Platform/Stars/Vines positions...
--You can easily add your own by copying and pasting mine to make the game more interesting!

--Below you need to place objects for three screens width in each section.
--Simply set each objects "screen" var to do it without having to add on 480 etc.
M = {
	-----------------------------------
	--This is the first section. Enter all the items you want
	--To be seen on the first 3 screens of gameplay.
	-----------------------------------
	{ 
		--The platforms you can jump on.
		platforms = {
			{
				type = "Small", --Type of platform. Small/Med/Large
				widthHeight = { 48, 45 }, --Width and Height of the platform
				position = { 20, 210 }, --X and Y Position. Just pretend its the first screen for each item
				screen = 1,  --First screen. If you change this to 2, then platform will move 480 pixels to the right.
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 100, 180 }, 
				screen = 1,
			},	
			{
				type = "Med",
				widthHeight = { 98, 51 }, 
				position = { 260, 140 }, 
				screen = 1,
			},	
		}, 

		--Stars you collect for points.
		stars = {
			{ position = {240, 120}, screen = 1 },
			{ position = {280, 120}, screen = 1 },	
			{ position = {100, 240}, screen = 2 },
			{ position = {140, 240}, screen = 2 },
			{ position = {180, 240}, screen = 2 },
			{ position = {220, 240}, screen = 2 },
			{ position = {260, 240}, screen = 2 },
			{ position = {320, 200}, screen = 2 },
			{ position = {360, 200}, screen = 2 },
			{ position = {400, 200}, screen = 2 },
			{ position = {440, 200}, screen = 2 },
			{ position = {480, 200}, screen = 2 },
		},

		--The vines that can hurt you! 
		vines = {
			{ 
				type = "Small", 
				widthHeight = { 35, 120 }, 
				position = {160, 250}, 
				screen = 3 
			},
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {280, 240}, 
				screen = 3 
			},
		},
	},

	-----------------------------------
	--This is the second section...
	-----------------------------------
	{ 
		--The platforms you can jump on.
		platforms = {
			{
				type = "Small",
				widthHeight = { 48, 45 },
				position = { 240, 200 }, 
				screen = 1,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 440, 200 }, 
				screen = 1,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 140, 200 }, 
				screen = 2,
			},	
			{
				type = "Med",
				widthHeight = { 98, 51 }, 
				position = { 320, 130 }, 
				screen = 2,
			},	
			{
				type = "Large",
				widthHeight = { 246, 54 }, 
				position = { 220, 100 }, 
				screen = 3,
			},	
		}, 

		--Stars you collect for points.
		stars = {
			{ position = {240, 180}, screen = 1 },
			{ position = {440, 180}, screen = 1 },	
			{ position = {140, 180}, screen = 2 },	
		},

		--The vines that can hurt you! 
		vines = {
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {340, 240}, 
				screen = 1 
			},
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {40, 240}, 
				screen = 2 
			},
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {240, 240}, 
				screen = 2 
			},
			{ 
				type = "Small", 
				widthHeight = { 35, 120 }, 
				position = {160, 250}, 
				screen = 3 
			},
			{ 
				type = "Small", 
				widthHeight = { 35, 120 }, 
				position = {280, 250}, 
				screen = 3 
			},
		},
	},

	-----------------------------------
	--This is the THIRD section...
	-----------------------------------
	{ 
		--The platforms you can jump on.
		platforms = {
			{
				type = "Small",
				widthHeight = { 48, 45 },
				position = { 240, 200 }, 
				screen = 1,
			},	
			{
				type = "Med",
				widthHeight = { 98, 51 }, 
				position = { 360, 160 }, 
				screen = 1,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 },
				position = { 60, 120 }, 
				screen = 2,
			},	
			{
				type = "Large",
				widthHeight = { 246, 54 }, 
				position = { 280, 100 }, 
				screen = 2,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 },
				position = { 120, 120 }, 
				screen = 3,
			},	
			{
				type = "Med",
				widthHeight = { 98, 51 }, 
				position = { 320, 160 }, 
				screen = 3,
			},	
		}, 

		--Stars you collect for points.
		stars = {
			{ position = {420, 240}, screen = 1 },
			{ position = {460, 240}, screen = 1 },	
			{ position = {20, 240}, screen = 2 },	
			{ position = {60, 240}, screen = 2 },	
			{ position = {220, 80}, screen = 2 },	
			{ position = {260, 80}, screen = 2 },	
			{ position = {300, 80}, screen = 2 },	
			{ position = {340, 80}, screen = 2 },
			{ position = {300, 140}, screen = 3 },	
			{ position = {340, 140}, screen = 3 },		
		},

		--The vines that can hurt you! 
		vines = {
			--None for this section.
		},
	},

	-----------------------------------
	--This is the FOURTH section. Enter all the items you want
	-----------------------------------
	{ 
		--The platforms you can jump on.
		platforms = {
			{
				type = "Small", --Type of platform. Small/Med/Large
				widthHeight = { 48, 45 }, --Width and Height of the platform
				position = { 200, 210 }, --X and Y Position. Just pretend its the first screen for each item
				screen = 3,  --First screen. If you change this to 2, then platform will move 480 pixels to the right.
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 400, 140 }, 
				screen = 3,
			},	
		}, 

		--Stars you collect for points.
		stars = {
			{ position = {100, 240}, screen = 1 },
			{ position = {140, 240}, screen = 1 },	
			{ position = {180, 240}, screen = 1 },
			{ position = {220, 240}, screen = 1 },
			{ position = {260, 240}, screen = 1 },
			{ position = {300, 240}, screen = 1 },
			{ position = {420, 240}, screen = 1 },
			{ position = {460, 240}, screen = 1 },
			
			{ position = {140, 240}, screen = 2 },
			{ position = {180, 240}, screen = 2 },
			{ position = {220, 220}, screen = 2 },
			{ position = {260, 180}, screen = 2 },
			{ position = {300, 140}, screen = 2 },
			{ position = {340, 180}, screen = 2 },
			{ position = {380, 220}, screen = 2 },
			{ position = {420, 240}, screen = 2 },
			{ position = {460, 240}, screen = 2 },
		},

		--The vines that can hurt you! 
		vines = {
			{ 
				type = "Small", 
				widthHeight = { 35, 120 }, 
				position = {360, 250}, 
				screen = 1 
			},
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {300, 240}, 
				screen = 2 
			},
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {300, 220}, 
				screen = 3 
			},
		},
	},

	-----------------------------------
	--This is the FIFTH section...
	-----------------------------------
	{ 
		--The platforms you can jump on.
		platforms = {
			{
				type = "Large",
				widthHeight = { 246, 54 }, 
				position = { 240, 210 }, 
				screen = 1,
			},	
			{
				type = "Med",
				widthHeight = { 98, 51 }, 
				position = { 120, 210 }, 
				screen = 2,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 180, 120 }, 
				screen = 2,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 280, 120 }, 
				screen = 2,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 20, 100 }, 
				screen = 3,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 260, 160 }, 
				screen = 3,
			},
		}, 

		--Stars you collect for points.
		stars = {
			{ position = {200, 190}, screen = 1 },
			{ position = {240, 190}, screen = 1 },	
			{ position = {280, 190}, screen = 1 },
			{ position = {80, 190}, screen = 2 },
			{ position = {120, 190}, screen = 2 },	
			{ position = {160, 190}, screen = 2 },	
			{ position = {180, 100}, screen = 2 },	
			{ position = {280, 100}, screen = 2 },	
			{ position = {20, 80}, screen = 3 },
			{ position = {260, 140}, screen = 3 },	
		},

		--The vines that can hurt you! 
		vines = {
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {60, 240}, 
				screen = 3 
			},
			{ 
				type = "Small", 
				widthHeight = { 35, 120 }, 
				position = {120, 250}, 
				screen = 3 
			},
		},
	},

	-----------------------------------
	--This is the SIXTH section...
	-----------------------------------
	{ 
		--The platforms you can jump on.
		platforms = {
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 80, 200 }, 
				screen = 1,
			},	
			{
				type = "Large",
				widthHeight = { 246, 54 }, 
				position = { 240, 120 }, 
				screen = 1,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 400, 200 }, 
				screen = 1,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 80, 160 }, 
				screen = 2,
			},	
			{
				type = "Large",
				widthHeight = { 246, 54 }, 
				position = { 240, 100 }, 
				screen = 2,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 400, 160 }, 
				screen = 2,
			},	
		}, 

		--Stars you collect for points.
		stars = {
			{ position = {180, 240}, screen = 1 },
			{ position = {220, 240}, screen = 1 },	
			{ position = {260, 240}, screen = 1 },
			{ position = {300, 240}, screen = 1 },
			{ position = {180, 200}, screen = 1 },
			{ position = {220, 200}, screen = 1 },	
			{ position = {260, 200}, screen = 1 },
			{ position = {300, 200}, screen = 1 },

			{ position = {180, 40}, screen = 2 },
			{ position = {220, 40}, screen = 2 },	
			{ position = {260, 40}, screen = 2 },
			{ position = {300, 40}, screen = 2 },
			{ position = {180, 80}, screen = 2 },
			{ position = {220, 80}, screen = 2 },	
			{ position = {260, 80}, screen = 2 },
			{ position = {300, 80}, screen = 2 },

			{ position = {180, 180}, screen = 3 },
			{ position = {220, 180}, screen = 3 },	
			{ position = {260, 180}, screen = 3 },
			{ position = {300, 180}, screen = 3 },
			{ position = {180, 140}, screen = 3 },
			{ position = {220, 140}, screen = 3 },	
			{ position = {260, 140}, screen = 3 },
			{ position = {300, 140}, screen = 3 },
		},

		--The vines that can hurt you! 
		vines = {
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {240, 240}, 
				screen = 2 
			},
			{ 
				type = "Small", 
				widthHeight = { 35, 120 }, 
				position = {200, 250}, 
				screen = 3 
			},
			{ 
				type = "Small", 
				widthHeight = { 35, 120 }, 
				position = {240, 250}, 
				screen = 3 
			},
			{ 
				type = "Small", 
				widthHeight = { 35, 120 }, 
				position = {280, 250}, 
				screen = 3 
			},
		},
	},

	-----------------------------------
	--This is the SEVENTH section...
	-----------------------------------
	{ 
		--The platforms you can jump on.
		platforms = {
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 80, 160 }, 
				screen = 1,
			},	
			{
				type = "Large",
				widthHeight = { 246, 54 }, 
				position = { 240, 100 }, 
				screen = 1,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 400, 160 }, 
				screen = 1,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 80, 200 }, 
				screen = 2,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 400, 200 }, 
				screen = 2,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 40, 170 }, 
				screen = 3,
			},	
			{
				type = "Small",
				widthHeight = { 48, 45 }, 
				position = { 140, 130 }, 
				screen = 3,
			},	

			{
				type = "Med",
				widthHeight = { 112, 51 },
				position = { 320, 100 }, 
				screen = 3,
			},	
		}, 

		--Stars you collect for points.
		stars = {
			{ position = {220, 80}, screen = 1 },
			{ position = {260, 80}, screen = 1 },	
			{ position = {220, 240}, screen = 2 },
			{ position = {260, 240}, screen = 2 },
			{ position = {220, 200}, screen = 2 },
			{ position = {260, 200}, screen = 2 },
			{ position = {290, 80}, screen = 3 },
			{ position = {320, 80}, screen = 3 },	
			{ position = {350, 80}, screen = 3 },
		},

		--The vines that can hurt you! 
		vines = {
			
			{ 
				type = "Small", 
				widthHeight = { 25, 80 }, 
				position = {180, 80}, 
				screen = 1 
			},
			{ 
				type = "Small", 
				widthHeight = { 25, 80 }, 
				position = {300, 80}, 
				screen = 1 
			},
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {160, 270}, 
				screen = 2 
			},
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {320, 270}, 
				screen = 2 
			},
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {250, 260}, 
				screen = 3 
			},
			{ 
				type = "Large", 
				widthHeight = { 44, 150 }, 
				position = {390, 260}, 
				screen = 3 
			},
		},
	},
}


--Return it all to the game.
return M

