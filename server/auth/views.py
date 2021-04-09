from django.contrib.auth.models import User
from django.shortcuts import render

# Create your views here.
from rest_framework.generics import CreateAPIView, ListCreateAPIView
from rest_framework.permissions import AllowAny

from auth.serializers import RegisterSerializer


class RegisterView(ListCreateAPIView):
    permission_classes = [AllowAny]
    serializer_class = RegisterSerializer
    queryset = User.objects.all()