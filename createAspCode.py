# in seconds
timeDuration = 30 
startTime = 1 #(1 / timeDuration) * 6 * 60 * 60
endTime = 10 #(1 / timeDuration) * 21 * 60 * 60
maxVariablesFalse = 120/timeDuration



asp = """
%                     Spenerstrasse
%
%                       |   ||   |
%                       |   ||   |
%                       |   ||   |
%                       |---16---|15
%                       |   ||   |
%                  9    |78 ||   |     12
%             -----------||      -----------
%                  |     ||    ---5    |
%                  |      --   ---6    |
%Borsbergstr  -----|-----------|-------13---  Schandauer
%             tram-|------|------------14---  Strasse
%                  |   2---   --       |
%                  |   1---    ||      |
%             -----------   || ||-----------
%                       |   || 43|
%                       |   ||   |
%                       |---11---|10
%                       |   ||   |
%                       |   ||   |
%                       |   ||   |
%
%                     Grosser Garten
%                  Bertolt-Brecht-Allee



% facts
trafficLight(1..16).
time({:.0f}..{:.0f}).


carsPerScond(1,0).
carsPerScond(2,0).
carsPerScond(3,0).
carsPerScond(4,0).
carsPerScond(5,0).
carsPerScond(6,0).
carsPerScond(7,0).
carsPerScond(8,0).


% generate
{{green(L, T) :trafficLight(L), time(T)}}.
{{conflict(lo, ls) : trafficLight(lo), trafficLight(ls)}}

%let there be time
follow(T1, T2) :- time(T1), time(T2), T1+1=T2.


% generate
{{green(L, T) :trafficLight(L), time(T)}}.
{{green(L, T) :trafficLight(L), time(T)}}.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Constraint: Minimal Green phase (a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Error since it use seconds insteand of half minute
% Error not insteand of -
% if ped. traffic light turns green, it stays green for X seconds
20 {{green(L,T..T+20)}} 20 :- -green(L,T-1), green(L,T), L=9.
 7 {{green(L,T..T+ 7)}}  7 :- -green(L,T-1), green(L,T), L=10.
 7 {{green(L,T..T+ 7)}}  7 :- -green(L,T-1), green(L,T), L=11.
 8 {{green(L,T..T+ 8)}}  8 :- -green(L,T-1), green(L,T), L=12.
 8 {{green(L,T..T+ 8)}}  8 :- -green(L,T-1), green(L,T), L=13.
 8 {{green(L,T..T+ 8)}}  8 :- -green(L,T-1), green(L,T), L=14.
 9 {{green(L,T..T+ 9)}}  9 :- -green(L,T-1), green(L,T), L=15.
 9 {{green(L,T..T+ 9)}}  9 :- -green(L,T-1), green(L,T), L=16.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Constraint: No accidents (c)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- green(LO, T), green(LT, T), time(T), trafficlight(LO), trafficlight(LT), conflicts(LO, LT).
:- green(LT, T), green(LO, T), time(T), trafficlight(LO), trafficlight(LT), conflicts(LO, LT).
conflicts(1, 3) , trafficlight(1), trafficlight(3).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Constraint: Maximal red phase (d) Unbekannt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CONTAINS SYNTAX ERROR:
% if traffic light turns red, it is not allowed to stay red for more than 120 seconds
%lengthGreen(L,T,X=1) :- -green(L,T-1), green(L,T), green(L,T+1).
%lengthGreen(L,T,X+1) :- green(L,T+1), lengthGreen(L,T,X).
%:- lengthGreen(L,T,X), X > 120.
:- {:.0f}{{ not green(L, T..T+{:.0f})}}{:.0f}, trafficLight(L), time(T).
% if traffic light turns red, it is not allowed to stay red for more than 120 seconds
%lengthGreen(L,T,X=1) :- -green(L,T-1), green(L,T), green(L,T+1).
%lengthGreen(L,T,X+1) :- green(L,T+1), lengthGreen(L,T,X).%:- lengthGreen(L,T,X), X > 120.


%constraint c, between switching of green phases consider 3 seconds of red phase for all directions
%-green(1..8,T..T+3) :- green(L,T-1), - green(L,T).





""".format(startTime, endTime,  maxVariablesFalse,  maxVariablesFalse-1,  maxVariablesFalse)



fh = open("asp.lp", "w")
fh.write(asp)
fh.close()

print(asp)
