from django.shortcuts import render
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from .serializers import TodolistSerializers
from .models import Todolist


# Get Data
@api_view(['GET'])
def all_todolist(request):
    alltodolist = Todolist.objects.all() # select * from data
    serializer = TodolistSerializers(alltodolist,many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)



# POST DATA (save data to Database)
@api_view(['POST'])
def post_todolist(request):
    if request.method == 'POST':
        serializer = TodolistSerializers(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        return Response(serializer.error,status=status.HTTP_404_NOT_FOUND)


# PUT DATA (UPDATE DATA)
@api_view(['PUT'])
def update_todolist(request,TID):
    # localhost:8000/api/update-todolist/TID
    todo = Todolist.objects.get(id=TID)

    if request.method == 'PUT':
        data = {}
        serializer = TodolistSerializers(todo,data=request.data)
        if serializer.is_valid():
            serializer.save()
            data['status'] = 'updated'
            return Response(data=data,status=status.HTTP_201_CREATED) # ดู HTTP status code ได้ใน google
        return Response(serializer.errors,status=status.HTTP_404_NOT_FOUND)


# DELETE DATA (DELETE DATA)
@api_view(['DELETE'])
def delete_todolist(request,TID):
    todo = Todolist.objects.get(id=TID)

    if request.method == 'DELETE':
        delete = todo.delete()
        data = {}
        if delete:
            data['status'] = 'deleted'
            statuscode = status.HTTP_200_OK # ดู HTTP status code ได้ใน google
        else:
            data['status'] = 'failed'
            statuscode = status.HTTP_400_BAD_REQUEST # ดู HTTP status code ได้ใน google
        
        return Response(data=data,status=statuscode)
       
        
           





data = [{'message':'สวัสดี Panu'},{'message':'hello Boat'}]

def Home(request):
    return JsonResponse(data=data,safe=False,json_dumps_params={'ensure_ascii':False}) #json_dumps_params={'ensure_ascii':False} ใส่เพื่อให้ใช้ภาษาไทยได้
