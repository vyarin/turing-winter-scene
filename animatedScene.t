import Gradient in "gradient.tu"

View.Set ("graphics:1280;720, nocursor, nobuttonbar")

% User's scene choice
var sceneChoice : char

% Add a new colour using RGB values
fcn rgb (r : int, g : int, b : int) : int
    % Define the value of 1 in 255 normalized between 0 and 1
    var normalizedRGB : real := 1 / 255

    % Add a new colour
    var clr : int := RGB.AddColour (normalizedRGB * r, normalizedRGB * g, normalizedRGB * b)

    % Return the colour number
    result clr
end rgb


% Define new colours
% Reds
const thunder : int := rgb (60, 37, 44)
const blackCat : int := rgb (69, 52, 60)
const petiteOrchid : int := rgb (213, 161, 149)

% Yellows
const gold : int := rgb (183, 172, 120)
const chalky : int := rgb (240, 210, 147)
const vanilla : int := rgb (218, 187, 158)

% Greens
const rangoonGreen : int := rgb (25, 25, 27)
const greenyGrey : int := rgb (136, 156, 111)

% Blues
const wildBlueYonder : int := rgb (115, 144, 188)
const rockBlue : int := rgb (151, 181, 205)
const woodsmoke : int := rgb (11, 10, 19)
const marbleBlue : int := rgb (80, 113, 121)
const blueBayoux : int := rgb (69, 109, 121)
const darkBlueGrey : int := rgb (41, 56, 73)
const blueJay : int := rgb (57, 75, 112)

% Greys
const platinum : int := rgb (227, 228, 224)
const greyGoose : int := rgb (203, 205, 208)
const greyBlue : int := rgb (115, 136, 167)
const ashGrey : int := rgb (185, 188, 187)
const starDust : int := rgb (157, 155, 156)
const boulder : int := rgb (117, 118, 121)
const cottonSeed : int := rgb (196, 187, 174)
const dusk : int := rgb (69, 90, 113)
const steel : int := rgb (115, 131, 146)

% Blacks
const skyBlack : int := rgb (1, 2, 4)
const cinder : int := rgb (16, 15, 23)
const nightBlack : int := rgb (15, 9, 11)
const mirage : int := rgb (21, 28, 36)
const blackPearl : int := rgb (12, 21, 30)
const balticSea : int := rgb (34, 41, 48)
const almostBlack : int := rgb (5, 7, 11)

% Whites
const greenWhite : int := rgb (234, 233, 224)
const pearlBush : int := rgb (225, 226, 213)
const whiteRock : int := rgb (237, 233, 202)

% Ground coordinates
const groundX : array 1 .. 3 of int := init (
    0, 1162, 4158)
const groundY : array 1 .. 3 of int := init (
    -4, 289, 0)

% Platform coordinates
const platformX : array 1 .. 4 of int := init (
    0, 894, 1059, 0)
const platformY : array 1 .. 4 of int := init (
    227, 274, 271, 47)
const platformBottomX : array 1 .. 4 of int := init (
    0, 1060, 1060, 0)
const platformBottomY : array 1 .. 4 of int := init (
74, 271, 264, -4)

% Roof coordinates
const roofBottomX : array 1 .. 4 of int := init (
    0, 1060, 919, 0)
const roofBottomY : array 1 .. 4 of int := init (
    440, 301, 299, 340)
const roofTopX : array 1 .. 4 of int := init (
    0, 1060, 1060, 0)
const roofTopY : array 1 .. 4 of int := init (
    484, 306, 301, 441)

% Stripe coordinates
const stripeX : array 1 .. 4 of int := init (
    0, 1018, 1037, 0)
const stripeY : array 1 .. 4 of int := init (
    156, 271, 271, 124)

% Beam coordinates
const beamsX : array 1 .. 28 of int := init (
    109, 130, 130, 142,
    384, 399, 382, 383,
    601, 616, 594, 602,
    737, 746, 730, 738,
    832, 838, 823, 832,
    894, 899, 885, 894,
    941, 945, 933, 941)
const beamsY : array 1 .. 28 of int := init (
    190, 396, 190, 396,
    216, 368, 216, 368,
    235, 345, 235, 345,
    249, 333, 249, 333,
    258, 322, 258, 322,
    265, 315, 265, 315,
    269, 310, 269, 310)

