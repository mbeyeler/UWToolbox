function [keyPressed] = wait4key(keys, deviceNum)
% [keyPressed] = wait4key(keys, deviceNum)
%
% Waits for the any specified 'keys' to be pressed.
%
% Inputs:
%   keys             Keys to wait for, string or cell array of strings
%                    (default: 't')
%
%   deviceNum        Device number to wait for the specified key(s) press
%                    (default: -3,  for all keyboard devices, see KBCHECK.m 
%                    for additional information about keyboard querying 
%                    numbers)
%
% Output:
%   keyPressed       Which key was pressed, string
%
% Note:
% - Dependencies: <a href="matlab: web('http://psychtoolbox.org/')">Psychtoolbox</a>

% Written by Kelly Chang - September 14, 2016

%% Input Control

if ~exist('keys', 'var')
    keys = {'t'};
end

if ischar(keys)
    keys = {keys};
end

if ~exist('deviceNum', 'var')
    deviceNum = -3;
end

%% Check Keyboard

keyIsDown = KbCheck(deviceNum); % waits until nothing is being pressed
while keyIsDown
    keyIsDown = KbCheck(deviceNum);
end

if ~exist('keys', 'var') % if no key(s) specified, wait for anything
    [~,~,keyCode] = KbCheck(deviceNum);
    while ~any(keyCode)
        [~,~,keyCode] = KbCheck(deviceNum);
    end
else % if key is specified
    [~,~,keyCode] = KbCheck(deviceNum);
    while ~any(strcmp(KbName(keyCode), keys))
        [~,~,keyCode] = KbCheck(deviceNum);
    end
end
keyPressed = KbName(keyCode); % return  which key was pressed