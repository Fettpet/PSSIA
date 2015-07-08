
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
% must
tram(4).
tram(10).
tram(63).
tram(64).

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
{conflict(lo, ls) : trafficLight(lo), trafficLight(ls)}.
{tramArrive(tr, ti) : time(ti), tram(tr)}.
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Constraint Tram has priority (e)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Contraints
%Tram 4
not green(6, T), not green(2, T), not green(9, T), not green(13, T) :- tramArrive(4, T), time(T). 


% Facts
tramArrive(4, 22260).
tramArrive(4, 22860).
tramArrive(4, 23460).
tramArrive(4, 24060).
tramArrive(4, 24660).
tramArrive(4, 25260).
tramArrive(4, 25860).
tramArrive(4, 26460).
tramArrive(4, 27060).
tramArrive(4, 27660).
tramArrive(4, 28260).
tramArrive(4, 28860).
tramArrive(4, 29460).
tramArrive(4, 30060).
tramArrive(4, 30660).
tramArrive(4, 31260).
tramArrive(4, 31860).
tramArrive(4, 32460).
tramArrive(4, 33060).
tramArrive(4, 33660).
tramArrive(4, 34260).
tramArrive(4, 34860).
tramArrive(4, 35460).
tramArrive(4, 36060).
tramArrive(4, 36660).
tramArrive(4, 37260).
tramArrive(4, 37860).
tramArrive(4, 38460).
tramArrive(4, 39060).
tramArrive(4, 39660).
tramArrive(4, 40260).
tramArrive(4, 40860).
tramArrive(4, 41460).
tramArrive(4, 42060).
tramArrive(4, 42660).
tramArrive(4, 43260).
tramArrive(4, 43860).
tramArrive(4, 44460).
tramArrive(4, 45060).
tramArrive(4, 45660).
tramArrive(4, 46260).
tramArrive(4, 46860).
tramArrive(4, 47460).
tramArrive(4, 48060).
tramArrive(4, 48660).
tramArrive(4, 49260).
tramArrive(4, 49860).
tramArrive(4, 50460).
tramArrive(4, 51060).
tramArrive(4, 51660).
tramArrive(4, 52260).
tramArrive(4, 52860).
tramArrive(4, 53460).
tramArrive(4, 54060).
tramArrive(4, 54660).
tramArrive(4, 55260).
tramArrive(4, 55860).
tramArrive(4, 56460).
tramArrive(4, 57060).
tramArrive(4, 57660).
tramArrive(4, 58260).
tramArrive(4, 58860).
tramArrive(4, 59460).
tramArrive(4, 60060).
tramArrive(4, 60660).
tramArrive(4, 61260).
tramArrive(4, 61860).
tramArrive(4, 62460).
tramArrive(4, 63060).
tramArrive(4, 63660).
tramArrive(4, 64260).
tramArrive(4, 64860).
tramArrive(4, 65580).
tramArrive(4, 66180).
tramArrive(4, 66780).
tramArrive(4, 67380).
tramArrive(4, 68880).
tramArrive(4, 69780).
tramArrive(4, 70680).
tramArrive(4, 71580).
tramArrive(4, 72480).
tramArrive(4, 73380).
tramArrive(4, 74280).
tramArrive(4, 22080).
tramArrive(4, 22980).
tramArrive(4, 23880).
tramArrive(4, 24780).
tramArrive(4, 24720).
tramArrive(4, 25320).
tramArrive(4, 25920).
tramArrive(4, 26520).
tramArrive(4, 27120).
tramArrive(4, 27720).
tramArrive(4, 28320).
tramArrive(4, 28920).
tramArrive(4, 29520).
tramArrive(4, 30120).
tramArrive(4, 30720).
tramArrive(4, 31320).
tramArrive(4, 31920).
tramArrive(4, 32520).
tramArrive(4, 33120).
tramArrive(4, 33720).
tramArrive(4, 34320).
tramArrive(4, 34920).
tramArrive(4, 35520).
tramArrive(4, 36120).
tramArrive(4, 36720).
tramArrive(4, 37320).
tramArrive(4, 37920).
tramArrive(4, 38520).
tramArrive(4, 39120).
tramArrive(4, 39720).
tramArrive(4, 40320).
tramArrive(4, 40920).
tramArrive(4, 41520).
tramArrive(4, 42120).
tramArrive(4, 42720).
tramArrive(4, 43320).
tramArrive(4, 43920).
tramArrive(4, 44520).
tramArrive(4, 45120).
tramArrive(4, 45720).
tramArrive(4, 46320).
tramArrive(4, 46920).
tramArrive(4, 47520).
tramArrive(4, 48120).
tramArrive(4, 48720).
tramArrive(4, 49320).
tramArrive(4, 49920).
tramArrive(4, 50520).
tramArrive(4, 51120).
tramArrive(4, 51720).
tramArrive(4, 52320).
tramArrive(4, 52920).
tramArrive(4, 53520).
tramArrive(4, 54120).
tramArrive(4, 54720).
tramArrive(4, 55320).
tramArrive(4, 55920).
tramArrive(4, 56520).
tramArrive(4, 57120).
tramArrive(4, 57720).
tramArrive(4, 58320).
tramArrive(4, 58920).
tramArrive(4, 59520).
tramArrive(4, 60120).
tramArrive(4, 60720).
tramArrive(4, 61320).
tramArrive(4, 61920).
tramArrive(4, 62520).
tramArrive(4, 63120).
tramArrive(4, 63720).
tramArrive(4, 64320).
tramArrive(4, 64920).
tramArrive(4, 65520).
tramArrive(4, 66120).
tramArrive(4, 66720).
tramArrive(4, 67320).
tramArrive(4, 67920).
tramArrive(4, 68520).
tramArrive(4, 69120).
tramArrive(4, 69960).
tramArrive(4, 70860).
tramArrive(4, 71760).
tramArrive(4, 72660).
tramArrive(4, 73560).
tramArrive(4, 74460).
tramArrive(4, 75360).


