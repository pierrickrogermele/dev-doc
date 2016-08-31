def get_opt_values(length):
    cols = []
    for i, j in enumerate(range(length)):
        cols.append( (str(j), str(j), i == 0) )
    return cols
