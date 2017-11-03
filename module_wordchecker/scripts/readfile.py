def readTextFileReturnString(filename):
    temptext = ''
    with open(filename, 'r') as file:
        temptext = file.readlines()
    print(temptext)
    print(filename)
    return temptext