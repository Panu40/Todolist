from rest_framework import serializers
from .models import Todolist

class TodolistSerializers(serializers.ModelSerializer):
    class Meta:
        model = Todolist
        fields = ('id','title','detail') # '__all__'
