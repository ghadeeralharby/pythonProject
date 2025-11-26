import tkinter as tk
from tkinter import messagebox, Entry
from dataBase import *
from dataBase import engine
from dataBase import db
import dataBase

###########################################


class loginwindow:
    def __init__(self):
        self.login_window = tk.Toplevel()
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

    def logintodb(self):
        conn = engine.connect()  ##############################################################3

        id1 = (self.entry_1L.get().strip())
        password= str(self.entry_2P.get().strip())
        if len(id1) != 10 or not id1.isdigit():
            id1 = ''
            messagebox.showinfo("ID Number error!", "Re-enter an ID number properly\rthat consists of 10 digits")
            return

        else:
            #  query = db.select(Students).where(
            #(Students.c.Student_id == int(id1)) &
            # (Students.c.Password == self.entry_2P.get()))
            result = dataBase.login_check(int(id1), password)
            check = result

            if check is None:
                messagebox.showinfo("Error", "Invalid ID or password ")

            else:
                if id1 == '1111111111':
                    self.open_adminwindow()
                else:
                    self.open_StudentWalletWindow(check)

        conn.close()  ##################################################

    def open_StudentWalletWindow(self, check):
        from StudentWallet import studentWalletWindow

        student_id = check[0]
        fname = check[1]
        lname = check[2]

        student_name = fname + " " + lname

        wallet = get_wallet(student_id)
        wallet_number = wallet[0]
        balance = wallet[2]

        self.login_window.destroy()
        studentWalletWindow(student_id, student_name, wallet_number, balance)

    def open_adminwindow(self):
        from Admin import AdminWindow
        self.login_window.destroy()
        AdminWindow()
