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

#const startTime = 1.
#const endTime = 1000.
#const startRH1 = 200.
#const endRH1 = 300.
#const startRH2 = 700.
#const endRH2 = 900.
#const maxRed = 120.
#const minConflictTime = 3.
% facts
trafficLight(1..16).
time(startTime..endTime).

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constraint: Minimal green phase (a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if ped. traffic light turns green, it stays green for X seconds
 green(L,T+1), green(L,T+2), green(L,T+3), green(L,T+4), green(L,T+5), green(L,T+6), green(L,T+7), green(L,T+8), green(L,T+9), green(L,T+10), green(L,T+11), green(L,T+12), green(L,T+13), green(L,T+14), green(L,T+15), green(L,T+16), green(L,T+17), green(L,T+19) :- not green(L,T-1), green(L,T), L=9, T<endTime-19.
 green(L,T+1), green(L,T+2), green(L,T+3), green(L,T+4), green(L,T+5), green(L,T+6)  :- not green(L,T-1), green(L,T), L=10, T<endTime-6.
 green(L,T+1), green(L,T+2), green(L,T+3), green(L,T+4), green(L,T+5), green(L,T+6)  :- not green(L,T-1), green(L,T), L=11, T<endTime-6.
 green(L,T+1), green(L,T+2), green(L,T+3), green(L,T+4), green(L,T+5), green(L,T+6), green(L,T+7) :- not green(L,T-1), green(L,T), L=12, T<endTime-7.
 green(L,T+1), green(L,T+2), green(L,T+3), green(L,T+4), green(L,T+5), green(L,T+6), green(L,T+7) :- not green(L,T-1), green(L,T), L=13, T<endTime-7.
 green(L,T+1), green(L,T+2), green(L,T+3), green(L,T+4), green(L,T+5), green(L,T+6), green(L,T+7) :- not green(L,T-1), green(L,T), L=14, T<endTime-7.
 green(L,T+1), green(L,T+2), green(L,T+3), green(L,T+4), green(L,T+5), green(L,T+6), green(L,T+7), green(L,T+8)  :- not green(L,T-1), green(L,T), L=15, T<endTime-8.
 green(L,T+1), green(L,T+2), green(L,T+3), green(L,T+4), green(L,T+5), green(L,T+6), green(L,T+7), green(L,T+8)  :- not green(L,T-1), green(L,T), L=16, T<endTime-8.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constraint: No accidents (b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% constraints
:- green(L1, T), conflict(L1, L2), green(L2, T).
not green(L2, T+1), not green(L2, T+2), not green(L2, T+3) :- green(L1, T), conflict(L1, L2), T<endTime -3 .
% car-car conflicts facts
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constraint (c): Ped can cross the street
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% constraint See (b)

% ped-car conflicts facts
conflict(8, 14).
conflict(8, 16).

conflict(7, 9).
conflict(7, 11).
conflict(7, 16).

conflict(6, 11).
conflict(6, 12).

conflict(5, 9).
conflict(5, 12).
conflict(5, 15).

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constraint: Maximal red phase (d) Unbekannt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if traffic light turns red
% -> it is not allowed to stay red for more than 120 seconds

:- maxRed { not green(L, T..T+maxRed-1) } maxRed, trafficLight(L), time(T), T< endTime - maxRed.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constraint Tram has priority (e)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if tram arrives -> green
% Tram 4
not green(6, T), not green(2, T), not green(9, T), not green(13, T), not green(3, T), not green(4, T), not green(7, T), not green(8, T) :- tramArrive(41, T), time(T).
not green(6, T), not green(2, T), not green(9, T), not green(13, T), not green(3, T), not green(4, T), not green(7, T), not green(8, T) :- tramArrive(42, T), time(T).

% Tram 10
not green(6, T), not green(2, T), not green(9, T), not green(13, T), not green(3, T), not green(4, T), not green(7, T), not green(8, T) :- tramArrive(101, T), time(T).
not green(6, T), not green(2, T), not green(9, T), not green(13, T), not green(3, T), not green(4, T), not green(7, T), not green(8, T) :- tramArrive(102, T), time(T).

% Bus 64
green(5, T) :- tramArrive(641, T), time(T).
green(1, T) :- tramArrive(642, T), time(T).

% Bus 63
green(6, T) :- tramArrive(631, T), time(T).
green(3, T) :- tramArrive(632, T), time(T).

#include "tram.lp".


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constraint rush hour (g)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rush hour 1
numCars(X) :- X = #sum { C : carsPerSeconds(L,C), green(L,T), trafficLight(L), time(T), T=startRH1..endRH1, L!=1, L!=5 }.
#maximize { X@1 : numCars(X) }.

numCarsB(X) :- X = #sum { C : carsPerSeconds(1,C), green(1,T), time(T), T=startRH1..endRH1 }.
#maximize { X@2 : numCarsB(X) }.

numCarsS(X) :- X = #sum { C : carsPerSeconds(5,C), green(5,T), time(T), T=startRH1..endRH1 }.
#maximize { X@2 : numCarsS(X) }.

% rush hour 2
numCars(X) :- X = #sum { C : carsPerSeconds(L,C), green(L,T), trafficLight(L), time(T), T=startRH2..endRH2, L!=1, L!=5 }.
#maximize { X@1 : numCars(X) }.

numCarsB(X) :- X = #sum { C : carsPerSeconds(1,C), green(1,T), time(T), T=startRH2..endRH2 }.
#maximize { X@2 : numCarsB(X) }.

numCarsS(X) :- X = #sum { C : carsPerSeconds(5,C), green(5,T), time(T), T=startRH2..endRH2 }.
#maximize { X@2 : numCarsS(X) }.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constraint normal hours (h)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% normal hours 1
cnt(X) :- X = #count { L,T : not green(L,T), trafficLight(L), time(T), T=startTime..startRH1-1, L!=1, L!=5 }.
#minimize { X@1 : cnt(X) }.

cntB(X) :- X = #count { T : not green(1,T), trafficLight(1), time(T), T=startTime..startRH1-1 }.
#minimize { X@2 : cntB(X) }.

cntS(X) :- X = #count { T : not green(5,T), trafficLight(5), time(T), T=startTime..startRH1-1 }.
#minimize { X@2 : cntS(X) }.

% normal hours 2
cnt(X) :- X = #count { L,T : not green(L,T), trafficLight(L), time(T), T=endRH1+1..startRH2-1, L!=1, L!=5 }.
#minimize { X@1 : cnt(X) }.

cntB(X) :- X = #count { T : not green(1,T), trafficLight(1), time(T), T=endRH1+1..startRH2-1 }.
#minimize { X@2 : cntB(X) }.

cntS(X) :- X = #count { T : not green(5,T), trafficLight(5), time(T), T=endRH1+1..startRH2-1 }.
#minimize { X@2 : cntS(X) }.

% normal hours 3
cnt(X) :- X = #count { L,T : not green(L,T), trafficLight(L), time(T), T=endRH2+1..endTime, L!=1, L!=5 }.
#minimize { X@1 : cnt(X) }.

cntB(X) :- X = #count { T : not green(1,T), trafficLight(1), time(T), T=endRH2+1..endTime }.
#minimize { X@2 : cntB(X) }.

cntS(X) :- X = #count { T : not green(5,T), trafficLight(5), time(T), T=endRH2+1..endTime }.
#minimize { X@2 : cntS(X) }.