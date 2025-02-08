import mysql.connector

# Database connection details
host = "localhost"      # XAMPP runs MySQL on localhost
user = "root"           # Default user in XAMPP
password = ""           # Default password is empty
database = "reservations"  # Replace with your database name

try:
    # Establish the connection
    connection = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )

    if connection.is_connected():
        print("Connected to MySQL database!")

        # Create a cursor object to execute queries
        cursor = connection.cursor()

        # Example Query: Fetch all tables
        cursor.execute("SHOW TABLES;")
        tables = cursor.fetchall()

        print("Tables in the database:")
        for table in tables:
            print(table[0])


        cursor.execute("")
        result = cursor.fetchall()
        print(result)

except mysql.connector.Error as e:
    print(f"Error: {e}")

finally:
    # Close the connection
    if 'connection' in locals() and connection.is_connected():
        #cursor.close()
        #connection.close()
        print("MySQL connection closed.")



update_query = """
    UPDATE vehicles
    SET Status = 'Available', ReservedBy = NULL, Reserver_Email = NULL
    WHERE VehicleName = %s AND Date = %s AND Timeslot = %s AND Reserver_Email = %s AND Status = 'Reserved'
    LIMIT 1;
    """
cursor.execute(update_query, ('CAB5052', '2025-02-03', '14:00-15:00', 'john@example.com'))
connection.commit()