from django.shortcuts import render
from django.db import connection

def index(request):
    return render(request, 'index.html')


def filme(request):
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT 
                f.id_film, f.titlu, f.gen, f.an_lansare, f.durata_min, f.rating,
                GROUP_CONCAT(DISTINCT a.nume SEPARATOR ', ') AS actori,
                GROUP_CONCAT(DISTINCT p.nume SEPARATOR ', ') AS producatori
            FROM filme f
            LEFT JOIN actori a ON a.id_film = f.id_film
            LEFT JOIN producatori p ON p.id_producator = a.id_producator
            GROUP BY f.id_film, f.titlu, f.gen, f.an_lansare, f.durata_min, f.rating
            ORDER BY f.an_lansare DESC;
        """)
        filme = cursor.fetchall()
    return render(request, 'filme.html', {'filme': filme})


def actori(request):
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT 
                a.id_actor, a.nume, a.rol, 
                f.titlu AS film, 
                p.nume AS producator
            FROM actori a
            JOIN filme f ON a.id_film = f.id_film
            JOIN producatori p ON a.id_producator = p.id_producator
            ORDER BY a.nume;
        """)
        actori = cursor.fetchall()
    return render(request, 'actori.html', {'actori': actori})


def producatori(request):
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT 
                p.id_producator, p.nume, p.tara_origine, p.an_fondare,
                COUNT(DISTINCT a.id_actor) AS nr_actori,
                COUNT(DISTINCT a.id_film) AS nr_filme
            FROM producatori p
            LEFT JOIN actori a ON p.id_producator = a.id_producator
            GROUP BY p.id_producator, p.nume, p.tara_origine, p.an_fondare
            ORDER BY p.nume;
        """)
        producatori = cursor.fetchall()
    return render(request, 'producatori.html', {'producatori': producatori})
