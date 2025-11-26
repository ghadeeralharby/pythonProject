import tkinter as tk
from tkinter import messagebox
from dataBase import *
import dataBase


class loginwindow:
    def __init__(self):
        self.login_window = tk.Toplevel()
        self.login_window.title("Login Window")
        self.login_window.geometry("400x350")


        title_label = tk.Label(self.login_window, text="Log In")
        title_label.pack(pady=15)


        form_frame = tk.LabelFrame(self.login_window, text="Enter Your Credentials", padx=10, pady=10)
        form_frame.pack(pady=20, padx=20, fill="both")


        self.label_1L = tk.Label(form_frame, text="ID:")
        self.label_1L.grid(row=0, column=0, sticky="w", pady=8, padx=5)


        self.entry_1L = tk.Entry(form_frame, width=25)
        self.entry_1L.grid(row=0, column=1, pady=8, padx=5)


        self.label_2P = tk.Label(form_frame, text="Password:")
        self.label_2P.grid(row=1, column=0, sticky="w", pady=8, padx=5)


        self.entry_2P = tk.Entry(form_frame, width=25, show="*")
        self.entry_2P.grid(row=1, column=1, pady=8, padx=5)

        button_frame = tk.Frame(self.login_window)
        button_frame.pack(pady=15)


        login_btn = tk.Button(button_frame, text="Log In", width=10, command=self.logintodb)
        login_btn.grid(row=0, column=0, padx=10)


        back_btn = tk.Button(button_frame, text="Back", width=10, command=self.back_to_signup)
        back_btn.grid(row=0, column=1, padx=10)



    def logintodb(self):
        conn = engine.connect()

        id1 = self.entry_1L.get().strip()
        password = self.entry_2P.get().strip()


        if len(id1) != 10 or not id1.isdigit():
            messagebox.showinfo("ID Number error!", "Re-enter an ID number properly\nthat consists of 10 digits")
            conn.close()
            return


        result = dataBase.login_check(int(id1), password)
        check = result

        if check is None:
            messagebox.showinfo("Error", "Invalid ID or password ")
        else:

            if id1 == "1111111111":
                self.open_adminwindow()
            else:
                self.open_StudentWalletWindow(check)

        conn.close()



    def open_StudentWalletWindow(self, check):
        from student_wallet_window import studentWalletWindow

        student_id = check[0]           # Student_id
        fname = check[1]                # First name
        lname = check[2]                # Last name
        student_name = fname + " " + lname

        wallet = get_wallet(student_id)
        wallet_number = wallet[0]       # wId
        balance = wallet[2]             # Balance

        self.login_window.destroy()

        studentWalletWindow(student_id, student_name, wallet_number, balance)



    def open_adminwindow(self):
        from admin_window import AdminWindow
        self.login_window.destroy()
        AdminWindow()

    def back_to_signup(self):
        from signup_window import SignupWindow
        self.login_window.destroy()
        SignupWindow()

