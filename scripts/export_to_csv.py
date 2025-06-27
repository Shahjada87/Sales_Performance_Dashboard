import pandas as pd
import mysql.connector
import os
from datetime import datetime

# lets do the database configuration
db_config = {
    "host": "localhost",
    "user": "root",  
    "password": "Saju@0807Sumi",  
    "database": "superstore_project"  
}


# Output path (static)

output_path = '/Users/shahjadaemirsaqualain/Downloads/Cleaned_SampleSuperstore_Export.csv'

try:
    # Connect to MySQL
    conn = mysql.connector.connect(**db_config)

    # Query to fetch data (include column names for clarity)
    query = """
    SELECT *
    FROM sales_performance_dashboard
    """

    # njow lets load data into DataFrame

    df = pd.read_sql(query, conn)

    # Export to CSV
    df.to_csv(output_path, index=False)
    print(f"Export complete. File saved to:\n{output_path}")

except mysql.connector.Error as err:
    print(f"MySQL error: this is the error u are getting {err}")

except Exception as e:
    print(f"Unexpected error: {e}")

finally:
    if 'conn' in locals() and conn.is_connected():
        conn.close()

## Now i successfully completed saving the cleaned data set to my local computer using the pandas 