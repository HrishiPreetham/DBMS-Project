import streamlit as st
import mysql.connector
import pandas as pd
st.set_page_config(
    page_title="Cricket Scouting Management System",
    page_icon="🏏",
)
# Define roles and access control
ROLES = {
    "admin": {
        "username": "admin",
        "password": "admin123",
        "role": "Admin",
        "privileges": {
            "Insert": ["coach", "country", "franchise", "league", "overallbattingstats", "overallbowlingstats", "player", "recentperformance", "selectors"],
            "Update": ["coach", "franchise", "league", "overallbattingstats", "overallbowlingstats", "player", "recentperformance", "selectors"], 
            "Delete": ["recentperformance"],
            "Select": ["coach", "country", "franchise", "league", "overallbattingstats", "overallbowlingstats", "player", "recentperformance", "selectors"],
        },
    },
    "players": {
        "username": "players",
        "password": "players123",
        "role": "Players",
        "privileges": {
            "Insert": [],
            "Update": [],  # Add tables for update privileges
            "Delete": [],
            "Select": ["coach", "country", "franchise", "league", "overallbattingstats", "overallbowlingstats", "player", "recentperformance", "selectors"],
        },
    },
    "franchise": {
        "username": "franchise",
        "password": "franchise123",
        "role": "Franchise",
        "privileges": {
            "Insert": ["player", "selectors","coach"],
            "Update": [],  # Add tables for update privileges
            "Delete": [],
            "Select": ["player", "selectors","coach"],
        },
    },
    "league": {
        "username": "league",
        "password": "league123",
        "role": "League",
        "privileges": {
            "Insert": ["player", "overallbattingstats", "overallbowlingstats", "recentperformance","franchise"],
            "Update": ["player", "overallbattingstats", "overallbowlingstats", "recentperformance","franchise"],
            "Delete": [],
            "Select": ["player", "overallbattingstats", "overallbowlingstats", "recentperformance","franchise"],
        },
    },
}

# ... (Your database connection and helper functions)
def create_connection():
    config = {
        'host': 'localhost',
        'user': 'root',
        'password': 'password',
        'database': 'csdbms'
    }
    connection = mysql.connector.connect(**config)
    return connection

def execute_procedure_query(connection,limit_count):
    try:
        # Execute the stored procedure
        cursor=connection.cursor()
        query = """
        SELECT
            player.PlayerName,
            overallbattingstats.BattingAverage,
            overallbowlingstats.BowlingAverage,
            overallbattingstats.BattingAverage - overallbowlingstats.BowlingAverage AS Difference,
            franchise.FranchiseName
        FROM player
        JOIN overallbattingstats ON player.PlayerID = overallbattingstats.PlayerID
        JOIN overallbowlingstats ON player.PlayerID = overallbowlingstats.PlayerID
        JOIN franchise ON player.FranchiseID = franchise.FranchiseID
        WHERE overallbowlingstats.BowlingAverage > 0 -- Only consider players with non-zero bowling average
        ORDER BY Difference DESC
        LIMIT %s
        """
        cursor.execute(query, (limit_count,))


        result = cursor.fetchall()
        column_names = [i[0] for i in cursor.description]
        cursor.close()

        return result, column_names
    except Exception as e:
        st.error(f"Error executing query: {str(e)}")


# Execute an SQL query for data retrieval
def execute_select_query(connection, query):
    try:
        cursor = connection.cursor()
        cursor.execute(query)
        data = cursor.fetchall()
        column_names = [i[0] for i in cursor.description]  # Get column names from cursor
        cursor.close()
        return data, column_names
    except Exception as e:
        st.error(f"Error executing query: {str(e)}")
        return None, None

