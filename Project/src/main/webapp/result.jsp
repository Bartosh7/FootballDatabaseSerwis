<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pjatk.tpo.tpo_baza.SearchServlet.Person" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Wyniki Wyszukiwania</title>
    <style>
        body {
            background-image: url('images/stadium2.jpg');
            background-size: cover;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .content {
            background-color: rgba(255, 255, 255, 0.2);
            padding: 20px;
            border-radius: 10px;
            margin: 0px auto;
            max-width: 1200px;
            width: 100%;
            height: 80vh;
            overflow-y: scroll;
            scrollbar-width: none;
        }
        .content::-webkit-scrollbar {
            display: none;
        }
        h1 {
            text-align: center;
            color: white;
            font-size: 70px;
            text-shadow: -1px -1px 0 #000,
            1px -1px 0 #000,
            -1px 1px 0 #000,
            1px 1px 0 #000;
            margin-bottom: 0px;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 16px;
        }
        .card {
            flex: 1 0 300px;
            max-width: 300px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 16px;
            background-color: #fff;
            text-decoration: none;
            color: inherit;
        }
        .card h3 {
            margin-top: 0;
        }
        .card p {
            margin: 8px 0;
        }
        .back-button-container {
            text-align: center;
            margin: 20px 0;
        }
        .back-button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #230da2;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none;
        }
        .back-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<h1>Wyniki Wyszukiwania</h1>
<div class="content">
    <div class="container">
        <%
            List<Person> results = (List<Person>) request.getAttribute("results");
            if (results != null) {
                for (Person person : results) {
                    String wikiUrl = "https://pl.wikipedia.org/wiki/" + person.getName().replace(" ", "_") + "_" + person.getSurname().replace(" ", "_");
        %>
        <a class="card" href="<%= wikiUrl %>" target="_blank">
            <h3><%= person.getName() %> <%= person.getSurname() %></h3>
            <p><strong>Funkcja:</strong> <%= person.getFunction() %></p>
            <p><strong>Data urodzenia:</strong> <%= person.getBirthDate() %></p>
            <p><strong>Reprezentacja:</strong> <%= person.getCountry() %></p>
            <div style="text-align: right;">
                <img src="images/<%= person.getCountry().toLowerCase() %>.png" alt="<%= person.getCountry() %>" style="width: 50px; height: auto;">
            </div>
        </a>
        <%
                }
            }
        %>
    </div>
</div>
<div class="back-button-container">
    <a class="back-button" href="index.jsp">Powrót do strony głównej</a>
</div>
</body>
</html>
