# in seconds
timeDuration = 30 
startTime = (1 / timeDuration) * 6 * 60 * 60
endTime = (1 / timeDuration) * 21 * 60 * 60




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
trafficLightCars(1..8).
trafficLightPed(9..16).
time({:.0f}..{:.0f}).

%let there be time
follow(T1, T2) :- time(T1), time(T2), T1+1=T2.


% generate
green(L, T) :- trafficLightCars(L), time(T).
green(L, T) :- trafficLightPed(L), time(T).


% define
% if ped. traffic light turns green, it stays green for X seconds
20 {{green(L,T..T+20)}} 20 :- -green(L,T-1), green(L,T), L=9.
 7 {{green(L,T..T+ 7)}}  7 :- -green(L,T-1), green(L,T), L=10.
 7 {{green(L,T..T+ 7)}}  7 :- -green(L,T-1), green(L,T), L=11.
 8 {{green(L,T..T+ 8)}}  8 :- -green(L,T-1), green(L,T), L=12.
 8 {{green(L,T..T+ 8)}}  8 :- -green(L,T-1), green(L,T), L=13.
 8 {{green(L,T..T+ 8)}}  8 :- -green(L,T-1), green(L,T), L=14.
 9 {{green(L,T..T+ 9)}}  9 :- -green(L,T-1), green(L,T), L=15.
 9 {{green(L,T..T+ 9)}}  9 :- -green(L,T-1), green(L,T), L=16.

% if traffic light turns red, it is not allowed to stay red for more than 120 seconds
%lengthGreen(L,T,X=1) :- -green(L,T-1), green(L,T), green(L,T+1).
%lengthGreen(L,T,X+1) :- green(L,T+1), lengthGreen(L,T,X).
%:- lengthGreen(L,T,X), X > 120.

""".format(startTime, endTime)



fh = open("asp.lp", "w")
fh.write(asp)
fh.close()

print(asp)
