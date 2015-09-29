import linecache

def data(temp, filename):
    data = linecache.getlines(filename)
    linecache.clearcache()
    for i in range(1, len(data)):
        if data[i].split() != []:
            temp.append(float(data[i].split()[1].split("'")[1]))

temp = []
for i in range(0, 7):
    filename = "pe_val_2015071"+str(i)+".txt"
    data(temp, filename)

output = open('temp_data.txt','w')
for t in temp:
    output.write("%s\n" % str(t))
    
output.close()