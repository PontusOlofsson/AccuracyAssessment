%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Script for estimating accuracy and area of the sample data in Stehman (2013). 
% Runs in GNU Octave (https://www.gnu.org/software/octave/) and Matlab. Use Cygwin 
% to run GNU Octave in Windows. 
% 
% Stehman, S. V. (2014). Estimating area and map accuracy for stratified random 
% sampling when the strata are different from the map classes. International  
% Journal of Remote Sensing, 35(13), 4923-4939.
%
% Pontus Olofsson, 11/20/2104
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clear all

%%% INPUT %%%

% Area of strata [pixels]
N_1 = 40000;
N_2 = 30000;
N_3 = 20000;
N_4 = 10000;
N = N_1 + N_2 + N_3 + N_4;

% Read strata, reference labels and map labels
[h,a,b] = textread('steves_sample_data.txt','%u %s %s');

% Convert labels to characters
map = char(a);
ref = char(b);

% Calculate sample size per stratum
n_1 = size(h(h==1),1);
n_2 = size(h(h==2),1);
n_3 = size(h(h==3),1);
n_4 = size(h(h==4),1);

%%% AREA %%%

% Area proportion of class A
yap1 = size(h(h(:) == 1 & ref(:) == 'A'),1);
yap2 = size(h(h(:) == 2 & ref(:) == 'A'),1);
yap3 = size(h(h(:) == 3 & ref(:) == 'A'),1);
yap4 = size(h(h(:) == 4 & ref(:) == 'A'),1);

yam1 = size(h(h(:) == 1 & map(:) == 'A'),1);
yam2 = size(h(h(:) == 2 & map(:) == 'A'),1);
yam3 = size(h(h(:) == 3 & map(:) == 'A'),1);
yam4 = size(h(h(:) == 4 & map(:) == 'A'),1);

% Standard error of area 2000-2011
s_1 = (yap1)*((1-yap1/n_1)^2/(n_1-1))+(n_1-yap1)*((-yap1/n_1)^2/(n_1-1));
s_2 = (yap2)*((1-yap2/n_2)^2/(n_2-1))+(n_2-yap2)*((-yap2/n_2)^2/(n_2-1));
s_3 = (yap3)*((1-yap3/n_3)^2/(n_3-1))+(n_3-yap3)*((-yap3/n_3)^2/(n_3-1));
s_4 = (yap4)*((1-yap4/n_4)^2/(n_4-1))+(n_4-yap4)*((-yap4/n_4)^2/(n_4-1));

v = (1/N^2)*(N_1^2*s_1/n_1 + N_2^2*s_2/n_2 + N_3^2*s_3/n_3 + N_4^2*s_4/n_4);
s = sqrt(v);

% Estimated area
ap = (N_1*yap1/n_1 + N_2*yap2/n_2 + N_3*yap3/n_3 + N_4*yap4/n_4)/N;
apci = [ap 2*s];

% Mapped area
am = (N_1*yam1/n_1 + N_2*yam2/n_2 + N_3*yam3/n_3 + N_4*yam4/n_4)/N;

%%% ACCURACY %%%

% Overall accuracy
yoa1 = size(h(h(:) == 1 & map(:) == 'A' & ref(:) == 'A'),1) +...
       size(h(h(:) == 1 & map(:) == 'B' & ref(:) == 'B'),1) +...
       size(h(h(:) == 1 & map(:) == 'C' & ref(:) == 'C'),1) +...
       size(h(h(:) == 1 & map(:) == 'D' & ref(:) == 'D'),1);
yoa2 = size(h(h(:) == 2 & map(:) == 'A' & ref(:) == 'A'),1) +...
       size(h(h(:) == 2 & map(:) == 'B' & ref(:) == 'B'),1) +...
       size(h(h(:) == 2 & map(:) == 'C' & ref(:) == 'C'),1) +...
       size(h(h(:) == 2 & map(:) == 'D' & ref(:) == 'D'),1);
yoa3 = size(h(h(:) == 3 & map(:) == 'A' & ref(:) == 'A'),1) +...
       size(h(h(:) == 3 & map(:) == 'B' & ref(:) == 'B'),1) +...
       size(h(h(:) == 3 & map(:) == 'C' & ref(:) == 'C'),1) +...
       size(h(h(:) == 3 & map(:) == 'D' & ref(:) == 'D'),1);
yoa4 = size(h(h(:) == 4 & map(:) == 'A' & ref(:) == 'A'),1) +...
       size(h(h(:) == 4 & map(:) == 'B' & ref(:) == 'B'),1) +...
       size(h(h(:) == 4 & map(:) == 'C' & ref(:) == 'C'),1) +...
       size(h(h(:) == 4 & map(:) == 'D' & ref(:) == 'D'),1);

oa = (N_1*yoa1/n_1 + N_2*yoa2/n_2 + N_3*yoa3/n_3 + N_4*yoa4/n_4)/N;

% User's accuracy of class B
yua1 = size(h(h(:) == 1 & map(:) == 'B' & ref(:) == 'B'),1);
yua2 = size(h(h(:) == 2 & map(:) == 'B' & ref(:) == 'B'),1);
yua3 = size(h(h(:) == 3 & map(:) == 'B' & ref(:) == 'B'),1);
yua4 = size(h(h(:) == 4 & map(:) == 'B' & ref(:) == 'B'),1);

xua1 = size(h(h(:) == 1 & map(:) == 'B'),1);
xua2 = size(h(h(:) == 2 & map(:) == 'B'),1);
xua3 = size(h(h(:) == 3 & map(:) == 'B'),1);
xua4 = size(h(h(:) == 4 & map(:) == 'B'),1);

ua = (N_1*yua1/n_1 + N_2*yua2/n_2 + N_3*yua3/n_3 + N_4*yua4/n_4) / (N_1*xua1/n_1 + N_2*xua2/n_2 + N_3*xua3/n_3 + N_4*xua4/n_4);

% Producer's accuracy of class B
xpa1 = size(h(h(:) == 1 & ref(:) == 'B'),1);
xpa2 = size(h(h(:) == 2 & ref(:) == 'B'),1);
xpa3 = size(h(h(:) == 3 & ref(:) == 'B'),1);
xpa4 = size(h(h(:) == 4 & ref(:) == 'B'),1);

pa = (N_1*yua1/n_1 + N_2*yua2/n_2 + N_3*yua3/n_3 + N_4*yua4/n_4) / (N_1*xpa1/n_1 + N_2*xpa2/n_2 + N_3*xpa3/n_3 + N_4*xpa4/n_4);

%%% RESULTS %%%

disp(' ')
disp(' ')
disp('*** AREA ***')
disp('Estimated area of A +- 95% CI')
disp(apci)
disp('Mapped area of A')
disp(am)
disp(' ')
disp('*** ACCURACY ***')
disp('Overall accuracy')
disp(oa)
disp(' ')
disp('Users accuracy of B')
disp(ua)
disp(' ')
disp('Producers accuracy of B')
disp(pa)
