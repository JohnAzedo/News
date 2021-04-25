from rest_framework import serializers
from rest_framework.serializers import ModelSerializer
from news.models import News, Comment


class NewsListSerializer(ModelSerializer):
    class Meta:
        model = News
        fields = ('id', 'title', 'created_at', 'author', 'number_comments', 'number_likes')


class CommentSerializer(ModelSerializer):
    user = serializers.StringRelatedField(many=False, source='user.get_full_name')

    class Meta:
        model = Comment

        fields = ['id', 'user', 'text', 'created_at']


class NewsSerializer(ModelSerializer):
    comments = CommentSerializer(many=True)

    class Meta:
        model = News
        fields = ['id', 'title', 'subtitle', 'author', 'number_likes', 'number_comments', 'image', 'text', 'comments', 'created_at']