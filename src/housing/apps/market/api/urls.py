from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token


urlpatterns = [
    path('obtain-token/', obtain_auth_token, name='auth_token'),
]