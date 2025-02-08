import gspread
from google.oauth2.service_account import Credentials

SCOPES = ["https://www.googleapis.com/auth/spreadsheets", "https://www.googleapis.com/auth/drive"]

creds = Credentials.from_service_account_file("./credentials.json", scopes=SCOPES)
client = gspread.authorize(creds)

sheet_id = "14P56Ty4Wpw0tcL5TK_PJPShPFRMWzN8C8aMKEHe-EiU"
workbook = client.open_by_key(sheet_id)

values_list = workbook.sheet1.row_values(1)
print(values_list)

sheets = map(lambda x:x.title,workbook.worksheets())

print(list(sheets))

sheet = workbook.worksheet("Sheet1")
sheet.update_cell(1,1,"Hi I'm Apex!")