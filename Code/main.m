%{
MIT License

Copyright (c) 2018 J. C. (Jack) Cook

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
%}
%% Main.m for PlottingClass
% initialize the class
a = PlottingClass;


% ------------ Inputs ------------- %
% name of current .mat to be processed
date = '/18_11_20';
file = '/11202018_200547_UTC.mat';
% range
a.Range = [0.25, 0.50];
% red lines
a.right = [13,13];
a.left = [8,8];

% stem plot top
a.ytop = 0.05;

% show figures or dont show figures
show = 0;
if show == 0
    a.figs = 'off';
else
    a.figs = 'on';
end 
% --------------------------------- %

filename = strcat(date, file);

a.cut = -200;

% guess radius
a.Rguess = 5;

% ------- Paths --------- %
% path to dir with .mat
path = pwd;
new = extractBefore(path, 'Code');
path2 = strcat(new, 'Data');
a.path = path2;
 
% location for the images
a.imagedir = extractBefore(a.path, "Data");

% make a file path to be found
filepath = strcat(new, '/Data', filename);
% the data is an object
S = load(filepath);
% we want the instance rdata inside of sp
rawdata = S.SP.rData;
% name for saving plots
newStr = extractBefore(filename,".");
% take the / out of the location path
a.newname = newStr(2:end);
% get the data from the microphones 
a.R1 = rawdata(1:1:end,1);
a.R2 = rawdata(1:1:end,2);
a.R3 = rawdata(1:1:end,3);

% call the function plotting to display the results of the recording
a.Data();

% setup data for lowpass filter
all = rawdata(:,:);
% call lowpass, filter and plot the data

a.filtering(all);

% do some fft stuff
a.Perform()
