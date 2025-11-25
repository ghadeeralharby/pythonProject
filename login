import tkinter as tk
from tkinter import messagebox, Entry
from dataBase import *
from dataBase import engine
from dataBase import db

###########################################


class loginwindow:
    def __init__(self):
        self.login_window = tk.Tk()
        self.login_window.configure(bg='lightgray')
        self.login_window.geometry('500x500')
        self.login_window.title("LogIn")

        label_0 = tk.Label(self.login_window, text="log in ", width=20, font=("bold", 20))
        label_0.place(x=90, y=53)

        self.label_1L = tk.Label(self.login_window, text="ID :", width=20, font=("bold", 10))
        self.label_1L.place(x=90, y=130)
        self.entry_1L = tk.Entry(self.login_window)
        self.entry_1L.place(x=240, y=130)

        self.label_2P = tk.Label(self.login_window, text="Password :", width=20, font=("bold", 10))
        self.label_2P.place(x=90, y=180)
        self.entry_2P = tk.Entry(self.login_window)
        self.entry_2P.place(x=240, y=180)

        login = tk.Button(self.login_window, text="log in", command=self.logintodb)
        login.place(x=240, y=300)
        self.login_window.mainloop()

    def logintodb(self):
         conn = engine.connect ()  ##############################################################3

         id1 = str(self.entry_1L.get())
         if len(id1 )!= 10 or not id1.isdigit():
             id1 = ''
             messagebox.showinfo("ID Number error!", "Re-enter an ID number properly\rthat consists of 10 digits")
         else:
             query = db.select([Students]).where(
                 (Students.c.Student_id == int(id1)) &
                 (Students.c.Password == self.entry_2P.get()))
             result = conn.execute(query)
             check = result.fetchone()
             if check is None:
               messagebox.showinfo("Error", "Invalid ID or password ")

             else:
                 if self.entry_1L.get() == '1111111111':
                    self.goAdmin()
                 else:
                    self.goWallet()

         conn.close()  ##################################################


    def goWallet(self):
        global l
        l=self.entry_1L.get()
        self.entry_1L=l
        self.login_window.destroy()
        self.StudentWalletWindow()
    def goAdmin(self):
        self.login_window.destroy()
        self.AdminWindow()


    def goAdmin(self) :
         messagebox.showinfo("Success", "Going to Admin ...")
    def goWallet(self):
         messagebox.showinfo("Success", "Going to Wallet...")



if __name__=="__main__":
    loginwindow()
