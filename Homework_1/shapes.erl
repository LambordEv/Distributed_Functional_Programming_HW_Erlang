-module(shapes).
-export([shapesArea/1, squaresArea/1, trianglesArea/1, shapesFilter/1, shapesFilter2/1]).

% Area Auxilary Calculation Functions:
isShapeValid({rectangle, {dim, Width, Height}}) when 0 < Width, 0 < Height -> ok;
	isShapeValid({triangle, {dim, Base, Height}}) when 0 < Base, 0 < Height -> ok;
	isShapeValid({ellipse, {radius, Rad1, Rad2}}) when 0 < Rad1, 0 < Rad2 -> ok.

triangleAreaCalc({dim, Base, Height}) when 0 < Base, 0 < Height -> 
		(Base * Height) / 2.

rectangleAreaCalc({dim, Width, Height}) when 0 < Width, 0 < Height -> 
		Width * Height.

ellipseAreaCalc({radius, Radius1, Radius2}) when 0 < Radius1, 0 < Radius2 -> 
		math:pi() * Radius1 * Radius2.

shapesAreaCalc([], CurrSum) -> CurrSum;
shapesAreaCalc([ {triangle, Data} | Tail ], CurrSum) -> shapesAreaCalc(Tail, CurrSum + triangleAreaCalc(Data));
shapesAreaCalc([ {rectangle, Data} | Tail ], CurrSum) -> shapesAreaCalc(Tail, CurrSum + rectangleAreaCalc(Data));
shapesAreaCalc([ {ellipse, Data} | Tail ], CurrSum) -> shapesAreaCalc(Tail, CurrSum + ellipseAreaCalc(Data)).

squaresAreaCalc([], CurrSum) -> CurrSum;
squaresAreaCalc([ {rectangle, {dim, W, H}} | Tail ], CurrSum) when W =:= H -> 
		squaresAreaCalc(Tail, CurrSum + rectangleAreaCalc({dim, W, H}));
squaresAreaCalc([ Shape | Tail ], CurrSum) -> isShapeValid(Shape), squaresAreaCalc(Tail, CurrSum).

trianglesAreaCalc([], CurrSum) -> CurrSum;
trianglesAreaCalc([ {triangle, Data} | Tail ], CurrSum) -> trianglesAreaCalc(Tail, CurrSum + triangleAreaCalc(Data));
trianglesAreaCalc([ _ | Tail ], CurrSum) -> trianglesAreaCalc(Tail, CurrSum).


%Requested
%-------------------------------------------------------------------------------------------------------------------
shapesArea({shapes, ShapesToCalc}) -> shapesAreaCalc(ShapesToCalc, 0).

%-------------------------------------------------------------------------------------------------------------------
squaresArea({shapes, ShapesToCalc}) -> squaresAreaCalc(ShapesToCalc, 0).

%-------------------------------------------------------------------------------------------------------------------
trianglesArea({shapes, ShapesToCalc}) -> trianglesAreaCalc(ShapesToCalc, 0).

%-------------------------------------------------------------------------------------------------------------------
shapesFilter(WhichShape) -> 
		fun({shapes, X}) -> {shapes, lists:filter(fun({GivenShape, Data}) -> isShapeValid({GivenShape, Data}), WhichShape =:= GivenShape end, X)} 
			end.

%-------------------------------------------------------------------------------------------------------------------
shapesFilter2(circle) -> 
		fun({shapes, X}) -> {shapes, lists:filter(fun({ellipse, {radius, Y, Y}}) -> true; 
																	({Shape, Data}) -> isShapeValid({Shape, Data}), false end, X)} 
			end;
shapesFilter2(square) -> 
		fun({shapes, X}) -> {shapes, lists:filter(fun({rectangle, {dim, Y, Y}}) -> true; 
																   ({Shape, Data}) -> isShapeValid({Shape, Data}), false end, X)} 
			end;
shapesFilter2(WhichShape) -> shapesFilter(WhichShape).