import sqlite3
conn = sqlite3.connect("KongregateDatabaseALL.sql")
cursor = conn.cursor()
cursor.execute("Select * From games")
cursor.execute("insert into badges values(2, 'La Game', 2)")
cursor.execute("select * from badges")
cursor.execute("delete * from badges where Badges.Badge_name = 'La Game'")
conn.close()