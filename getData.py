import MySQLdb

sql = 'select * from status'
try:
    conn=MySQLdb.connect(host='10.1.0.5',user='root',passwd='root123',db='monitor',port=3306)
    cur=conn.cursor()
    cur.execute(sql)
    rows = cur.fetchall()
    output = open('data.txt','w')
    for row in rows:
        status = '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' %(row[0],row[1].strftime('%Y-%m-%d %H:%M:%S'), str(row[2]), str(row[3]), str(row[4]), str(row[5]), str(row[6]), str(row[7]), str(row[8]))
        output.write(str(status))
    output.close()
    cur.close()
    conn.close()
except MySQLdb.Error,e:
    output = open('status.txt','a')
    output.write("\nSQL: %s\n" % (sql))
    output.write("Mysql Error %d: %s\n" % (e.args[0], e.args[1]))
    output.close()