% Rail coordinates
const railX : array 1 .. 12 of int := init (
    356, 466, 1162,
    1023, 1092, 1162, 1280,
    1280, 1162, 1280, 1280,
    1162)

const railY : array 1 .. 12 of int := init (
    0, 0, 289,
    0, 0, 289, 220,
    230, 289, 268, 269,
    289)

const railBottomX : array 1 .. 12 of int := init (
    466, 547, 1162, 1092,
    1100, 1162, 1280, 1280,
    1162, 1280, 1280, 1162)

const railBottomY : array 1 .. 12 of int := init (
    0, 0, 289, 0,
    0, 289, 214, 220,
    289, 266, 267, 289)

const beams3DX : array 1 .. 28 of int := init (
    128, 147, 378, 382, 
    591, 600, 728, 738, 
    821, 832, 884, 891, 
    929, 939, 131, 145,
    384, 381, 601, 594, 
    738, 730, 832, 824,
    894, 886, 943, 932)
    
const beams3DY : array 1 .. 28 of int := init (
    191, 200, 222, 212, 
    240, 234, 249, 246, 
    257, 255, 263, 261, 
    267, 265, 397, 389,
    370, 364, 345, 344, 
    332, 332, 323, 322, 
    316, 314, 310, 310)

% Store the right most position of user's current text input for blinkingCursor process
var lastPositionX : int := 0
    
% Draw snowflake branch
proc drawBranch (x1 : int, y1 : int, x2 : int, y2 : int, thickness : int, col : int)
    Draw.ThickLine (x1, y1, x2, y2, thickness, col)
    Draw.FillOval (x1, y1, 10, 10, col)
    Draw.FillOval (x1, y1, 5, 5, white)
    Draw.FillOval (x2, y2, 10, 10, col)
    Draw.FillOval (x2, y2, 5, 5, white)
end drawBranch


% Display welcome message
proc welcome
    % Obtain fonts
    var subtitle : int := Font.New ("Centaur:12")
    var title : int := Font.New ("Centaur:60")

    % Draw title
    var text : array 1 .. 3 of string := init ("WELCOME TO THE SEASON OF", "WINTER", "Press any key to continue")
    Font.Draw (text (1), (1280 - Font.Width (text (1), subtitle)) div 2, 255, subtitle, gold)
    Font.Draw (text (2), (1280 - Font.Width (text (2), title)) div 2, 180, title, gold)
    Font.Draw (text (3), (1280 - Font.Width (text (3), subtitle)) div 2, 100, subtitle, gold)

    % Draw box
    for i : 0 .. 4
	Draw.Box (490 - i, 300 - i, 790 + i, 600 + i, gold)
    end for

    % Draw snowflake
    drawBranch (640, 380, 640, 520, 5, gold)
    drawBranch (570, 450, 710, 450, 5, gold)
    drawBranch (590, 500, 690, 400, 5, gold)
    drawBranch (590, 400, 690, 500, 5, gold)
    Draw.FillOval (640, 450, 20, 20, gold)
    Draw.FillOval (640, 450, 15, 15, white)
    
    var chars : array char of boolean

    Input.Pause

    % Free fonts to prevent reaching maximum number of fonts that may be defined
    Font.Free (subtitle)
    Font.Free (title)
end welcome


% Display a countdown
proc countdown
    % Obtain font
    var number : int := Font.New ("Centaur:100")
    var title : int := Font.New ("Centaur:14")
    var text : string := "ARRIVING AT THE TRAIN STATION IN"
    for decreasing i : 10 .. 1
	cls
	Font.Draw (text, (1280 - Font.Width (text, title)) div 2, 480, title, gold)
	Font.Draw (intstr (i), (1280 - Font.Width (intstr (i), number)) div 2, 360, number, gold)
	delay (1000)
    end for

    % Free font to prevent reaching maximum number of fonts that may be defined
    Font.Free (number)
    cls
end countdown


% Blink cursor
process blinkingCursor
    var cursor : int := Font.New ("Centaur:14")

    % Set inital position of cursor to middle of window
    lastPositionX := (1280 + Font.Width ("|", cursor)) div 2 - Font.Width ("|", cursor)

    var halfCursorWidth : int := Font.Width ("|", cursor) div 2
    loop
	Draw.FillBox (lastPositionX + 4, 326, lastPositionX + halfCursorWidth, 344, white)
	delay (500)
	
	% Exit when the user chooses a scene
	if ord(sceneChoice) > 0 then
	    exit
	else
	    Font.Draw ("|", lastPositionX, 330, cursor, gold)
	    delay (500)
	end if
    end loop
    
    % Free font to prevent reaching maximum number of fonts that may be defined
    Font.Free (cursor)
