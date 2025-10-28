# cinema/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('filme/', views.filme, name='filme'),
    path('actori/', views.actori, name='actori'),
    path('producatori/', views.producatori, name='producatori'),
]