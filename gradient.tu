/*
 Mackie Drew
 January 24, 2008
 Gradient Module v0.1 BETA
 ---------------
 I couldn't have done this without the help of everyone from this thread.
 http://compsci.ca/v3/viewtopic.php?t=17165
 */

unit
module Gradient

    % All of the procedures accesible from external scripts
    export Box, Oval, BoxUp

    % This function's equation is courtesy of EricFourFour on CompSci
    function CalculateColor (StartColor, EndColor : int, Ratio : real) : int

	% Variables used to store inputed colors Seperate RGB values.
	var StartRED, StartGREEN, StartBLUE, EndRED, EndGREEN, EndBLUE : real

	% Figures out and stores values from the two inputed values.
	RGB.GetColour (StartColor, StartRED, StartGREEN, StartBLUE)
	RGB.GetColour (EndColor, EndRED, EndGREEN, EndBLUE)

	% Calculates and declares values used for the result.
	var RED : real := StartRED * Ratio + EndRED * (1 - Ratio)
	var GREEN : real := StartGREEN * Ratio + EndGREEN * (1 - Ratio)
	var BLUE : real := StartBLUE * Ratio + EndBLUE * (1 - Ratio)

	% Output Results
	result RGB.AddColour (RED, GREEN, BLUE)
    end CalculateColor

    % This procedure Draws a linear gradient quadrilateral.
    procedure Box (X1, Y1, X2, Y2, StartColor, EndColor : int, Ratio : real)

	% This Draws One Line at a time from X1 until the counter reaches X2
	for i : X1 .. X2 - 1
	    Draw.Line (i, Y1, i, Y2, CalculateColor (EndColor, StartColor,
		Ratio * ((i - X1) / abs (X2 - X1))))
	end for
    end Box

    % This procedure Draws a perfect circle with a gradient in it
    procedure Oval (X, Y, Radius, StartColor, EndColor : int, Ratio : real)

	% This Draws One Line at a time from X1 until the counter reaches X2
	for i : X - Radius .. X + Radius
	    Draw.FillOval (X, Y, Radius - (i - X), Radius - (i - X),
		CalculateColor (EndColor, StartColor,
		Ratio * ((i - (X - Radius)) / abs ((X + Radius) - (X - Radius)))))
	end for
    end Oval
    % This procedure Draws a linear (up to down) gradient quadrilateral.
    procedure BoxUp (X1, Y1, X2, Y2, StartColor, EndColor : int, Ratio : real)

	% This Draws One Line at a time from Y1 until the counter reaches Y2
	for i : Y1 .. Y2 - 1
	    Draw.Line (X1, i, X2, i, CalculateColor (StartColor, EndColor,
		Ratio * ((i - Y1) / abs (Y2 - Y1))))
	end for
    end BoxUp
end Gradient