end blinkingCursor


% Prompt user to select a day or night scene
fcn sceneSelection : string
    % Obtain font
    var title : int := Font.New ("Centaur:14")
    var choice : string
    var chars : array char of boolean
    var response : string := ""
    
    % Prompt user to input choice
    cls
    var prompt : string := "Choose a day [D] or night [N] scene: "
    Font.Draw (prompt, (1280 - Font.Width (prompt, title)) div 2, 360, title, gold)  
    
    % Get characters inputted by user
    loop
	Input.KeyDown (chars)
	var character : char := getchar
	if character = KEY_BACKSPACE then
	    % Delete a character from the user's input
	    if length (response) > 0 then
		response := response (1 .. * - 1)
	    end if
	% Prevent the character printed to be a special character, such as "CTRL + K"
	elsif ord (character) > 31 & ord (character) < 127 then
	    % Add a character to the user's input
	    response += character
	elsif character = KEY_ENTER then
	    exit
	end if
	
	% Avoid accidental multiple keystrokes when a key is pressed by emptying keyboard buffer
	Input.Flush
	
	% Update text to reflect user's input
	Draw.FillBox (0, 320, 1280, 350, white)
	Font.Draw (response + "|", (1280 - Font.Width (response + "|", title)) div 2, 330, title, gold)
	
	% Set blinking cursor position to the right of the inputted text
	lastPositionX := (1280 + Font.Width (response + "|", title)) div 2 - Font.Width ("|", title)
    end loop
    
    % Set blinking cursor to middle of window
    lastPositionX := (1280 - Font.Width ("|", title)) div 2 - Font.Width ("|", title)
    
    % Free font to prevent reaching maximum number of fonts that may be defined
    Font.Free (title)
    
    % Trim any leading and trailing spaces of the input
    result (Str.Trim (response))
end sceneSelection


% Validate user's choice of scene
fcn validateChoice (choice : string) : boolean
    % Obtain font
    var title : int := Font.New ("Centaur:14")
    var valid : boolean := false

    % Check if input is one of the valid choices
    if choice = "D"| choice = "d"| choice = "N"| choice = "n" then
	valid := true
    else
	% Display error message to user
	cls
	var error : string := "Please enter \"D\" for Day or \"N\" for Night.\n" 
    Font.Draw (error, (1280 - Font.Width (error, title)) div 2, 360, title, gold)
	delay (1000)
    end if
    
    % Free font to prevent reaching maximum number of fonts that may be defined
    Font.Free (title)
    
    result valid
end validateChoice


% Prompt user to select a scene, validating their input and storing their choice
proc userSelection
    loop
	% Prompt user to select a scene
	var choice : string := sceneSelection ()

	% Update sceneChoice to reflect user's choice when input is valid, starting a countdown
	if validateChoice (choice) then
	    if choice = "D" or choice = "d" then
		sceneChoice := "D"
	    else
		sceneChoice := "N"
	    end if
	    exit
	end if
    end loop
    
    % Start countdown
    countdown ()
end userSelection


% Draw pine trees
proc drawTree (amount, clr : int) % note add a multiply layer for shadow
    for tree : 1 .. amount
	var x1 : int := Rand.Int (1, 1280)
	var y1 : int := Rand.Int (260, 280)
	var height : int := y1 + Rand.Int (300, 450) - x1 div 4

	% Draw trunk
	Draw.ThickLine (x1, y1, x1, height, Rand.Int (3, 5), black)

	% Draw tree branches; decrease in branch length as y1 increases
	for i : height div 2 .. height - 1
	    Draw.Line (x1, i, (x1 + (height - i) div 4) + Rand.Int (-20, 20), i + Rand.Int (-30, 30), clr)
	    Draw.Line (x1, i, (x1 - (height - i) div 4) + Rand.Int (-20, 20), i + Rand.Int (-30, 30), clr)
	end for
    end for
end drawTree


