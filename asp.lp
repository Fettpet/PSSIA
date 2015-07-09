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

#const maxTime = 1000.
#const maxRed = 120.

% facts
trafficLight(1..16).
time(1..maxTime).


carsPerSeconds(1,1030).
carsPerSeconds(2,1278).
carsPerSeconds(3,560).
carsPerSeconds(4,1420).
carsPerSeconds(5,300).
carsPerSeconds(6,640).
carsPerSeconds(7,1125).
carsPerSeconds(8,880).


% generate
{green(L, T) : trafficLight(L), time(T)}.
{conflict(L1, L2) : trafficLight(L1), trafficLight(L2)}.

%let there be time
%follow(T1, T2) :- time(T1), time(T2), T1+1=T2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Constraint: Minimal Green phase (a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Error since it use seconds insteand of half minute
% Error not insteand of -
% if ped. traffic light turns green, it stays green for X seconds
%20 {green(L,T..T+19)} 20 :- not green(L,T-1), green(L,T), L=9.
% 7 {green(L,T..T+ 6)}  7 :- not green(L,T-1), green(L,T), L=10.
% 7 {green(L,T..T+ 6)}  7 :- not green(L,T-1), green(L,T), L=11.
% 8 {green(L,T..T+ 7)}  8 :- not green(L,T-1), green(L,T), L=12.
% 8 {green(L,T..T+ 7)}  8 :- not green(L,T-1), green(L,T), L=13.
% 8 {green(L,T..T+ 7)}  8 :- not green(L,T-1), green(L,T), L=14.
% 9 {green(L,T..T+ 8)}  9 :- not green(L,T-1), green(L,T), L=15.
% 9 {green(L,T..T+ 8)}  9 :- not green(L,T-1), green(L,T), L=16.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Constraint: No accidents (b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constraints
:-  green(L1, T), conflict(L1, L2), green(L2, T).
 
 
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
% if traffic light turns red, it is not allowed to stay red for more than 120 seconds

:- maxRed{ not green(L, T..T+maxRed-1)}maxRed, trafficLight(L), time(T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%						Constraint Tram has priority (e)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Contraints
%Tram 4
not green(6, T), not green(2, T), not green(9, T), not green(13, T), not green(3, T), not green(4, T), not green(7, T), not green(8, T) :- tramArrive(41, T), time(T).
not green(6, T), not green(2, T), not green(9, T), not green(13, T), not green(3, T), not green(4, T), not green(7, T), not green(8, T) :- tramArrive(42, T), time(T).

%Tram 10
not green(6, T), not green(2, T), not green(9, T), not green(13, T), not green(3, T), not green(4, T), not green(7, T), not green(8, T) :- tramArrive(101, T), time(T).
not green(6, T), not green(2, T), not green(9, T), not green(13, T), not green(3, T), not green(4, T), not green(7, T), not green(8, T) :- tramArrive(102, T), time(T).

%bus 64
green(5, T) :- tramArrive(641, T), time(T).
green(1, T) :- tramArrive(642, T), time(T).

%bus 63
green(6, T) :- tramArrive(631, T), time(T).
green(3, T) :- tramArrive(632, T), time(T).

#include "tram.lp".


