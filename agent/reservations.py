import gspread
from google.oauth2.service_account import Credentials
import gspread
from google.oauth2.service_account import Credentials

SCOPES = ["https://www.googleapis.com/auth/spreadsheets", "https://www.googleapis.com/auth/drive"]

creds = Credentials.from_service_account_file("./credentials.json", scopes=SCOPES)
client = gspread.authorize(creds)

sheet_id = "14P56Ty4Wpw0tcL5TK_PJPShPFRMWzN8C8aMKEHe-EiU"
workbook = client.open_by_key(sheet_id)


# Example to read data
data = workbook.sheet1.get_all_records()  # Returns all records
print(data)