% Draw clouds in the sky
proc drawClouds (amount, clr : int)
    for cloud : 1 .. amount
	var height : int := Rand.Int (360, 720)
	Draw.FillOval (Rand.Int (0, 1280), height, Rand.Int (280, 720), Rand.Int (1, 2) * (height div 80), clr)
    end for
end drawClouds


% Draw beams
proc drawBeams (shadow, shadow2, highlight, backgroundLower, backgroundUpper : int)
    for beam : 1 .. 28 by 4
	exit when beam = 28
	Gradient.BoxUp (beamsX (beam), beamsY (beam), beamsX (beam + 1), beamsY (beam + 1), shadow, highlight, 0.1)
	Gradient.BoxUp (beamsX (beam + 2), beamsY (beam + 2), beamsX (beam + 3), beamsY (beam + 3), shadow2, highlight, 0.4)
    end for

    % Draw lines over beams to add perspective
    Draw.ThickLine (109, 398, 951, 311, 6, backgroundLower)
    Draw.ThickLine (109, 188, 956, 267, 6, backgroundUpper)
    for i : 1 .. 28 by 2
	if i > 14 then
	    Draw.ThickLine (beams3DX (i), beams3DY (i), beams3DX (i+1), beams3DY (i+1), 6, backgroundLower)
	else
	    Draw.ThickLine (beams3DX (i), beams3DY (i), beams3DX (i+1), beams3DY (i+1), 6, backgroundUpper)
	end if
    end for
end drawBeams


% Draw fence
proc drawFence (rail, picketLower, picketUpper : int)
    Draw.ThickLine (894, 289, 1059, 286, 2, rail)
    for x : 894 .. 1059 by 5
	var y : int := round ((-1 / 55) * x + 305)
	Gradient.BoxUp (x + 1, y - 15, x, y, picketUpper, picketLower, 0.6)
    end for
end drawFence
    

% Draw train station lights
proc drawLights (size, clr, lights: int)
    % Light coordinates
    var lightsX : array 1 .. * of int := init (
	0, 74, 155, 241,
	292, 356, 420, 476,
	527, 571, 630, 662,
	692, 717, 758, 778,
	799, 818, 847, 857,
	870, 880, 906, 911,
	921, 929, 950, 951,
	960, 961)

    for light : 1 .. lights * 2 by 2
	var x1 : int := lightsX (light)
	var x2 : int := lightsX (light + 1)
	Draw.ThickLine (x1, round ((-111 / 963) * (x1) + 420), x2, round ((-111 / 963) * (x2) + 420), size, clr)
    end for
end drawLights


