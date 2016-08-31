def get_opt_values(length):
    cols = []
    for i, j in enumerate(range(length)):
        cols.append( (str(j), str(j), i == 0) )
    return cols

def get_opt_values_2(typ):
    cols = []
    for i, j in enumerate(range(3)):
        cols.append( (typ + str(j), typ + str(j), i == 0) )
    return cols
