from django.contrib.auth.models import User
from rest_framework.serializers import ModelSerializer


class RegisterSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'email', 'username', )

    def create(self, validated_data):
        user = User.objects.create(
            login=validated_data['login'],
            email=validated_data['email'],
            nome=validated_data['nome'],
            cpf=validated_data['cpf'],
            nascimento=validated_data['nascimento']
        )

        user.set_password(validated_data['password'])
        user.save()

        return user