% Animate a night winter scene
proc night
    cls

    % Draw sky
    Gradient.BoxUp (0, 289, 1280, 720, skyBlack, nightBlack, 1)
    
    % Draw background elements
    drawClouds (14, woodsmoke)
    drawTree (25, black)

    % Draw ground
    Draw.FillBox (0, 0, 1280, 289, blueJay)

    % Draw snow hills
    Draw.FillOval (280, 200, 500, 100, blueJay)

    % Draw floor
    Draw.FillPolygon (platformX, platformY, 4, dusk)
    Draw.FillPolygon (platformBottomX, platformBottomY, 4, cinder)

    % Draw rails
    Draw.FillPolygon (railX, railY, 12, balticSea)
    Draw.FillPolygon (railBottomX, railBottomY, 12, almostBlack)

    % Draw roof
    Draw.FillPolygon (roofBottomX, roofBottomY, 4, mirage)
    Draw.FillPolygon (roofTopX, roofTopY, 4, cinder)

    % Draw stripe on floor
    Draw.FillPolygon (stripeX, stripeY, 4, greenyGrey)

    % Draw fence
    drawFence (dusk, steel, mirage)

    % Draw beams
    drawBeams (darkBlueGrey, mirage, steel, mirage, dusk)

    % Apply box blur to light
    drawLights (10, vanilla, 15)
    var previousValues : array 1 .. 6, 1 .. 3 of real
    for addY : -7 .. 7
	for x : 0 .. 968
	    var y : int := round ((-111 / 963) * (x) + 420) + addY
	    var rSum, gSum, bSum : real := 0
	    if x > 0 then
		% Add previous values to sum
		for value : 1 .. 6
		    rSum += previousValues (value, 1)
		    gSum += previousValues (value, 2)
		    bSum += previousValues (value, 3)
		end for
		% Get rid of first pixel values in the array to make room for new values
		for i : 1 .. 5
		    previousValues (i, 1) := previousValues (i + 1, 1)
		    previousValues (i, 2) := previousValues (i + 1, 2)
		    previousValues (i, 3) := previousValues (i + 1, 3)
		end for

		% Get new value of pixels, add to sum
		RGB.GetColour (View.WhatDotColour (x + 3, y), previousValues (6, 1), previousValues (6, 2), previousValues (6, 3))
		rSum += previousValues (6, 1)
		gSum += previousValues (6, 2)
		bSum += previousValues (6, 3)
	    else
		% Store initial colours of pixels in previousValues array
		for i : -3 .. 3
		    var r, g, b : real
		    RGB.GetColour (View.WhatDotColour (x + i, y), r, g, b)

		    % Initially store every pixel colour except the furthest left pixel so when the furthest left
		    % colours are subtracted in the next iteration, all required previous colours of the first blur are stored
		    % As the loop iterates through the output window to the right, the furthest left pixel is subtracted from
		    % the total while the right is added.
		    if i > -3 then
			previousValues (i + 3, 1) := r
			previousValues (i + 3, 2) := g
			previousValues (i + 3, 3) := b
		    end if
		    rSum += r
		    gSum += g
		    bSum += b
		end for
	    end if
	    % Display new pixel using the averages of its surrounding pixels
	    Draw.Dot (x, y, RGB.AddColour (rSum / 7, gSum / 7, bSum / 7))
	end for
    end for
    
    % Apply box blur vertically
    for x : 0 .. 968
	for addY : -7 .. 7
	    var y : int := round ((-111 / 963) * (x) + 420) + addY
	    var rSum, gSum, bSum : real := 0
	    if addY > -7 then
		% Add previous values to sum
		for value : 1 .. 6
		    rSum += previousValues (value, 1)
		    gSum += previousValues (value, 2)
		    bSum += previousValues (value, 3)
		end for
		% Get rid of first pixel values in the array to make room for new values
		for i : 1 .. 5
		    previousValues (i, 1) := previousValues (i + 1, 1)
		    previousValues (i, 2) := previousValues (i + 1, 2)
		    previousValues (i, 3) := previousValues (i + 1, 3)
		end for
		% Get new value of pixels, add to sum
		RGB.GetColour (View.WhatDotColour (x, y + 3), previousValues (6, 1), previousValues (6, 2), previousValues (6, 3))
		rSum += previousValues (6, 1)
		gSum += previousValues (6, 2)
		bSum += previousValues (6, 3)
	    else
		% Store initial colours of pixels in previousValues array
		for i : -3 .. 3
		    var r, g, b : real
		    RGB.GetColour (View.WhatDotColour (x, y + i), r, g, b)
		    if i > -3 then
			previousValues (i + 3, 1) := r
			previousValues (i + 3, 2) := g
			previousValues (i + 3, 3) := b
		    end if
		    rSum += r
		    gSum += g
		    bSum += b
		end for
	    end if
	    % Display new pixel using the averages of its surrounding pixels
	    Draw.Dot (x, y, RGB.AddColour (rSum / 7, gSum / 7, bSum / 7))
	end for
    end for
    drawLights (4, pearlBush, 15)
end night


% Animate a day winter scene
proc day
    cls
    
    % Draw sky
    Gradient.BoxUp (0, 289, 1280, 720, wildBlueYonder, rockBlue, 0.5)
    
    % Draw background elements
    Draw.FillOval (1163, 400, 40, 40, whiteRock)
    drawClouds (14, platinum)
    drawTree (25, black)

    % Draw snow hills
    Draw.FillOval (280, 200, 500, 100, greyGoose)
    Gradient.BoxUp (0, 0, 1280, 289, platinum, greyGoose, 2)

    % Draw floor
    Draw.FillPolygon (platformX, platformY, 4, greenWhite)
    Draw.FillPolygon (platformBottomX, platformBottomY, 4, starDust)

    % Draw rails
    Draw.FillPolygon (railX, railY, 12, blackCat)
    Draw.FillPolygon (railBottomX, railBottomY, 12, thunder)

    % Draw roof
    Draw.FillPolygon (roofTopX, roofTopY, 4, ashGrey)
    Draw.FillPolygon (roofBottomX, roofBottomY, 4, marbleBlue)

    % Draw stripe on floor
    Draw.FillPolygon (stripeX, stripeY, 4, chalky)

    % Draw fence
    drawFence (starDust, cottonSeed, blueBayoux)
    
    % Draw beams
    drawBeams (blueBayoux, boulder, cottonSeed, marbleBlue, greenWhite)
    
    % Draw lights
    drawLights (4, platinum, 15)
