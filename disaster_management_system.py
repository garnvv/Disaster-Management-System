import pyodbc
from tkinter import *
from tkinter import ttk, messagebox, scrolledtext
from tkinter.font import Font


class DisasterManagementSystem:
    def __init__(self, root):
        self.root = root
        self.root.title("Disaster Management System")
        self.root.state('zoomed')  # Maximize window

        # Create database connection
        self.conn = self.create_connection()

        # Setup GUI
        self.setup_ui()

    def create_connection(self):
        try:
            conn = pyodbc.connect(
                "Driver={SQL Server};"
                "Server=LAPTOP-C5F6LVQ2\\SQLEXPRESS;"
                "Database=DMS;"
                "Trusted_Connection=yes;"
            )
            return conn
        except Exception as e:
            messagebox.showerror("Database Error", f"Failed to connect to database: {str(e)}")
            return None

    def setup_ui(self):
        # Create main paned window
        self.main_pane = PanedWindow(self.root, orient=HORIZONTAL)
        self.main_pane.pack(fill=BOTH, expand=True)

        # Left panel for navigation
        self.left_panel = Frame(self.main_pane, width=300)
        self.main_pane.add(self.left_panel, minsize=300)

        # Right panel for output
        self.output_frame = Frame(self.main_pane)
        self.main_pane.add(self.output_frame, minsize=800)

        # Setup left panel
        self.setup_left_panel()

        # Setup menu bar
        self.setup_menu()

        # Initial welcome message
        self.show_welcome_message()

    def setup_left_panel(self):
        # Create canvas and scrollbar for left panel
        self.left_canvas = Canvas(self.left_panel, highlightthickness=0)
        self.left_scrollbar = Scrollbar(self.left_panel, orient="vertical", command=self.left_canvas.yview)
        self.scrollable_frame = Frame(self.left_canvas)

        # Configure canvas
        self.scrollable_frame.bind(
            "<Configure>",
            lambda e: self.left_canvas.configure(
                scrollregion=self.left_canvas.bbox("all")
            )
        )
        self.left_canvas.create_window((0, 0), window=self.scrollable_frame, anchor="nw")
        self.left_canvas.configure(yscrollcommand=self.left_scrollbar.set)

        # Pack the canvas and scrollbar
        self.left_canvas.pack(side="left", fill="both", expand=True)
        self.left_scrollbar.pack(side="right", fill="y")

        # Add title
        title_font = Font(family="Helvetica", size=14, weight="bold")
        title_label = Label(self.scrollable_frame,
                            text="Disaster Management System",
                            font=title_font,
                            pady=20)
        title_label.pack(fill=X)

        # Add table operations section
        self.add_section_header("Table Operations")

        # Add buttons for each table
        self.tables = {
            "USERS": ["USER_ID", "NAME", "ROLE", "CONTACT_INFO", "EMAIL"],
            "DISASTERS": ["DISASTER_ID", "TYPE", "SEVERITY", "LOCATION", "DATE"],
            "RESCUETEAMS": ["TEAM_ID", "USER_ID", "TEAM_NAME", "CONTACT_NUMBER"],
            "RESOURCES": ["RESOURCE_ID", "RESOURCE_TYPE", "QUANTITY", "LOCATION"],
            "VICTIMS": ["VICTIM_ID", "NAME", "AGE", "STATUS", "MEDICAL_NEEDS"],
            "VOLUNTEERS": ["VOLUNTEER_ID", "USER_ID", "SKILLS", "AVAILABILITY"],
            "SHELTERS": ["SHELTER_ID", "LOCATION", "CAPACITY", "AVAILABLE_FACILITIES"],
            "DONATIONS": ["DONATION_ID", "USER_ID", "AMOUNT", "DATE"],
            "MEDICALASSISTANCE": ["MEDICAL_ID", "VICTIM_ID", "ASSIGNED_DOCTOR", "HOSPITAL"],
            "EMERGENCYCALLS": ["CALL_ID", "DISASTER_ID", "CALLER_NAME", "LOCATION", "EMERGENCY_TYPE", "TIME"],
            "TRANSPORT": ["VEHICLE_ID", "VEHICLE_TYPE", "CAPACITY", "LOCATION"],
            "WEATHERFORECAST": ["WEATHER_ID", "DATE", "LOCATION", "WEATHER_CONDITION"],
            "AI_PREDICTIONS": ["PREDICTION_ID", "DISASTER_ID", "WEATHER_ID", "PROBABILITY", "PREDICTED_DATE"],
            "ALERTS": ["ALERT_ID", "DISASTER_ID", "ALERT_MESSAGE", "ISSUED_BY", "ISSUED_DATE"],
            "INCIDENTREPORTS": ["REPORT_ID", "DISASTER_ID", "USER_ID", "REPORT_DETAILS", "REPORT_DATE"]
        }

        for table_name, fields in self.tables.items():
            self.add_table_button(table_name, fields)

        # Add query operations section
        self.add_section_header("Predefined Queries")

        # Add custom query button
        custom_btn = Button(self.scrollable_frame,
                            text="Execute Custom Query",
                            command=self.execute_custom_query,
                            relief=FLAT,
                            padx=10,
                            pady=5)
        custom_btn.pack(fill=X, padx=10, pady=5)

        # Add predefined queries
        self.query_categories = {
            "Basic Queries": [
                ("List all users and their roles", 1),
                ("Get January 2025 disasters", 2),
                ("Show injured victims", 3),
                ("Donations above ₹1,000", 4),
                ("Shelters with capacity > 100", 5)
            ],
            "Join Queries": [
                ("Rescue teams with user names", 6),
                ("Volunteers and their skills", 7),
                ("Donations with donor info", 8),
                ("Alerts with disaster details", 9),
                ("AI predictions with weather", 10),
                ("Disasters with reports (LEFT JOIN)", 11),
                ("Victims with medical help (RIGHT JOIN)", 12),
                ("Users and donations (FULL OUTER JOIN)", 13)
            ],
            "Aggregate Queries": [
                ("Disasters per location", 14),
                ("Total donations", 15),
                ("Average donation", 16),
                ("Shelter capacity stats", 17),
                ("Victims by status", 18),
                ("Top 5 donors", 19),
                ("Volunteers by availability", 20),
                ("Calls per disaster type", 21)
            ],
            "Special Queries": [
                ("Active volunteers (View)", 22),
                ("Victim medical info (View)", 23),
                ("Disaster alerts (View)", 24),
                ("Recent incidents (30 days)", 25),
                ("Emergency calls this week", 26),
                ("7-day weather forecast", 27),
                ("Transport in 'California'", 28),
                ("Avg transport capacity", 29),
                ("Vehicles by capacity", 30)
            ]
        }

        for category, queries in self.query_categories.items():
            self.add_query_category(category, queries)

    def add_section_header(self, text):
        section_font = Font(family="Helvetica", size=12, weight="bold")
        header = Label(self.scrollable_frame,
                       text=text,
                       font=section_font,
                       padx=10,
                       pady=5,
                       anchor='w')
        header.pack(fill=X, pady=(15, 5))

    def add_table_button(self, table_name, fields):
        btn_frame = Frame(self.scrollable_frame)
        btn_frame.pack(fill=X, padx=10, pady=2)

        # View button
        view_btn = Button(btn_frame,
                          text=f"View {table_name}",
                          command=lambda t=table_name: self.view_table(t),
                          relief=FLAT,
                          width=20,
                          anchor='w')
        view_btn.pack(side=LEFT, padx=(0, 5))

        # Add button
        add_btn = Button(btn_frame,
                         text="Add",
                         command=lambda t=table_name, f=fields: self.add_data(t, f),
                         relief=FLAT,
                         width=5)
        add_btn.pack(side=LEFT)

    def add_query_category(self, category, queries):
        self.add_section_header(category)

        for desc, num in queries:
            query_btn = Button(self.scrollable_frame,
                               text=desc,
                               command=lambda n=num: self.execute_query(n),
                               relief=FLAT,
                               anchor='w',
                               padx=20,
                               pady=3)
            query_btn.pack(fill=X, padx=10, pady=2)

    def setup_menu(self):
        menubar = Menu(self.root)

        # File menu
        file_menu = Menu(menubar, tearoff=0)
        file_menu.add_command(label="Exit", command=self.root.quit)
        menubar.add_cascade(label="File", menu=file_menu)

        # Query menu
        query_menu = Menu(menubar, tearoff=0)
        query_menu.add_command(label="Custom Query", command=self.execute_custom_query)
        menubar.add_cascade(label="Query", menu=query_menu)

        # Help menu
        help_menu = Menu(menubar, tearoff=0)
        help_menu.add_command(label="About", command=self.show_about)
        menubar.add_cascade(label="Help", menu=help_menu)

        self.root.config(menu=menubar)

    def show_welcome_message(self):
        self.clear_output()

        welcome_font = Font(family="Helvetica", size=16, weight="bold")
        welcome_label = Label(self.output_frame,
                              text="Welcome to Disaster Management System\n\n"
                                   "Select a table to view or execute a query from the left panel",
                              font=welcome_font,
                              justify=CENTER,
                              pady=50)
        welcome_label.pack(expand=True, fill=BOTH)

    def show_about(self):
        messagebox.showinfo("About",
                            "Disaster Management System\n\n"
                            "Version 1.0\n"
                            "Developed for managing disaster response operations")

    def clear_output(self):
        for widget in self.output_frame.winfo_children():
            widget.destroy()

    def view_table(self, table_name):
        try:
            cursor = self.conn.cursor()
            cursor.execute(f"SELECT * FROM {table_name}")
            records = cursor.fetchall()

            self.display_output(
                title=f"{table_name} Table Data",
                records=records,
                description=cursor.description,
                query_text=f"SELECT * FROM {table_name}",
                table_name=table_name
            )
        except Exception as e:
            messagebox.showerror("Error", f"Error retrieving data from {table_name}: {str(e)}")

    def execute_query(self, query_num):
        queries = [
            """SELECT USER_ID, NAME, ROLE FROM USERS;""",
            """SELECT * FROM DISASTERS WHERE DATE BETWEEN '2025-01-01' AND '2025-01-31';""",
            """SELECT * FROM VICTIMS WHERE STATUS = 'INJURED';""",
            """SELECT * FROM DONATIONS WHERE AMOUNT > 1000;""",
            """SELECT * FROM SHELTERS WHERE CAPACITY > 100;""",
            """SELECT RT.TEAM_ID, U.NAME, RT.TEAM_NAME FROM RESCUETEAMS RT JOIN USERS U ON RT.USER_ID = U.USER_ID;""",
            """SELECT V.VOLUNTEER_ID, U.NAME, V.SKILLS FROM VOLUNTEERS V JOIN USERS U ON V.USER_ID = U.USER_ID;""",
            """SELECT D.DONATION_ID, U.NAME AS DONOR_NAME, D.AMOUNT FROM DONATIONS D JOIN USERS U ON D.USER_ID = U.USER_ID;""",
            """SELECT A.ALERT_MESSAGE, D.TYPE AS DISASTER_TYPE, U.NAME AS ISSUER FROM ALERTS A JOIN DISASTERS D ON A.DISASTER_ID = D.DISASTER_ID JOIN USERS U ON A.ISSUED_BY = U.USER_ID;""",
            """SELECT A.PREDICTION_ID, D.TYPE AS DISASTER, W.WEATHER_CONDITION, A.PROBABILITY FROM AI_PREDICTIONS A JOIN DISASTERS D ON A.DISASTER_ID = D.DISASTER_ID JOIN WEATHERFORECAST W ON A.WEATHER_ID = W.WEATHER_ID;""",
            """SELECT D.TYPE, R.REPORT_DETAILS FROM DISASTERS D LEFT JOIN INCIDENTREPORTS R ON D.DISASTER_ID = R.DISASTER_ID;""",
            """SELECT V.NAME, M.HOSPITAL FROM MEDICALASSISTANCE M RIGHT JOIN VICTIMS V ON M.VICTIM_ID = V.VICTIM_ID;""",
            """SELECT U.NAME, D.AMOUNT FROM USERS U FULL OUTER JOIN DONATIONS D ON U.USER_ID = D.USER_ID;""",
            """SELECT LOCATION, COUNT(*) AS TOTAL_DISASTERS FROM DISASTERS GROUP BY LOCATION;""",
            """SELECT SUM(AMOUNT) AS TOTAL_DONATIONS FROM DONATIONS;""",
            """SELECT AVG(AMOUNT) AS AVERAGE_DONATION FROM DONATIONS;""",
            """SELECT MAX(CAPACITY) AS MAX_CAPACITY, MIN(CAPACITY) AS MIN_CAPACITY FROM SHELTERS;""",
            """SELECT STATUS, COUNT(*) AS COUNT FROM VICTIMS GROUP BY STATUS;""",
            """SELECT U.NAME, SUM(D.AMOUNT) AS TOTAL_DONATED FROM DONATIONS D JOIN USERS U ON D.USER_ID = U.USER_ID GROUP BY U.NAME ORDER BY TOTAL_DONATED DESC OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;""",
            """SELECT AVAILABILITY, COUNT(*) AS TOTAL FROM VOLUNTEERS GROUP BY AVAILABILITY;""",
            """SELECT D.TYPE, COUNT(*) AS CALL_COUNT FROM EMERGENCYCALLS C JOIN DISASTERS D ON C.DISASTER_ID = D.DISASTER_ID GROUP BY D.TYPE;""",
            """SELECT * FROM ACTIVE_VOLUNTEERS;""",
            """SELECT * FROM VICTIM_MEDICAL_INFO;""",
            """SELECT * FROM DISASTER_ALERTS;""",
            """SELECT * FROM DISASTERS WHERE date >= '2025-01-01' AND date < '2025-02-01';""",
            """SELECT call_id, disaster_id, caller_name, location, emergency_type, time FROM EMERGENCYCALLS WHERE time >= DATEADD(DAY, -7, '2025-02-16') AND time <= '2025-02-16';""",
            """SELECT * FROM WEATHERFORECAST WHERE date BETWEEN '2025-02-10' AND '2025-02-17';""",
            """SELECT * FROM TRANSPORT WHERE LOCATION = 'California';""",
            """SELECT VEHICLE_TYPE, AVG(CAPACITY) AS AVG_CAPACITY FROM TRANSPORT GROUP BY VEHICLE_TYPE;""",
            """SELECT * FROM TRANSPORT ORDER BY CAPACITY DESC;"""
        ]

        query_descriptions = [
            "List all users and their roles",
            "Get January 2025 disasters",
            "Show injured victims",
            "Donations above ₹1,000",
            "Shelters with capacity > 100",
            "Rescue teams with user names",
            "Volunteers and their skills",
            "Donations with donor info",
            "Alerts with disaster details",
            "AI predictions with weather",
            "Disasters with reports (LEFT JOIN)",
            "Victims with medical help (RIGHT JOIN)",
            "Users and donations (FULL OUTER JOIN)",
            "Disasters per location",
            "Total donations",
            "Average donation",
            "Shelter capacity stats",
            "Victims by status",
            "Top 5 donors",
            "Volunteers by availability",
            "Calls per disaster type",
            "Active volunteers (View)",
            "Victim medical info (View)",
            "Disaster alerts (View)",
            "Recent incidents (30 days)",
            "Emergency calls this week",
            "7-day weather forecast",
            "Transport in 'California'",
            "Avg transport capacity",
            "Vehicles by capacity"
        ]

        try:
            cursor = self.conn.cursor()
            query = queries[query_num - 1]
            cursor.execute(query)
            records = cursor.fetchall()

            self.display_output(
                title=f"Query {query_num}: {query_descriptions[query_num - 1]}",
                records=records,
                description=cursor.description,
                query_text=query
            )
        except Exception as e:
            messagebox.showerror("Error", f"Error executing query {query_num}: {str(e)}")

    def execute_custom_query(self):
        def run_query():
            query = query_text.get("1.0", END).strip()
            if not query:
                messagebox.showwarning("Warning", "Please enter a SQL query")
                return

            try:
                cursor = self.conn.cursor()
                cursor.execute(query)

                # Check if it's a SELECT query
                if query.strip().upper().startswith("SELECT"):
                    records = cursor.fetchall()
                    self.display_output(
                        title="Custom Query Results",
                        records=records,
                        description=cursor.description,
                        query_text=query
                    )
                else:
                    self.conn.commit()
                    messagebox.showinfo("Success", f"Query executed successfully. {cursor.rowcount} rows affected.")
                    custom_window.destroy()
            except Exception as e:
                messagebox.showerror("Error", f"Error executing query: {str(e)}")

        custom_window = Toplevel(self.root)
        custom_window.title("Custom SQL Query")

        Label(custom_window, text="Enter your SQL query:").pack(pady=5)

        query_text = scrolledtext.ScrolledText(custom_window, width=80, height=15, font=('Consolas', 10))
        query_text.pack(padx=10, pady=5)

        btn_frame = Frame(custom_window)
        btn_frame.pack(pady=10)

        Button(btn_frame,
               text="Execute",
               command=run_query,
               padx=10).pack(side=LEFT, padx=5)

        Button(btn_frame,
               text="Cancel",
               command=custom_window.destroy,
               padx=10).pack(side=LEFT, padx=5)

    def add_data(self, table_name, fields):
        def submit_data():
            # Skip the ID field for tables with identity columns
            if table_name in ["USERS", "DISASTERS", "RESCUETEAMS", "RESOURCES",
                              "VICTIMS", "VOLUNTEERS", "SHELTERS", "DONATIONS",
                              "MEDICALASSISTANCE", "EMERGENCYCALLS", "TRANSPORT",
                              "WEATHERFORECAST", "AI_PREDICTIONS", "ALERTS", "INCIDENTREPORTS"]:
                fields_to_use = fields[1:]  # Skip first field (ID)
                values = [entry.get() for entry in entries]
            else:
                fields_to_use = fields
                values = [entry.get() for entry in entries]

            if not all(values):
                messagebox.showwarning("Input Error", "Please fill in all required fields!")
                return

            try:
                cursor = self.conn.cursor()
                placeholders = ", ".join(["?" for _ in values])
                query = f"INSERT INTO {table_name} ({', '.join(fields_to_use)}) VALUES ({placeholders})"

                cursor.execute(query, values)
                self.conn.commit()

                messagebox.showinfo("Success", f"Data inserted into {table_name} successfully!")
                add_window.destroy()

                # Refresh the view if we're viewing this table
                if hasattr(self, 'current_table') and self.current_table == table_name:
                    self.view_table(table_name)

            except pyodbc.Error as e:
                self.conn.rollback()
                messagebox.showerror("Database Error", f"Failed to insert data:\n{str(e)}")
            except Exception as e:
                self.conn.rollback()
                messagebox.showerror("Error", f"Unexpected error: {str(e)}")

        # Create the add window
        add_window = Toplevel(self.root)
        add_window.title(f"Add to {table_name}")
        add_window.grab_set()

        entries = []

        # Skip the ID field for tables with identity columns
        start_idx = 1 if table_name in ["USERS", "DISASTERS", "RESCUETEAMS", "RESOURCES",
                                        "VICTIMS", "VOLUNTEERS", "SHELTERS", "DONATIONS",
                                        "MEDICALASSISTANCE", "EMERGENCYCALLS", "TRANSPORT",
                                        "WEATHERFORECAST", "AI_PREDICTIONS", "ALERTS", "INCIDENTREPORTS"] else 0

        for i, field in enumerate(fields[start_idx:], start=start_idx):
            frame = Frame(add_window)
            frame.pack(fill=X, padx=10, pady=5)

            Label(frame, text=f"{field}:").pack(side=LEFT)
            entry = Entry(frame)
            entry.pack(side=RIGHT, expand=True, fill=X, padx=5)
            entries.append(entry)

        btn_frame = Frame(add_window)
        btn_frame.pack(fill=X, pady=10)

        Button(btn_frame, text="Submit", command=submit_data, padx=10).pack(side=RIGHT, padx=5)
        Button(btn_frame, text="Cancel", command=add_window.destroy, padx=10).pack(side=RIGHT, padx=5)
    def display_output(self, title, records, description=None, query_text=None, table_name=None):
        self.clear_output()
        self.current_table = table_name if table_name else (title.split()[0] if "Table Data" in title else None)

        # Add title
        title_font = Font(family="Helvetica", size=14, weight="bold")
        title_label = Label(self.output_frame,
                            text=title,
                            font=title_font,
                            padx=10,
                            pady=5)
        title_label.pack(fill=X, pady=(0, 10))

        if query_text:
            query_frame = Frame(self.output_frame)
            query_frame.pack(fill=X, padx=5, pady=(0, 10))

            query_label = Label(query_frame,
                                text="Query:",
                                font=('Arial', 10, 'bold'))
            query_label.pack(anchor='w', padx=5, pady=5)

            query_text_label = Label(query_frame,
                                     text=query_text,
                                     wraplength=700,
                                     justify=LEFT)
            query_text_label.pack(anchor='w', padx=20, pady=(0, 5))

        if not records:
            no_data_label = Label(self.output_frame,
                                  text="No data found",
                                  fg='red')
            no_data_label.pack(pady=20)
            return

        # Create a frame for the Treeview and scrollbar
        tree_frame = Frame(self.output_frame)
        tree_frame.pack(fill=BOTH, expand=1, padx=10, pady=10)

        # Add a scrollbar
        scrollbar = Scrollbar(tree_frame)
        scrollbar.pack(side=RIGHT, fill=Y)

        # Create the Treeview with columns
        style = ttk.Style()
        tree = ttk.Treeview(tree_frame, yscrollcommand=scrollbar.set, selectmode='browse')

        # Define columns
        if description:
            columns = [column[0] for column in description]
        else:
            # If no cursor description, use generic column names
            columns = [f"Column {i + 1}" for i in range(len(records[0]))] if records else []

        tree["columns"] = columns

        # Format columns
        tree.column("#0", width=0, stretch=NO)
        for col in columns:
            tree.column(col, anchor=W, width=120)
            tree.heading(col, text=col, anchor=W)

        # Add data - handle potential data type issues
        for row in records:
            try:
                # Convert all values to strings to avoid display issues
                str_row = [str(item) if item is not None else "NULL" for item in row]
                tree.insert("", END, values=str_row)
            except Exception as e:
                print(f"Error inserting row: {e}")
                continue

        tree.pack(fill=BOTH, expand=1)
        scrollbar.config(command=tree.yview)

        # Add action buttons if it's a table view (not a query)
        if description and "Query" not in title and self.current_table:
            btn_frame = Frame(self.output_frame)
            btn_frame.pack(fill=X, pady=(0, 10))

            # Delete button
            delete_btn = Button(btn_frame,
                                text="Delete Selected",
                                command=lambda: self.delete_record(tree, columns[0] if columns else ""),
                                padx=10)
            delete_btn.pack(side=LEFT, padx=10, pady=5)

            # Update button
            update_btn = Button(btn_frame,
                                text="Update Selected",
                                command=lambda: self.update_record(tree, self.current_table, columns),
                                padx=10)
            update_btn.pack(side=LEFT, padx=10, pady=5)

    def delete_record(self, tree, id_column):
        selected_item = tree.focus()
        if not selected_item:
            messagebox.showwarning("Warning", "Please select a record to delete")
            return

        try:
            record_id = tree.item(selected_item)['values'][0]
            table_name = self.current_table

            confirm = messagebox.askyesno("Confirm Delete", f"Delete record with {id_column} = {record_id}?")
            if confirm:
                cursor = self.conn.cursor()
                cursor.execute(f"DELETE FROM {table_name} WHERE {id_column} = ?", record_id)
                self.conn.commit()
                tree.delete(selected_item)
                messagebox.showinfo("Success", "Record deleted successfully")
        except Exception as e:
            messagebox.showerror("Error", f"Failed to delete record: {str(e)}")

    def update_record(self, tree, table_name, columns):
        selected_item = tree.focus()
        if not selected_item:
            messagebox.showwarning("Warning", "Please select a record to update")
            return

        def submit_update():
            new_values = [entry.get() for entry in entries]
            try:
                cursor = self.conn.cursor()
                set_clause = ", ".join([f"{col} = ?" for col in columns])
                query = f"UPDATE {table_name} SET {set_clause} WHERE {columns[0]} = ?"
                cursor.execute(query, new_values + [record_id])
                self.conn.commit()
                messagebox.showinfo("Success", "Record updated successfully")
                update_window.destroy()
                self.view_table(table_name)  # Refresh the view
            except Exception as e:
                messagebox.showerror("Error", f"Failed to update record: {str(e)}")

        try:
            record_id = tree.item(selected_item)['values'][0]
            record_values = tree.item(selected_item)['values']

            update_window = Toplevel(self.root)
            update_window.title(f"Update {table_name} Record")

            entries = []

            for i, (col, val) in enumerate(zip(columns, record_values)):
                frame = Frame(update_window)
                frame.grid(row=i, column=0, padx=10, pady=5, sticky='ew')

                Label(frame, text=col).pack(side=LEFT, padx=5)
                entry = Entry(frame)
                entry.insert(0, val)
                entry.pack(side=RIGHT, expand=True, fill=X, padx=5)
                entries.append(entry)

            btn_frame = Frame(update_window)
            btn_frame.grid(row=len(columns), column=0, pady=10, sticky='ew')

            Button(btn_frame,
                   text="Update",
                   command=submit_update,
                   padx=10).pack(side=RIGHT, padx=5)

        except Exception as e:
            messagebox.showerror("Error", f"Failed to prepare update form: {str(e)}")


# Main application
if __name__ == "__main__":
    root = Tk()
    app = DisasterManagementSystem(root)
    root.mainloop()