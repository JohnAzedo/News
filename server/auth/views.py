from django.contrib.auth.models import User
from django.shortcuts import render

# Create your views here.
from rest_framework.generics import CreateAPIView, ListCreateAPIView, RetrieveAPIView
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from auth.models import InviteCode
from auth.serializers import RegisterSerializer, InviteCodeSerializer


class RegisterView(ListCreateAPIView):
    permission_classes = [AllowAny]
    serializer_class = RegisterSerializer
    queryset = User.objects.all()


class CheckInviteCodeView(RetrieveAPIView):
    permission_classes = [AllowAny]
    serializer_class = InviteCodeSerializer
    lookup_field = 'code'
    queryset = InviteCode.objects.all()
