from django.shortcuts import render
from django.conf import settings

# Create your views here.

def index(request):


    context = {"var1":"","var2":settings.BASE_DIR}
    return render(request, 'index.html', context)