# Execute an SQL query for data insertion
def execute_insert_query(connection, query):
    try:
        cursor = connection.cursor()
        cursor.execute(query)
        affected_rows = cursor.rowcount  # Get the number of affected rows
        connection.commit()  # Commit the transaction to save the changes to the database
        cursor.close()

        if affected_rows == 0:
            st.error("No matching records found. Please check your input.")
            return False
        else:
            return True
    except mysql.connector.Error as e:
        if e.errno == 1452:  # Check the specific error code for foreign key violation
            st.error("Cannot perform the operation due to a mismatch in the ID. Please make sure the referenced item exists.")
        elif "Error: FranchiseID does not exist in the franchise table" in str(e):
            st.error("Error: FranchiseID does not exist in the franchise table. Please check your input.")
        else:
            st.error(f"An error occurred while processing your request: {str(e)}")
        return False



# Define input fields for different tables
# ...
# Define input fields for different tables

# ...
if 'user' not in st.session_state:
    st.session_state.user = None

# Authenticate the user
def authenticate(username, password):
    if username in ROLES and ROLES[username]["password"] == password:
        st.session_state.user = ROLES[username]
        return True
    return False
# Streamlit app
def main():
    st.title("Cricket Scouting Database Management System 🏏")

    # Login section
    if st.session_state.user is None:
        st.subheader("Login")
        username = st.text_input("Username")
        password = st.text_input("Password", type="password")

        if st.button("Login"):
            if authenticate(username, password):
                st.success(f"Logged in as {username} ({st.session_state.user['role']})")
            else:
                st.error("You have entered invalid credentials")

    if st.session_state.user:
        st.write(f"Welcome, {st.session_state.user['username']}!")
        connection=create_connection()

            # Check if the connection was successful
        if connection.is_connected():
                st.success("Connection successful!")
                selected_option = st.sidebar.selectbox(f"Options", ["Insert Data to the table", "Select Data from the table", "Update Data in the table", "Delete Data from the table","Player Analysis"])

                if selected_option == "Update Data in the table":
                    st.subheader("Update Data from the table")
                    selected_update_table = st.selectbox("Select the table to update", st.session_state.user['privileges']['Update'])

                    # ... (Your code for update form fields and SQL queries)
                    if selected_update_table=="coach":
                        selected_coach_attribute=st.selectbox("Select the attribute of Coach table to be updated",["Coach Name","Specialist","FranchiseID"])
                        coach_update_id=st.number_input("CoachID",min_value=1,step=1)
                        if selected_coach_attribute == "Coach Name":
                            selected_coach_attribute="CoachName"
                            coach_update_value = st.text_input("Enter the Updated Coach Name")
                        elif selected_coach_attribute == "Specialist":
                            coach_update_value = st.text_input("Enter the Updated Coach Specialist")
                        elif selected_coach_attribute == "FranchiseID":
                            coach_update_value = st.number_input("Enter the Updated FranchiseID", min_value=1, step=1)
                        if st.button("Update data"):
                        # Construct the SQL update query
                            update_query = f"UPDATE coach SET {selected_coach_attribute} = '{coach_update_value}' WHERE CoachID = {coach_update_id}"
                            if execute_insert_query(connection, update_query):
                                st.success("Data updated successfully!")
                    
                    if selected_update_table=="franchise":
                        selected_franchise_attribute=st.selectbox("Select the attribute of Franchise table to be updated",["Franchise Name","Trophies","Team Points","LeagueID"])
                        franchise_update_id=st.number_input("FranchiseID",min_value=1,step=1)
                        if selected_franchise_attribute == "Franchise Name":
                            franchise_update_value = st.text_input("Enter the new Franchise Name")
                        elif selected_franchise_attribute == "Trophies":
                            franchise_update_value = st.number_input("Enter the updated Franchise Trophies")
                        elif selected_franchise_attribute == "Team Points":
                            selected_franchise_attribute='TeamPoints'
                            franchise_update_value = st.number_input("Enter the updated Team Points", min_value=0, step=1)
                        elif selected_franchise_attribute=="LeagueID":
                            franchise_update_value=st.number_input("Enter the updated Franchise LeagueID",min_value=1,step=1)

                        if st.button("Update data"):
                        # Construct the SQL update query
                            update_query = f"UPDATE FRANCHISE SET {selected_franchise_attribute} = '{franchise_update_value}' WHERE FRANCHISEID = {franchise_update_id}"
                            if execute_insert_query(connection, update_query):
                                st.success("Data updated successfully!")
                    
                    if selected_update_table=="league":
                        selected_league_attribute=st.selectbox("Select the attribute of League table to be updated",["League Name","HostID"])
                        league_update_id=st.number_input("LeagueID",min_value=1,step=1)
                        if selected_league_attribute == "League Name":
                            selected_league_attribute="LeagueName"
                            league_update_value = st.text_input("Enter the Updated League Name")
                        elif selected_league_attribute == "HostID":
                            league_update_value = st.number_input("Enter the Updated HostID", min_value=1, step=1)

                        if st.button("Update data"):
                        # Construct the SQL update query
                            update_query = f"UPDATE LEAGUE SET {selected_league_attribute} = '{league_update_value}' WHERE LeagueID = {league_update_id}"
                            if execute_insert_query(connection, update_query):
                                st.success("Data updated successfully!")
                            
                    if selected_update_table=="player":
                        selected_player_attribute=st.selectbox("Select the attribute of Player table to be updated",["Player Name","Matches","Specialist","CountryID","FranchiseID"])
                        player_update_id=st.number_input("PlayerID",min_value=1,step=1)
                        if selected_player_attribute == "Player Name":
                            selected_player_attribute='PlayerName'
                            player_update_value = st.text_input("Enter the Updated Player Name")
                        elif selected_player_attribute=="Matches":
                            player_update_value=st.number_input("Enter the Updated Player Matches",min_value=0,step=1)
                        elif selected_player_attribute == "Specialist":
                            player_update_value = st.text_input("Enter the Updated Player Specialist")
                        elif selected_player_attribute=="CountryID":
                            player_update_value=st.number_input("Enter the Updated Player CountryID",min_value=1,step=1)
                        elif selected_player_attribute == "FranchiseID":
                            player_update_value = st.number_input("Enter the Updated Player PlayerID", min_value=1, step=1)

                        if st.button("Update data"):
                        # Construct the SQL update query
                            update_query = f"UPDATE PLAYER SET {selected_player_attribute} = '{player_update_value}' WHERE PlayerID = {player_update_id}"
                            if execute_insert_query(connection, update_query):
                                st.success("Data updated successfully!")
                    
                    if selected_update_table=="overallbattingstats":
                        selected_overallbattingstats_attribute=st.selectbox("Select the attribute of Overall Batting Stats table to be updated",["Runs","StrikeRate","BattingAverage","NumberOf100s","NumberOf50s"])
                        overallbattingstats_update_id=st.number_input("PlayerID",min_value=1,step=1)
                        if selected_overallbattingstats_attribute == "Runs":
                            overallbattingstats_update_value = st.number_input("Enter the Updated Runs",min_value=0,step=1)
                        elif selected_overallbattingstats_attribute == "StrikeRate":
                            overallbattingstats_update_value = st.number_input("Enter the Updated StrikeRate")
                        elif selected_overallbattingstats_attribute == "BattingAverage":
                            overallbattingstats_update_value=st.number_input("Enter the Updated Batting Average")
                        elif selected_overallbattingstats_attribute=="NumberOf100s":
                            overallbattingstats_update_value = st.number_input("Enter the Updated NumberOf100s", min_value=0, step=1)
                        elif selected_overallbattingstats_attribute=="NumberOf50s":
                            overallbattingstats_update_value=st.number_input("Enter the Updated Number of 50s",min_value=1,step=1)

                        if st.button("Update data"):
                        # Construct the SQL update query
                            update_query = f"UPDATE OVERALLBATTINGSTATS SET {selected_overallbattingstats_attribute} = '{overallbattingstats_update_value}' WHERE PlayerID = {overallbattingstats_update_id}"
                            if execute_insert_query(connection, update_query):
                                st.success("Data updated successfully!")
                    
                    if selected_update_table=="overallbowlingstats":
                        selected_overallbowlingstats_attribute=st.selectbox("Select the attribute of Overall Bowling Stats table to be updated",["Wickets","Economy","BowlingAverage","FiveWicketHauls"])
                        overallbowlingstats_update_id=st.number_input("PlayerID",min_value=1,step=1)
                        if selected_overallbowlingstats_attribute == "Wickets":
                            overallbowlingstats_update_value = st.number_input("Enter the Updated Wickets",min_value=0,step=1)
                        elif selected_overallbowlingstats_attribute == "Economy":
                            overallbowlingstats_update_value = st.number_input("Enter the Updated Economy")
                        elif selected_overallbowlingstats_attribute == "BowlingAverage":
                            overallbowlingstats_update_value=st.number_input("Enter the Updated Bowling Average")
                        elif selected_overallbowlingstats_attribute=="FiveWicketHauls":
                            overallbowlingstats_update_value = st.number_input("Enter the Updated FiveWicketHauls", min_value=0, step=1)

                        if st.button("Update data"):
                        # Construct the SQL update query
                            update_query = f"UPDATE OVERALLBOWLINGSTATS SET {selected_overallbowlingstats_attribute} = '{overallbowlingstats_update_value}' WHERE PlayerID = {overallbowlingstats_update_id}"
                            if execute_insert_query(connection, update_query):
                                st.success("Data updated successfully!")
                            
                    if selected_update_table=="recentperformance":
                        selected_recentperformance_attribute=st.selectbox("Select the attribute of Recent Performance table to be updated",["Runs","Wickets","Economy","StrikeRate"])
                        recentperformance_update_id=st.number_input("PlayerID",min_value=1,step=1)
                        if selected_recentperformance_attribute == "Runs":
                            recentperformance_update_value = st.number_input("Enter the Updated Runs",min_value=0,step=1)
                        elif selected_recentperformance_attribute == "Wickets":
                            recentperformance_update_value = st.number_input("Enter the Updated Wickets",min_value=0,step=1)
                        elif selected_recentperformance_attribute == "Economy":
                            recentperformance_update_value=st.number_input("Enter the Updated Economy")
                        elif selected_recentperformance_attribute=="StrikeRate":
                            recentperformance_update_value = st.number_input("Enter the Updated StrikeRate")

                        if st.button("Update data"):
                        # Construct the SQL update query
                            update_query = f"UPDATE RECENTPERFORMANCE SET {selected_recentperformance_attribute} = '{recentperformance_update_value}' WHERE PlayerID = {recentperformance_update_id}"
                            if execute_insert_query(connection, update_query):
                                st.success("Data updated successfully!")
                    
                    if selected_update_table=="selectors":
                        selected_selectors_attribute=st.selectbox("Select the attribute of Selectors table to be updated",["Selectors Name","FranchiseID"])
                        selectors_update_id=st.number_input("SelectorID",min_value=1,step=1)
                        if selected_selectors_attribute == "Selectors Name":
                            selectors_update_value = st.text_input("Enter the Updated Selector Name")
                        elif selected_selectors_attribute == "FranchiseID":
                            selectors_update_value = st.number_input("Enter the Updated FranchiseID", min_value=1, step=1)
                        if st.button("Update data"):
                        # Construct the SQL update query
                            update_query = f"UPDATE SELECTORS SET {selected_selectors_attribute} = '{selectors_update_value}' WHERE SelectorID = {selectors_update_id}"
                            if execute_insert_query(connection, update_query):
                                st.success("Data updated successfully!")
                        

                            

                # Section for data deletion
                if selected_option == "Delete Data from the table":
                    st.subheader("Delete Data from the table")
                    selected_delete_table = st.selectbox("Select the table to delete from", st.session_state.user['privileges']['Delete'])
                    if len(st.session_state.user['privileges']['Delete'])!=0:
                        player_id_to_delete=st.number_input("Enter the player id to be deleted",min_value=1,step=1)
                        if st.button("Delete Data"):
                            delete_query=f"DELETE FROM {selected_delete_table} WHERE PLAYERID={player_id_to_delete}"
                            if execute_insert_query(connection,delete_query):
                                st.success("Data deleted successfully!")
                            # Your code for data deletion based on the selected table
                        
                if selected_option == "Player Analysis":
                    st.subheader("In-depth Player Analysis")
                    selected_query_table = st.selectbox("Select the parameter based on which you wish to retrieve the player", ["Players from a specific country","Power-hitters with most runs","Franchise with most runs and wickets","Best All-rounders"])

                    if selected_query_table == "Players from a specific country":
                        selected_country = st.selectbox("Select the country", ["India", "Australia", "England", "Afganistan","Bangladesh","Pakistan","New Zealand","South Africa","Sri Lanka","West Indies","Ireland","Zimbabwe","Netherlands","Scotland","Canada"])
                        if st.button("Run Analysis"):
                            # Perform a nested query to get players from the selected country
                            query = f"SELECT PlayerName FROM player WHERE CountryID = (SELECT CountryID FROM country WHERE CountryName = '{selected_country}')"
                            result, columns = execute_select_query(connection, query)

                            if result:
                                st.dataframe(pd.DataFrame(result, columns=columns))
                            else:
                                st.warning("No data found.")
                    
                    if selected_query_table=="Power-hitters with most runs":
                        selected_sr=st.number_input("Enter the mimimum strike-rate",min_value=1,max_value=600)
                        selected_runs=st.number_input("Enter the minimum number of runs",min_value=1)
                        if st.button("Run Analysis"):
                            query=f"SELECT player.PlayerName,overallbattingstats.strikeRate,overallbattingstats.runs from player join overallbattingstats on player.playerid=overallbattingstats.playerid where overallbattingstats.runs>'{selected_runs}' and overallbattingstats.strikerate>'{selected_sr}' order by runs desc,strikerate desc"
                            result, columns = execute_select_query(connection, query)

                            if result:
                                st.dataframe(pd.DataFrame(result, columns=columns))
                            else:
                                st.warning("No data found.")
                    
                    if selected_query_table=="Franchise with most runs and wickets":
                        selected_option=st.selectbox("Select runs/wickets",["runs","wickets"])
                        if st.button("Run Analysis"):
                            if selected_option=="runs":
                                query=f"SELECT f.FranchiseName, SUM(op.Runs) AS TotalRuns FROM franchise f JOIN player p ON f.FranchiseID = p.FranchiseID JOIN overallbattingstats op ON p.PlayerID = op.PlayerID GROUP BY f.FranchiseID ORDER BY TotalRuns DESC"
                                result, columns = execute_select_query(connection, query)

                                if result:
                                 st.dataframe(pd.DataFrame(result, columns=columns))
                                else:
                                    st.warning("No data found.")
                                    
                            if selected_option=="wickets":
                                query=f"SELECT f.FranchiseName, SUM(op.Wickets) AS TotalWickets FROM franchise f JOIN player p ON f.FranchiseID = p.FranchiseID JOIN overallbowlingstats op ON p.PlayerID = op.PlayerID GROUP BY f.FranchiseID ORDER BY TotalWickets DESC"
                                result, columns = execute_select_query(connection, query)

                                if result:
                                 st.dataframe(pd.DataFrame(result, columns=columns))
                                else:
                                    st.warning("No data found.")
                                    
                    if selected_query_table == "Best All-rounders":
                        number_players = st.number_input("Enter the number of players to be retrieved:", min_value=1, step=1)

                        if st.button("Run Analysis"):
                            # Execute the stored procedure
                            result, columns = execute_procedure_query(connection,number_players,)

                            if result:
                                st.dataframe(pd.DataFrame(result, columns=columns))
                            else:
                                st.warning("No data found.")
                    
                    
                    

                # Section for data selection
                if selected_option == "Select Data from the table":
                    st.subheader("Select Data from the tables")
                    selected_select_table = st.selectbox("Select the table to retrieve data from", st.session_state.user['privileges']['Select'])

                    if st.button("Select Data"):
                                # SQL query to retrieve data
                                select_query = f"SELECT * FROM {selected_select_table}"
                                # Execute and display the query result
                                cursor = connection.cursor()
                                cursor.execute(select_query)
                                data = cursor.fetchall()
                                column_names = [i[0] for i in cursor.description]
                                cursor.close()

                                # Display the selected data in a table format
                                st.write(f"Data from {selected_select_table} :")
                                df = pd.DataFrame(data,columns=column_names)
                                st.table(df)
                                
                                
                if selected_option=="Insert Data to the table":
                    st.subheader("Insert Data into the tables")
                    selected_table = st.selectbox("Select the table to insert", st.session_state.user['privileges']['Insert'])
                    if selected_table == "coach":
                                # coach_id = st.number_input("CoachID", min_value=1, max_value=9999, step=1)
                                coach_name = st.text_input("CoachName")
                                coach_specialist = st.text_input("Specialist")
                                coach_franchise_id = st.number_input("FranchiseID", min_value=1, max_value=9999, step=1)
                                
                                if st.button("Insert Data"):
                                    insert_query = f"INSERT INTO coach (CoachName, Specialist, FranchiseID) VALUES ('{coach_name}', '{coach_specialist}', {coach_franchise_id})"
                                    if execute_insert_query(connection, insert_query):
                                        st.success("Data inserted successfully!")

                    elif selected_table == "country":
                                # country_id = st.number_input("CountryID", min_value=1, max_value=9999, step=1)
                                country_name = st.text_input("CountryName")
                                
                                if st.button("Insert Data"):
                                    insert_query = f"INSERT INTO country (CountryName) VALUES ('{country_name}')"
                                    if execute_insert_query(connection, insert_query):
                                        st.success("Data inserted successfully!")

                    elif selected_table == "franchise":
                                # franchise_id = st.number_input("FranchiseID", min_value=1, max_value=9999, step=1)
                                franchise_name = st.text_input("Franchise Name")
                                franchise_trophies = st.number_input("Trophies", min_value=0, max_value=9999, step=1)
                                franchise_team_points = st.number_input("Team Points", min_value=0, max_value=9999, step=1)
                                franchise_league_id = st.number_input("League ID", min_value=1, max_value=9999, step=1)
                                
                                if st.button("Insert Data"):
                                    insert_query = f"INSERT INTO franchise (FranchiseName, Trophies, TeamPoints, LeagueID) VALUES ('{franchise_name}', {franchise_trophies}, {franchise_team_points}, {franchise_league_id})"
                                    if execute_insert_query(connection, insert_query):
                                        st.success("Data inserted successfully!")

                    elif selected_table == "league":
                                # league_id = st.number_input("League ID", min_value=1, max_value=9999, step=1)
                                league_name = st.text_input("League Name")
                                league_host_id = st.number_input("Host ID", min_value=1, max_value=9999, step=1)
                                
                                if st.button("Insert Data"):
                                    insert_query = f"INSERT INTO league (LeagueName, HostID) VALUES ('{league_name}', {league_host_id})"
                                    if execute_insert_query(connection, insert_query):
                                        st.success("Data inserted successfully!")

                    elif selected_table == "overallbattingstats":
                                batting_runs = st.number_input("Runs", min_value=0, max_value=9999, step=1)
                                batting_strike_rate = st.number_input("Strike Rate")
                                batting_average = st.number_input("Batting Average")
                                batting_100s = st.number_input("Number of 100s", min_value=0, max_value=9999, step=1)
                                batting_50s = st.number_input("Number of 50s", min_value=0, max_value=9999, step=1)
                                batting_player_id = st.number_input("PlayerID", min_value=1, max_value=9999, step=1)
                                
                                if st.button("Insert Data"):
                                    insert_query = f"INSERT INTO overallbattingstats (Runs, StrikeRate, BattingAverage, Numberof100s, Numberof50s, PlayerID) VALUES ({batting_runs}, {batting_strike_rate}, {batting_average}, {batting_100s}, {batting_50s}, {batting_player_id})"
                                    if execute_insert_query(connection, insert_query):
                                        st.success("Data inserted successfully!")

                    elif selected_table == "overallbowlingstats":
                                bowling_wickets = st.number_input("Wickets", min_value=0, max_value=9999, step=1)
                                bowling_average = st.number_input("Bowling average")
                                bowling_economy = st.number_input("Economy")
                                bowling_5w = st.number_input("Five Wicket Hauls", min_value=0, max_value=9999, step=1)
                                bowling_player_id = st.number_input("PlayerID", min_value=1, max_value=9999, step=1)
                                
                                if st.button("Insert Data"):
                                    insert_query = f"INSERT INTO overallbowlingstats (Wickets, BowlingAverage, Economy, FiveWicketHauls, PlayerID) VALUES ({bowling_wickets}, {bowling_average}, {bowling_economy}, {bowling_5w}, {bowling_player_id})"
                                    if execute_insert_query(connection, insert_query):
                                        st.success("Data inserted successfully!")

                    elif selected_table == "player":
                                # player_id = st.number_input("PlayerID", min_value=1, max_value=9999, step=1)
                                player_name = st.text_input("PlayerName")
                                player_matches = st.number_input("Matches", min_value=1, max_value=9999, step=1)
                                player_specialist = st.text_input("Specialist")
                                player_country_id = st.number_input("CountryID", min_value=1, max_value=9999, step=1)
                                player_franchise_id = st.number_input("FranchiseID", min_value=1, max_value=9999, step=1)
                                if st.button("Insert Data"):
                                # SQL query for insertion
                                    insert_query = f"INSERT INTO player(playername,matches,specialist,countryid,franchiseid) VALUES ('{player_name}', {player_matches},'{player_specialist}', {player_country_id},{player_franchise_id})"
                                    if execute_insert_query(connection, insert_query):
                                        st.success("Data inserted successfully!")
                                    
                    elif selected_table == "recentperformance":
                                wickets = st.number_input("Wickets", min_value=0, max_value=9999, step=1)
                                runs = st.number_input("Runs", min_value=0, max_value=9999, step=1)
                                economy = st.number_input("Economy")
                                strike_rate = st.number_input("Strike Rate")
                                player_id = st.number_input("PlayerID", min_value=1, max_value=9999, step=1)
                                
                                if st.button("Insert Data"):
                                    insert_query = f"INSERT INTO recentperformance (Wickets, Runs, Economy, StrikeRate, PlayerID) VALUES ({wickets}, {runs}, {economy}, {strike_rate}, {player_id})"
                                    if execute_insert_query(connection, insert_query):
                                        st.success("Data inserted successfully!")

                    elif selected_table == "selectors":
                                # selector_id = st.number_input("SelectorID", min_value=1, max_value=9999, step=1)
                                selector_name = st.text_input("Selector Name")
                                selector_franchise_id = st.number_input("FranchiseID", min_value=1, max_value=9999, step=1)
                                
                                if st.button("Insert Data"):
                                    insert_query = f"INSERT INTO selectors (SelectorName, FranchiseID) VALUES ('{selector_name}', {selector_franchise_id})"
                                    execute_insert_query(connection, insert_query)
                                    st.success("Data inserted successfully!")
                                
                            # Input fields based on the selected table
                    st.write("")
            

        else:
            st.error("Failed to connect to the MySQL database.")

if __name__ == '__main__':
    main()