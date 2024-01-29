-module(shapes)
-export([shapesArea/1, squaresArea/1, trianglesArea/1, shapesFilter/1, shapesFilter2/1])

% Area Auxilary Calculation Functions:
triangleAreaCalc({dim, Base, Height}) when Base > 0, Height > 0 -> 
		Base * Height / 2.

squareAreaCalc({dim, Width, Height}) when Width > 0, Height > 0 -> 
		2 * triangleAreaCalc({dim, Width, Height}).

ellipseAreaCalc({ellipse, {radius, Radius1, Radius2}}) when Radius1 > 0, Radius2 > 0 -> 
		math:pi() * Radius1 * Radius2.

shapesAreaCalc([], CurrSum) -> CurrSum;
shapesAreaCalc([ {triangle, Data} | Tail ], CurrSum) -> shapesAreaCalc(Tail, CurrSum + triangleAreaCalc(Data));
shapesAreaCalc([ {rectangle, Data} | Tail ], CurrSum) -> shapesAreaCalc(Tail, CurrSum + squareAreaCalc(Data));
shapesAreaCalc([ {ellipse, Data} | Tail ], CurrSum) -> shapesAreaCalc(Tail, CurrSum + ellipseAreaCalc(Data)).

squaresAreaCalc([], CurrSum) -> CurrSum;
squaresAreaCalc([ {rectangle, Data} | Tail ], CurrSum) -> squaresAreaCalc(Tail, CurrSum + squareAreaCalc(Data));
squaresAreaCalc([ _ | Tail ], CurrSum) -> squaresAreaCalc(Tail, CurrSum).

trianglesAreaCalc([], CurrSum) -> CurrSum;
trianglesAreaCalc([ {triangle,, Data} | Tail ], CurrSum) -> squaresAreaCalc(Tail, CurrSum + triangleAreaCalc(Data));
trianglesAreaCalc([ _ | Tail ], CurrSum) -> trianglesAreaCalc(Tail, CurrSum).

%Requested
shapesArea({shapes, ShapesToCalc}) -> shapesAreaCalc(ShapesToCalc, 0).

squaresArea({shapes, ShapesToCalc}) -> squaresAreaCalc(ShapesToCalc, 0).

trianglesArea({shapes, ShapesToCalc}) -> trianglesAreaCalc(ShapesToCalc, 0).

shapesFilter(WhichShape) -> fun(X) -> lists:filter(fun({WhichShape, _ }) -> true; (_) -> false end, X).

shapesFilter2(circle) -> fun(X) -> lists:filter(fun({elipse, {radius, Y, Y}}) -> true; (_) -> false end, X);
shapesFilter2(square) -> fun(X) -> lists:filter(fun({rectangle, {dim, Y, Y}}) -> true; (_) -> false end, X);
shapesFilter2(WhichShape) -> shapesFilter(WhichShape).