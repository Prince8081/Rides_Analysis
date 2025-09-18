import pandas as pd 
import numpy as np

# Load the Dataset

df = pd.read_csv('rides_data.csv')

# Convert date 

df['date'] = pd.to_datetime(df['date'], errors='coerce')


# Convert columns to proper format

numeric_cols = ['duration' , 'distance' , 'ride_charge' , 'misc_charge' , 'total_fare' ]
df[numeric_cols] = df[numeric_cols].apply(pd.to_numeric, errors='coerce')

# Replace NaN 

cancelled_ride = df['ride_status'].str.lower() == 'cancelled'
df.loc[cancelled_ride, ['ride_charge', 'misc_charge', 'total_fare']] = 0

df['payment_method'] = df['payment_method'].fillna('no_payment')

# Add calculated columns

df['duration_hours'] = df['duration']/60
df['avg_speed_kmph'] = df['distance']/df['duration_hours']

df.to_csv("clean_rides_data.csv", index=False)
print("\n✅ Cleaned data saved as 'cleaned_rides_data.csv'")



from sqlalchemy import create_engine
import pandas as pd

engine = create_engine("mysql+pymysql://root:pri8073@localhost/ride_analysis")


df.to_sql("df", con=engine, if_exists="replace", index=False)

print("✅ Cleaned data successfully loaded into MySQL!")
