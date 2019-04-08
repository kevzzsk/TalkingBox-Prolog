# TalkingBox-Prolog

Talking box in Prolog and Python wrapper as GUI with tkinter

## Overview 
Game : 10 Questions

Prolog will choose a random sport, then user will have to guess it by asking maximum of 10 questions. Prolog can only answer yes/no.

## Starting Program
Build for windows (tested for Win 10). Linux system will not be able to run the program.

compiled by pyinstaller: `pyinstaller -D -w --add-data q.pl;. p.py `

ps. compiling as one file (-F) will not work!


There are three methods to start the program

### First Method 
The program is compiled and build into .exe

go to `dist\p` and click on `p.exe` to run


### Second Method
Running the program using cmd and python virtualenv.

Activate virtualenv: `> python-lab/Scripts/activate`

run python script: `> python p.py`

To deactivate virtualenv: `> deactivate`

### Third Method
This method will work with any OS. 

Ensure python is downloaded (python 3.7.3 is tested to work).

download dependencies `> pip install pyswip`

run python script:  `> python p.py`

## Extra

Dependencies: pyswip (pip3 install pyswip)

Python source code : p.py

Prolog source code : q.pl