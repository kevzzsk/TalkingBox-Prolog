# TalkingBox-Prolog

Talking box in Prolog and Python wrapper as GUI with tkinter

### Overview 
Game : 10 Questions

Prolog will choose a random sport, then user will have to guess it by asking maximum of 10 questions. Prolog can only answer yes/no.

# Starting Program
Build for windows (tested for Win 10)

compiled by pyinstaller

`pyinstaller -D -w --add-data q.pl;. p.py `

ps. compiling as one file (-F) will not work!

Linux system will not be able to run the program.

There are two ways to start the program

## First way 
The program is compiled and build into .exe

go to `dist\p` and click on `p.exe` to run


## Second way
Running the program using cmd and python virtualenv.

Activate virtualenv: `> python-lab/Scripts/activate`

virtualenv is set up with pyswip

run python script: `> python p.py`

To deactivate virtualenv: `> deactivate`


# Extra

Dependencies: pyswip (pip3 install pyswip)

Python source code : p.py

Prolog source code : q.pl