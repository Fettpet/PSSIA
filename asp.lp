
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
trafficLightCars(1..8).
trafficLightPed(9..16).
time(720..2520).


carsPerScond(1,0).
carsPerScond(2,0).
carsPerScond(3,0).
carsPerScond(4,0).
carsPerScond(5,0).
carsPerScond(6,0).
carsPerScond(7,0).
carsPerScond(8,0).



%let there be time
follow(T1, T2) :- time(T1), time(T2), T1+1=T2.


% generate
green(L, T) :- trafficLightCars(L), time(T).
green(L, T) :- trafficLightPed(L), time(T).


% define
% if ped. traffic light turns green, it stays green for X seconds
20 {green(L,T..T+20)} 20 :- -green(L,T-1), green(L,T), L=9.
 7 {green(L,T..T+ 7)}  7 :- -green(L,T-1), green(L,T), L=10.
 7 {green(L,T..T+ 7)}  7 :- -green(L,T-1), green(L,T), L=11.
 8 {green(L,T..T+ 8)}  8 :- -green(L,T-1), green(L,T), L=12.
 8 {green(L,T..T+ 8)}  8 :- -green(L,T-1), green(L,T), L=13.
 8 {green(L,T..T+ 8)}  8 :- -green(L,T-1), green(L,T), L=14.
 9 {green(L,T..T+ 9)}  9 :- -green(L,T-1), green(L,T), L=15.
 9 {green(L,T..T+ 9)}  9 :- -green(L,T-1), green(L,T), L=16.



%CONTAINS SYNTAX ERROR:
% if traffic light turns red, it is not allowed to stay red for more than 120 seconds
%lengthGreen(L,T,X=1) :- -green(L,T-1), green(L,T), green(L,T+1).
%lengthGreen(L,T,X+1) :- green(L,T+1), lengthGreen(L,T,X).
%:- lengthGreen(L,T,X), X > 120.



%constraint c, between switching of green phases consider 3 seconds of red phase for all directions
-green(1..8,T..T+3) :- green(L,T-1), - green(L,T).



