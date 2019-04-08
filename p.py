from pyswip import Prolog
from tkinter import *
from tkinter import messagebox

def start():
    #start prolog
    prolog = Prolog()
    prolog.consult("q.pl")
    #create base GUI
    root = Tk()
    root.title("CZ3005 - AI")
    #init input listener
    x = StringVar()
    y = StringVar()
    counter = StringVar()
    counter.set(0)
    category = StringVar()
    category.set("OLYMPIC SPORTS")
    #add category options for users
    choices=["OLYMPIC SPORTS","POKEMON"]
    queries_done = []
    
    #random selection of sports
    #query for selection to store in python
    selected_guess = list(prolog.query("selected(X)"))[0]['X']
    print(selected_guess)

    def handleQuery(event=None):
        if(x.get()!=""):
            if(x.get().lower() in queries_done):
                messagebox.showwarning("Queries done!","has("+x.get().lower()+") was queried!")
            else:
                # format query
                qry = "has("+x.get().lower()+",Out)"
                q_result = prolog.query(qry)
                q_result = list(q_result)[0]
                # get counter to see number of queries left
                counter.set(list(prolog.query("counter(X)"))[0]['X'])
                label_counter.config(text="Number of Queries Left: "+str(10-int(counter.get())))
                
                # Out=0 => query is true, 
                # Out=1 => query is False, 
                # Out=2 counter is more than 10
                if(q_result['Out'] == 0 ):
                    #insert to true listbox
                    hist_listbox_t.insert(END,"has("+x.get().lower()+")")
                    #keep track of queries done to remove duplicate query
                    queries_done.append(x.get().lower())
                elif (q_result['Out'] == 1):
                    #insert to false listbox
                    hist_listbox_f.insert(END,"has("+x.get().lower()+")")
                    #keep track of queries done to remove duplicate query
                    queries_done.append(x.get().lower())
                elif q_result['Out'] == 2:
                    # counter more than 10
                    button_q.config(state=DISABLED)
                    messagebox.showinfo("Guessing Time","You have run out of query!\n Guess now!")
        x.set("") #clear input box after every query

    def change_dropdown(*args):
        # every change of category pick random item
        # FUTURE implementation
        # prolog retract and assert category picked
        print( category.get() )

    def handleGuess():
        if(y.get()!= ""):
            qry = "is("+y.get().lower()+")"
            q_result = prolog.query(qry)
            # true if return {}, false if nothing
            if(list(q_result) == []):
                #WRONG GUESS, give answer, restart game
                messagebox.showinfo("RESULT","You Got It WRONG! Correct answer is "+selected_guess)
                
            else:
                #CORRECT GUESS
                messagebox.showinfo("RESULT","You Got It RIGHT! Congrats")
            restart_game(root)
        y.set("")
        

    def handleAllQuery():
        #create a new small window to display all available query
        list_query = Toplevel()
        list_query.title("All Queries")
        query_listbox = Listbox(list_query)
        query_listbox.config(height=0,width=0)
        #generate list of items
        for each_q in list(prolog.query("flat(X)"))[0]['X']:
            query_listbox.insert(END,"has("+str(each_q)+")")
        query_listbox.pack(fill=BOTH,expand=1,ipadx=80)
        #bind user select on listbox to event listener
        query_listbox.bind('<<ListboxSelect>>',curSelec)
    
    # listbox click event listener
    # update has(X) entry by user click
    def curSelec(evt):
        active_item = evt.widget.get(evt.widget.curselection())
        x.set("".join(list(active_item)[4:-1]))        
    
    def handleAllGuess():
        #create a new small window to display all available guesses
        list_guess = Toplevel()
        list_guess.title("All Guesses")
        guess_listbox = Listbox(list_guess)
        guess_listbox.config(height=0,width=0)
        #generate list of items
        if(category.get() == "OLYMPIC SPORTS"):
            for each_g in list(prolog.query("randomizer_sports(X)"))[0]['X']:
                guess_listbox.insert(END,"is("+str(each_g)+")")
            guess_listbox.pack(fill=BOTH,expand=1,ipadx=80)
        

    # link function to change dropdown as selected
    category.trace('w', change_dropdown)

    #bind enter-key to Query button
    root.bind('<Return>', handleQuery)

    #Creating instances for GUI
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
    guess = Entry(mid_frame,textvariable=y)
    button_guess = Button(mid_frame,text="Guess",command=handleGuess,width=5)
    history_frame = LabelFrame(root,bd=5,relief=GROOVE,text="Queries")
    label_counter = Label(history_frame,text="Number of Queries Left: 10")
    hist_listbox_t = Listbox(history_frame,activestyle=NONE,yscrollcommand=Scrollbar(history_frame,orient=VERTICAL).set)
    label_t = Label(history_frame, text = "True")
    hist_listbox_f = Listbox(history_frame,activestyle=NONE,yscrollcommand=Scrollbar(history_frame,orient=VERTICAL).set)
    label_f = Label(history_frame, text = "False")
    button_all_query = Button(history_frame,text="All Queries",command=handleAllQuery,width=5)
    button_all_guess = Button(history_frame,text="Guesses",command=handleAllGuess,width=5)
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
    guess.grid(row=1,column=1)
    label_is2.grid(row=1,column=2,sticky=W)
    button_guess.grid(row=1,column=4,sticky=E,padx=(20,0))
    #hist Frame
    history_frame.grid(row=4, columnspan=5,sticky= N+E+W+S)
    label_counter.grid(row=0,columnspan=2)
    label_t.grid(row=1)
    label_f.grid(row=1,column=1)
    hist_listbox_t.grid(row=2)
    hist_listbox_f.grid(row=2,column=1)

    button_all_query.grid(row=3,sticky= N+E+W+S)
    button_all_guess.grid(row=3,column=1,sticky= N+E+W+S)
    
    root.mainloop()


def restart_game(root):
    messagebox.showinfo("Restart","Game restarting!")
    root.destroy()
    start()

start()
