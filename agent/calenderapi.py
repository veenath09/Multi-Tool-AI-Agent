# calendar_utils.py
import datetime
import os.path
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build

# If modifying these scopes, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/calendar']

def get_calendar_service():
    creds = None
    # The token.json file stores the user's access and refresh tokens.
    if os.path.exists('token.json'):
        creds = Credentials.from_authorized_user_file('token.json', SCOPES)
    # If there are no valid credentials, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file('credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open('token.json', 'w') as token:
            token.write(creds.to_json())
    service = build('calendar', 'v3', credentials=creds)
    return service

def create_calendar_event(vehicle_name, date_str, timeslot, reserver_email):
    # Assume timeslot is a string; convert date and timeslot to a datetime start.
    # For example, you may have timeslot = "14:00-15:00" so split accordingly.
    start_time_str, end_time_str = timeslot.split("-")
    start_datetime = datetime.datetime.strptime(f"{date_str} {start_time_str}", "%Y-%m-%d %H:%M")
    end_datetime = datetime.datetime.strptime(f"{date_str} {end_time_str}", "%Y-%m-%d %H:%M")
    
    event = {
        'summary': f"Reservation for {vehicle_name}",
        'description': f"Reservation made by {reserver_email}",
        'start': {
            'dateTime': start_datetime.isoformat(),
            'timeZone': 'UTC',  # Change to your time zone if needed
        },
        'end': {
            'dateTime': end_datetime.isoformat(),
            'timeZone': 'UTC',
        },
        'attendees': [
            {'email': reserver_email},
        ],
    }
    service = get_calendar_service()
    event = service.events().insert(calendarId='primary', body=event).execute()
    return event.get('id')