end day


% Animate snowflakes and lights
proc animate
    var snowflakes : int := 200

    % Initialize array with all the coordinates of the snowflakes
    var flakeLocation : array 1 .. snowflakes, 1 .. 2 of int

    % Randomize snowflake locations
    for snowflake : 1 .. snowflakes
	flakeLocation (snowflake, 1) := Rand.Int (0, maxx)
	flakeLocation (snowflake, 2) := Rand.Int (0, maxy)
    end for

    % Colours under a certain snowflake
    var previousColours : array 1 .. snowflakes of int

    % Move snowflakes
    for i : 1 .. 600
	for snowflake : 1 .. snowflakes
	    % Reset the y value of the snowflake when it goes out of the screen
	    if flakeLocation (snowflake, 2) < 0 then
		flakeLocation (snowflake, 2) := Rand.Int (maxx div 2, maxx)
	    else
		% Move snowflake x coordinates down
		flakeLocation (snowflake, 2) -= Rand.Int (1, 7)
	    end if

	    % Add variance to snowflake y coordinate to mimic natural snowflakes
	    flakeLocation (snowflake, 1) += Rand.Int (-10, 10)

	    % Get previous colour under snowflake
	    previousColours (snowflake) := View.WhatDotColour (flakeLocation (snowflake, 1), flakeLocation (snowflake, 2))

	    % Draw snowflake
	    if sceneChoice = "N" then
		% Add a snowflake on top of the rails or trees and brighten snowflake when under the lights
		if previousColours (snowflake) ~= black and previousColours (snowflake) ~= greyBlue and View.WhatDotColour (flakeLocation (snowflake, 1), flakeLocation (snowflake, 2) - 1) = black or View.WhatDotColour (flakeLocation (snowflake, 1), flakeLocation (snowflake, 2) - 1) = balticSea then
		    Draw.Dot (flakeLocation (snowflake, 1) - 1, flakeLocation (snowflake, 2), blueJay)
		end if
		if (flakeLocation (snowflake, 1) > 0 and flakeLocation (snowflake, 1) < 919) and (flakeLocation (snowflake, 2) > 271 and flakeLocation (snowflake, 2) < 335) then
		    Draw.Dot (flakeLocation (snowflake, 1), flakeLocation (snowflake, 2), white)
		else
		    Draw.Dot (flakeLocation (snowflake, 1), flakeLocation (snowflake, 2), greyBlue)
		end if
		
	    else
		% Add a snowflake on top of the rails or trees
		if previousColours (snowflake) ~= black and previousColours (snowflake) ~= white and previousColours (snowflake) ~= marbleBlue and View.WhatDotColour (flakeLocation (snowflake, 1),
			flakeLocation (snowflake, 2) - 1) = black or View.WhatDotColour (flakeLocation (snowflake, 1), flakeLocation (snowflake, 2) - 1) = blackCat
			then
		    Draw.Dot (flakeLocation (snowflake, 1) - 1, flakeLocation (snowflake, 2), platinum)
		end if
		Draw.Dot (flakeLocation (snowflake, 1), flakeLocation (snowflake, 2), platinum)
		
	    end if
	    if sceneChoice = "N" then 
		% Flicker lights
		var num : int := Rand.Int (1, 100)

		if num mod 3 = 0 then
		    drawLights (4, pearlBush, 15)
		elsif num mod 5 = 0 then
		    drawLights (4, vanilla, 15)
		end if
	    else
		% Gradually turn off lights
		drawLights (4, steel, round (i / 40))
	    end if
	end for
	delay (100)

	% Cover previous snowflakes with its previous colour
	for snowflake : 1 .. snowflakes
	    Draw.Dot (flakeLocation (snowflake, 1), flakeLocation (snowflake, 2), previousColours (snowflake))
	end for
    end for
end animate

welcome ()

% Prompt user for scene choice
fork blinkingCursor
userSelection ()

% Animate chosen scene 
if sceneChoice = "D" then
    day ()
else
    night ()
end if

animate ()
