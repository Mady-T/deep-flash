import sqlite3

def inputdeck():
    print("Enter Deck")
    flag= True
    i= 1
    deck= []

    while(flag is True):
        flash= []
        qtn= input(f"Question {i}: ")
        ans= input("Answer: ")
        flash.append(qtn)
        flash.append(ans)
        deck.append(flash)
        i+= 1
        n= int(input("Exit? (0 for No/ 1 for Yes) : "))
        if(n==1):
            flag= False
    return deck

def createdeck(cursor, tablename):
    cursor.execute("CREATE TABLE {} (ID INTEGER, QUESTION CHAR(200), ANSWER CHAR(200), ITEM_DIFFICULTY REAL, TIME_CURR INTEGER, MEMORY_STRENGTH INTEGER, PRIMARY KEY(ID));".format(tablename))
    i= 1
    for flashcard in deck:
        cursor.execute("INSERT INTO {} VALUES (?, ?, ?, ?, ?, ?)".format(tablename),(i, flashcard[0], flashcard[1], 2.5, -1, 3))
        i+= 1

topic= input("Enter topic: ").lower()
deck= inputdeck()

conn= sqlite3.connect("{}.db".format(topic))
cursor= conn.cursor()
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables= cursor.fetchall()
if tables:
    val= tables[len(tables)-1][0]
    num= int(val[4])
    tablename= "DECK"+str(num+1)
else:
    tablename= "DECK1"

createdeck(cursor, tablename)
conn.commit()
conn.close()