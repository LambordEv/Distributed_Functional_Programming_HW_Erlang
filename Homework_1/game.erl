-module(game).
-export([canWin/1, nextMove/1, explanation/0]).


canWin(0,{P1,P2})-> {P1,P2};
canWin(MatchesAmount,{P1,P2})-> canWin(MatchesAmount - 1, {(not(P1 and P2)), P1}).


%Requested
%-------------------------------------------------------------------------------------------------------------------
canWin(MatchesAmount) when is_integer(MatchesAmount) andalso 0 < MatchesAmount -> 
		element(1, canWin(MatchesAmount - 1, {true, false})).
%-------------------------------------------------------------------------------------------------------------------
nextMove(1)	-> {true, 1};
nextMove(2)	-> {true, 2};
nextMove(MatchesAmount) when is_integer(MatchesAmount) andalso 0 < MatchesAmount ->
	{P1, P2} = canWin(MatchesAmount - 2, {true, false}),
	if
		not P1	-> {true, 1};
		not P2	-> {true, 2};
		true 	-> false
	end.
%-------------------------------------------------------------------------------------------------------------------
explanation() -> {"Similar to Fibonaci Nth term calculation, you have to know who are both the previous values in order to calculate the current"}.