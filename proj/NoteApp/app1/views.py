from django.shortcuts import render
from django.conf import settings

from os import listdir
from os.path import isfile, join

from os import walk

# Create your views here.

def index(request):
   
    # TODO focusPath will be updated by using request
    focusPath = settings.BASE_DIR+"/storage/data/0"

    focusInfo = []
    with open(focusPath+"/.init.noteapp",'r') as ff:
        ff.readline(); focusInfo.append(ff.readline()); ff.readline()
        ff.readline(); focusInfo.append(ff.readline()); ff.readline()

    focusFiles = [];focusDirs = [];
    for (dirpath, dirnames, filenames) in walk(focusPath):
        focusFiles.extend(filenames); focusFiles.remove('.init.noteapp')
        focusDirs.extend(dirnames)
        break

    focusDirNames = []
    for dir_x in focusDirs:
        with open(focusPath+"/"+dir_x+"/.init.noteapp",'r') as ff:
            ff.readline();focusDirNames.append(ff.readline().strip());ff.readline()


    context = {"focusPath":focusPath,
                "focusName":focusInfo[0].strip(),
                "focusDirs":focusDirs,
                "focusDirNames":focusDirNames,
                "focusFiles":focusFiles }
    return render(request, 'index.html', context)
