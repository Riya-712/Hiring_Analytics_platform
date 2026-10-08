import pandas as pd
from sqlalchemy import create_engine

# 🔹 Update your credentials
username = "postgres"
password = "goblu127"
host = "localhost"
port = "5432"
database = "analytics"

# 🔹 Create connection
engine = create_engine(f"postgresql://{username}:{password}@{host}:{port}/{database}")

# 🔹 Load CSV files
candidates = pd.read_csv("candidates.csv")
events = pd.read_csv("events.csv")
touchpoints = pd.read_csv("touchpoints.csv")

# 🔹 Push to PostgreSQL
candidates.to_sql("candidates", engine, if_exists="replace", index=False)
events.to_sql("events", engine, if_exists="replace", index=False)
touchpoints.to_sql("touchpoints", engine, if_exists="replace", index=False)

print("✅ Data loaded successfully!")