"Database connections to make reservations"

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
        cursor.close()
        connection.close()
        print("MySQL connection closed.")


# reservation_tools.py
#from db_utils import get_db_connection
#from calendar_utils import create_calendar_event

def check_availability(vehicle_name, date):
    """
    Check available timeslots for a given vehicle and date.
    """
    connection = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )
    cursor = connection.cursor(dictionary=True)
    query = """
    SELECT * FROM vehicles
    WHERE VehicleName = %s AND Date = %s AND Status = 'Available'
    """
    cursor.execute(query, (vehicle_name, date))
    results = cursor.fetchall()
    cursor.close()
    connection.close()
    return results

def make_reservation(vehicle_name, date, timeslot, reserver, reserver_email):
    """
    Update the database record to mark a reservation and create a calendar event.
    """
    connection = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=database
    )
    
    cursor = connection.cursor(dictionary=True)
    
    # Update the reservation record
    update_query = """
    UPDATE vehicles 
    SET Status = 'Reserved', ReservedBy = %s, Reserver_Email = %s, Timeslot = %s
    WHERE VehicleName = %s AND Date = %s  AND Status = 'Available'
    LIMIT 1;
    """
    cursor.execute(update_query, (reserver, reserver_email, timeslot, vehicle_name, date))
    connection.commit()
    
    # Optionally, check that a row was updated
    if cursor.rowcount == 0:
        cursor.close()
        connection.close()
        return "Reservation failed. No available slot was updated."
    
    # Create a calendar event
    #event_id = create_calendar_event(vehicle_name, date, timeslot, reserver_email)
    
    cursor.close()
    connection.close()
    return f"Reservation confirmed. Calendar event created with ID: {event_id}"

def cancel_reservation(vehicle_name, date, timeslot, reserver_email):
    """
    Cancel a reservation by updating the database record.
    (Optionally, you can also call the Google Calendar API to remove the event.)
    """
    connection = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=database
    )
    
    cursor = connection.cursor(dictionary=True)
    print(f"in cancel reservation the paramters are as follows {vehicle_name} date {date} slot {timeslot} email {reserver_email}")
  
    update_query = """
    UPDATE vehicles
    SET Status = 'Available', ReservedBy = NULL, Reserver_Email = NULL
    WHERE VehicleName = %s AND Date = %s AND Timeslot = %s AND Reserver_Email = %s AND Status = 'Reserved'
    LIMIT 1;
    """
    cursor.execute(update_query, (vehicle_name, date, timeslot, reserver_email))
    connection.commit()
    
    if cursor.rowcount == 0:
        result = "Cancellation failed. Reservation not found or already available."
    else:
        result = "Reservation canceled successfully."
    
    cursor.close()
    connection.close()
    return result
