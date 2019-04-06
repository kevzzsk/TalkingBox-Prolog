from __future__ import print_function
from pyswip import Prolog
from tkinter import *
from tkinter import messagebox

def start():
    prolog = Prolog()
    prolog.consult("q.pl")
    #create base GUI
    root = Tk()
    #init input listener
    x = StringVar()
    y = StringVar()
    category = StringVar()
    category.set("OLYMPIC SPORTS")
    #add choice to category list
    choices=["OLYMPIC SPORTS","POKEMON"]


    #random selection of sports
    #query for selection to store in python
    selected = "tennis"


    def handleQuery(event=None):
        if(x.get()!=""):
            # get number of queries left
            counter = list(prolog.query("counter(X)",1))[0]['X']
            if (counter < 10):
                # format query
                qry = "has("+x.get().lower()+")"
                q_result = prolog.query(qry)
                # true if return {}, false if nothing
                if(list(q_result) == []):
                    #insert to false listbox
                    hist_listbox_f.insert(END,qry)
                    
                else:
                    #insert to true listbox
                    hist_listbox_t.insert(END,qry)

            else:
                # counter > 10
                # Force disable query
                # msg to guess
                print("counter more than 10")
                button_q.config(state=DISABLED)
                messagebox.showinfo("Guessing Time","You have run out of query!\n Guess now!")
                pass
        x.set("")

    def change_dropdown(*args):
        print( category.get() )

    def handleSubmit():
        if(y.get()!= ""):
            qry = "is("+y.get().lower()+")"
            q_result = prolog.query(qry)
            # true if return {}, false if nothing
            if(list(q_result) == []):
                #WRONG GUESS, give answer, restart game
                messagebox.showinfo("RESULT","You Got It WRONG!")
                
            else:
                #CORRECT GUESS
                messagebox.showinfo("RESULT","You Got It RIGHT! Congrats")
        y.set("")
        restart_game(root)

        
    # link function to change dropdown
    category.trace('w', change_dropdown)

    #bind enter to Query button
    root.bind('<Return>', handleQuery)

    label_title = Label(root, text="10 Questions",font=("Roboto",30))
    label_category = Label(root, text="Category",font=("Roboto",18))
    menu_cat = OptionMenu(root, category,*choices )
    mid_frame = Frame(root)
    label_has = Label(mid_frame, text = "has(")
    label_has2 = Label(mid_frame, text = ")?")
    query = Entry(mid_frame,textvariable=x)
    button_q = Button(mid_frame,text="Query", command=handleQuery,width=5)
    label_is = Label(mid_frame, text = "is(")
    label_is2 = Label(mid_frame, text = ")?")
    submit = Entry(mid_frame,textvariable=y)
    button_is = Button(mid_frame,text="Submit",command=handleSubmit,width=5)
    history_frame = LabelFrame(root,bd=5,relief=GROOVE,text="Queries")
    hist_listbox_t = Listbox(history_frame,activestyle=NONE,yscrollcommand=Scrollbar(history_frame,orient=VERTICAL).set)
    label_t = Label(history_frame, text = "True")
    hist_listbox_f = Listbox(history_frame,activestyle=NONE,yscrollcommand=Scrollbar(history_frame,orient=VERTICAL).set)
    label_f = Label(history_frame, text = "False")

    label_title.grid(row=0,columnspan=5,sticky= N+E+W+S)

    label_category.grid(row=1,columnspan=5,sticky=S)
    #dropdown menu
    menu_cat.grid(row=2, columnspan=5,sticky= N+E+W+S)

    #mid Frame
    mid_frame.grid(row=3,columnspan=5,sticky= N+E+W+S)
    label_has.grid(row=0,sticky=E,padx=(20,0))
    query.grid(row=0,column=1)
    label_has2.grid(row=0,column=2,sticky=W)
    button_q.grid(row=0,column=4,sticky=E,padx=(20,0))
    label_is.grid(row=1,sticky=E,padx=(20,0))
    submit.grid(row=1,column=1)
    label_is2.grid(row=1,column=2,sticky=W)
    button_is.grid(row=1,column=4,sticky=E,padx=(20,0))
    #hist Frame
    history_frame.grid(row=4, columnspan=5,sticky= N+E+W+S)
    label_t.grid(row=0)
    label_f.grid(row=0,column=1)
    hist_listbox_t.grid(row=1)
    hist_listbox_f.grid(row=1,column=1)
    root.mainloop()


def restart_game(root):
    root.destro()
    start()

start()
