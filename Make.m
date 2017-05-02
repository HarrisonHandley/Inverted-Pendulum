clc
clear

% introduction
disp('Welcome to EPOS2 library')
disp('Eugenio Yime, 2015')

% detecting computer
str = computer;
win64 = strcmp(str, 'PCWIN64');
win32 = strcmp(str, 'PCWIN32');
lin64 = strcmp(str, 'GLNXA64');
lin32 = strcmp(str, 'GLNXA32');

% is it possible to compile the source code ?
if ~(win32 || win64 || lin32 || lin64)
    error('Sorry, this library only supports Windows and Linux')
end

% all the code to compile
sourcecode = { ' GetAllDigitalInputs.c' };

% for Linux computer
if ( lin32 || lin64  )
    disp('.. Compiling for a Linux computer')
    % directory to include files
    includedir = './Epos2Linux';
    % library name
    libeposname = 'EposCmd';
    % definitions for right compilation
    definitions = '_LINUX_';
end
% for Windows computer
if ( win32  || win64  )
    disp('.. Compiling for a Windows computer')
    % directory to include files
    includedir = '.\Epos2Windows';
    % library name
    if (win32==1)
        libeposname = 'EposCmd';
    else
        libeposname = 'EposCmd64';
    end
    % definitions
    definitions = 'WINDOWS';
end

% compile each file
for i=1:size(sourcecode, 2)
    strcmd = strcat('mex', sourcecode(:,i), ' -D', definitions, ' -I', ...
        includedir, ' -L', includedir, ' -l', libeposname); 
    eval( char(strcmd) )
end
disp('.. finishing compiling')

% add directory to path
disp('.. adding directory to path')
dirtopath = cd;
addpath( dirtopath );
if ( win32 || win64 )
    % copy dlls and lib to actual directory
    copyfile('.\Epos2Windows\*.dll', '.', 'f');
    copyfile('.\Epos2Windows\*.lib', '.', 'f');
end
disp('.. done, you can now use this library')

% some help
disp('Please, use the command: >> savepath')
disp('if you want to permanently add the source code directory to Matlab')
