from django.shortcuts import render
from django.conf import settings

from os import listdir
from os.path import isfile, join

from os import walk

# Create your views here.

def index(request):
   
    # TODO focusPath will be updated by using request
    focusPath = settings.BASE_DIR+"/storage/data/0"
    focusInfoPath = focusPath+"/.init.noteapp"

    focusFiles = [];focusDirs = [];
    for (dirpath, dirnames, filenames) in walk(focusPath):
        focusFiles.extend(filenames); focusFiles.remove('.init.noteapp')
        focusDirs.extend(dirnames)
        break

    focusInfo = []
    with open(focusInfoPath,'r') as ff:
        ff.readline(); focusInfo.append(ff.readline()); ff.readline()
        ff.readline(); focusInfo.append(ff.readline()); ff.readline()

    print(range(1,3))

    context = {"focusPath":focusPath,
                "focusName":focusInfo[0].strip(),
                "focusDirs":focusDirs, 
                "focusFiles":focusFiles }
    return render(request, 'index.html', context)
