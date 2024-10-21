<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Euro 2012-Baza Danych</title>
    <style>
        body {
            background-image: url('images/stadium.jpg');
            background-size: cover;

        }
        .title {
            text-align: center;
            font-size: 90px;
            font-family: Arial, sans-serif;
            color: white;
            margin-top: 5%;
            text-shadow: -1px -1px 0 #000,
            1px -1px 0 #000,
            -1px 1px 0 #000,
            1px 1px 0 #000;
        }
        .search-container {
            text-align: center;
            margin-top: 140px;
        }
        .search-title {
            font-size: 40px;
            font-family: Arial, sans-serif;
            color: white;
            text-shadow: -1px -1px 0 #000,
            1px -1px 0 #000,
            -1px 1px 0 #000,
            1px 1px 0 #000;
        }
        .search-input {
            padding: 10px;
            margin-bottom: 10px;
            border: 2px solid #ccc;
            border-radius: 5px;
            outline: none;
            transition: border-color 0.3s;
        }
        .search-input:focus {
            border-color: #666;
        }
        .search-select {
            padding: 10px;
            margin-bottom: 10px;
            border: 2px solid #ccc;
            border-radius: 5px;
            outline: none;
            transition: border-color 0.3s;
        }
        .search-select:focus {
            border-color: #565555;
        }
        .search-button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #230da2;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .search-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<h1 class="title">Euro 2012-Baza Danych</h1>
<div class="search-container">
    <h2 class="search-title">Wyszukiwarka piłkarzy i trenerów</h2>
    <form action="search" method="get">
        <input class="search-input" type="text" name="nazwisko" placeholder="Wpisz nazwisko piłkarza">
        <select class="search-select" name="narodowosc">
            <option value="">Wybierz narodowość</option>
            <option value="Polska">Polska</option>
            <option value="Włochy">Włochy</option>

        </select>
        <select class="search-select" name="typ">
            <option value="">Wybierz typ</option>
            <option value="pilkarz">Piłkarz</option>
            <option value="trener">Trener</option>
        </select>
        <br>
        <button class="search-button" type="submit">Szukaj</button>
    </form>
</div>
<br/>
</body>
</html>
