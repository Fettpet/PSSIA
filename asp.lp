
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
time(1..1000).


carsPerScond(1,0).
carsPerScond(2,0).
carsPerScond(3,0).
carsPerScond(4,0).
carsPerScond(5,0).
carsPerScond(6,0).
carsPerScond(7,0).
carsPerScond(8,0).


% generate
{green(L, T) :trafficLight(L), time(T)}.
{conflict(lo, ls) : trafficLight(lo), trafficLight(ls)}

%let there be time
follow(T1, T2) :- time(T1), time(T2), T1+1=T2.


% generate
{green(L, T) :trafficLight(L), time(T)}.
{green(L, T) :trafficLight(L), time(T)}.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Constraint: Minimal Green phase (a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Error since it use seconds insteand of half minute
% Error not insteand of -
% if ped. traffic light turns green, it stays green for X seconds
%20 {green(L,T..T+20)} 20 :- -green(L,T-1), green(L,T), L=9.
% 7 {green(L,T..T+ 7)}  7 :- -green(L,T-1), green(L,T), L=10.
% 7 {green(L,T..T+ 7)}  7 :- -green(L,T-1), green(L,T), L=11.
% 8 {green(L,T..T+ 8)}  8 :- -green(L,T-1), green(L,T), L=12.
% 8 {green(L,T..T+ 8)}  8 :- -green(L,T-1), green(L,T), L=13.
% 8 {green(L,T..T+ 8)}  8 :- -green(L,T-1), green(L,T), L=14.
% 9 {green(L,T..T+ 9)}  9 :- -green(L,T-1), green(L,T), L=15.
% 9 {green(L,T..T+ 9)}  9 :- -green(L,T-1), green(L,T), L=16.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Constraint: No accidents (b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constraints
:-  green(Lo, T), conflict(Lo, Lt), green(Lt, T).
 
 
%Facts
%Conflicts fact
conflict(1, 3).
conflict(1, 4).
conflict(1, 6).
conflict(1, 7).
conflict(1, 8).

conflict(2, 3).
conflict(2, 4).
conflict(2, 5).
conflict(2, 7).
conflict(2, 8).


conflict(3, 1).
conflict(3, 2).
conflict(3, 5).
conflict(3, 6).
conflict(3, 8).
 
conflict(4, 1).
conflict(4, 2).
conflict(4, 5).
conflict(4, 6).
conflict(4, 7).

conflict(5, 2).
conflict(5, 3).
conflict(5, 4).
conflict(5, 7).
conflict(5, 8).

conflict(6, 1).
conflict(6, 3).
conflict(6, 4).
conflict(6, 7).
conflict(6, 8).

conflict(7, 1).
conflict(7, 2).
conflict(7, 4).
conflict(7, 5).
conflict(7, 6).

conflict(8, 1).
conflict(8, 2).
conflict(8, 3).
conflict(8, 5).
conflict(8, 6).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Constraint (c): Ped can cross the street

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Constraint See (b)

%Facts
conflict(8, 14).
conflict(8, 16).

conflict(7, 9).
conflict(7, 11).
conflict(7, 16).


conflict(6, 11).
conflict(6, 12).

conflict(5, 12).
conflict(5, 15).
conflict(5, 9).

conflict(4, 9).
conflict(4, 10).

conflict(3, 10).
conflict(3, 14).
conflict(3, 15).

conflict(2, 9).
conflict(2, 15).

conflict(1, 9).
conflict(1, 11).
conflict(1, 14).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Constraint: Maximal red phase (d) Unbekannt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CONTAINS SYNTAX ERROR:
% if traffic light turns red, it is not allowed to stay red for more than 120 seconds
%lengthGreen(L,T,X=1) :- -green(L,T-1), green(L,T), green(L,T+1).
%lengthGreen(L,T,X+1) :- green(L,T+1), lengthGreen(L,T,X).
%:- lengthGreen(L,T,X), X > 120.

:- 120{ not green(L, T..T+119)}120, trafficLight(L), time(T), T<880.



