from rest_framework import serializers
from rest_framework.serializers import ModelSerializer
from news.models import News


class NewsListSerializer(ModelSerializer):
    class Meta:
        model = News
        fields = ('id', 'title', 'created_at', 'author', 'comments', 'likes')


class NewsSerializer(ModelSerializer):
    class Meta:
        model = News
        fields = ('id', 'title', 'subtitle', 'author', 'likes', 'image', 'text', 'comments', 'created_at')