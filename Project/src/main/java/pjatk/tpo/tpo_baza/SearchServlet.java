package pjatk.tpo.tpo_baza;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String nazwisko = request.getParameter("nazwisko");
        String narodowosc = request.getParameter("narodowosc");
        String typ = request.getParameter("typ");

        List<Person> results = searchDatabase(nazwisko, narodowosc, typ);

        request.setAttribute("results", results);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }

    private List<Person> searchDatabase(String nazwisko, String narodowosc, String typ) {
        List<Person> results = new ArrayList<>();
        Connection connection = null;
        try {

            String url = "jdbc:oracle:thin:@//db-oracle02.pjwstk.edu.pl:1521/baza.pjwstk.edu.pl";
            String user = "s27471";
            String password = "";
            connection = DriverManager.getConnection(url, user, password);

            if (!typ.equals("pilkarz") && !typ.equals("trener")) {
                results.addAll(searchPlayers(connection, nazwisko, narodowosc));
                results.addAll(searchCoaches(connection, nazwisko, narodowosc));
            } else if (typ.equals("pilkarz")) {
                results.addAll(searchPlayers(connection, nazwisko, narodowosc));
            } else if (typ.equals("trener")) {
                results.addAll(searchCoaches(connection, nazwisko, narodowosc));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return results;
    }

    private List<Person> searchPlayers(Connection connection, String nazwisko, String narodowosc) {
        List<Person> players = new ArrayList<>();
        try {
            Statement statement = connection.createStatement();
            String query = "SELECT p.PersonID, p.Name, p.Surname, p.BierthDate, p.Country_Name " +
                    "FROM Person p " +
                    "JOIN Player pl ON p.PersonID = pl.Person_PlayerID " +
                    "WHERE p.Surname LIKE '%" + nazwisko + "%' " +
                    (narodowosc.isEmpty() ? "" : "AND p.Country_Name = '" + narodowosc + "'");
            ResultSet rs = statement.executeQuery(query);
            while (rs.next()) {
                int personID = rs.getInt("PersonID");
                String name = rs.getString("Name");
                String surname = rs.getString("Surname");
                Date birthDate = rs.getDate("BierthDate");
                String country = rs.getString("Country_Name");

                Person person = new Person(personID, name, surname, birthDate, country, "pilkarz");
                players.add(person);
            }
            rs.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return players;
    }

    private List<Person> searchCoaches(Connection connection, String nazwisko, String narodowosc) {
        List<Person> coaches = new ArrayList<>();
        try {
            Statement statement = connection.createStatement();
            String query = "SELECT p.PersonID, p.Name, p.Surname, p.BierthDate, p.Country_Name " +
                    "FROM Person p " +
                    "JOIN Coach c ON p.PersonID = c.Person_CoachID " +
                    "WHERE p.Surname LIKE '%" + nazwisko + "%' " +
                    (narodowosc.isEmpty() ? "" : "AND p.Country_Name = '" + narodowosc + "'");
            ResultSet rs = statement.executeQuery(query);
            while (rs.next()) {
                int personID = rs.getInt("PersonID");
                String name = rs.getString("Name");
                String surname = rs.getString("Surname");
                Date birthDate = rs.getDate("BierthDate");
                String country = rs.getString("Country_Name");

                Person person = new Person(personID, name, surname, birthDate, country, "trener");
                coaches.add(person);
            }
            rs.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return coaches;
    }

    public static class Person {
        private int personID;
        private String name;
        private String surname;
        private Date birthDate;
        private String country;
        private String function;

        public Person(int personID, String name, String surname, Date birthDate, String country, String function) {
            this.personID = personID;
            this.name = name;
            this.surname = surname;
            this.birthDate = birthDate;
            this.country = country;
            this.function = function;
        }

        // Getters
        public int getPersonID() {
            return personID;
        }

        public String getName() {
            return name;
        }

        public String getSurname() {
            return surname;
        }

        public Date getBirthDate() {
            return birthDate;
        }

        public String getCountry() {
            return country;
        }

        public String getFunction() {
            return function;
        }
    }
}
