
import pandas as pd

# Load your CSVs
candidates = pd.read_csv("candidates.csv")
events = pd.read_csv("events.csv")
touchpoints = pd.read_csv("touchpoints.csv")

# View data
print(candidates.head())
print(events.head())
print(touchpoints.head())

# Convert dates
candidates['application_date'] = pd.to_datetime(candidates['application_date'])
events['event_date'] = pd.to_datetime(events['event_date'])
touchpoints['touch_date'] = pd.to_datetime(touchpoints['touch_date'])

# Remove duplicates
candidates.drop_duplicates(inplace=True)
events.drop_duplicates(inplace=True)

# Check missing values
print(candidates.isnull().sum())
print(events.isnull().sum())

# Check invalid cases (Interview without Screen)
interview_ids = events[events['stage'] == 'Interviewed']['candidate_id']
screen_ids = events[events['stage'] == 'Screened']['candidate_id']

invalid_ids = set(interview_ids) - set(screen_ids)

print("Invalid candidates:", len(invalid_ids))