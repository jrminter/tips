from sqlite3 import dbapi2 as sqlite

connection = sqlite.connect("experiments.db")
cursor = connection.cursor()
cursor.execute("SELECT FirstName, Lastname FROM Person ORDER BY LastName;")
results = cursor.fetchall();
for r in results:
    print(r[0], r[1])
cursor.close();
connection.close();
