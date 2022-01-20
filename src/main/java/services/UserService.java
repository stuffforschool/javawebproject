package services;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import connection.Connexion;
import entities.Room;
import entities.User;
import utils.ErrorResponse;
import utils.Hash;
import utils.MailSender;
import utils.RegisterResponse;

public class UserService {

	public ErrorResponse validateRegister(User o) {
		if (o.getUsername().equals("") || o.getUsername().length() < 4 || o.getUsername().length() > 16 ) {
			return new ErrorResponse("username", "A");
		}
		if (Pattern.compile("[^a-z0-9 ]", Pattern.CASE_INSENSITIVE).matcher(o.getUsername()).find()) {
			return new ErrorResponse("username", "B");
		}

		if (o.getPassword().equals("") || o.getPassword().length() < 3 || o.getPassword().length() > 16) {
			return new ErrorResponse("password", "A");
		}

		Pattern pattern = Pattern.compile("[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}");
		Matcher mat = pattern.matcher(o.getEmail());

		if (!mat.matches()) {
			return new ErrorResponse("email", "A");
		}
		if(findByUsername(o.getUsername()) != null) {
			return new ErrorResponse("username", "C"); 
		}
		if(findByEmail(o.getEmail()) != null) {
			return new ErrorResponse("email", "B"); 
		}
		return null;
	}

	public RegisterResponse register(User o) {

		ErrorResponse error = validateRegister(o);
		if (error != null) {
			return new RegisterResponse(null, error);
		}
		String sql = "insert into user values (null, ?, ?, ?, ?, ?)";

		try {
			String hashedPassword = Hash.md5(o.getPassword());
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, o.getUsername());
			ps.setString(2, o.getEmail());
			ps.setString(3, hashedPassword);
			ps.setString(4, o.getRole());
			ps.setBoolean(5,false );
			if (ps.executeUpdate() == 1) {
				MailSender.send("http://localhost:8081/LearningJavaWeb/RegisterController?uid="+o.getUsername()+"&key="+Hash.md5(o.getUsername()), o.getEmail());
				return new RegisterResponse(findByUsername(o.getUsername()), null);
				
			}
		} catch (SQLException e) {
			System.out.println("register : erreur sql : " + e.getMessage());

		}
		return new RegisterResponse(null, null);
	}

	public User login(String login, String pw) {
		

		String sql = "select * from user where (email = ? AND password = ?) OR(username = ? AND password = ?) ";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, login);
			ps.setString(2, pw);
			ps.setString(3, login);
			ps.setString(4, Hash.md5(pw));
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				
				return new User(rs.getInt("id"), rs.getString("username"), rs.getString("email"), rs.getString("role"),
						rs.getString("password"));
			}

		} catch (SQLException e) {
			System.out.println("findById " + e.getMessage());
		}
		return null;

	}
	public boolean deleteUser(User o) {
		String sql = "delete from user where id = ?";
		try {

			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, o.getId());
			if (ps.executeUpdate() == 1) {
				
				return true;
				
			}
		} catch (SQLException e) {
			System.out.println("removeUser : erreur sql : " + e.getMessage());

		}
		return false;
	}
	
	public boolean updateUser(User o) {
		String sql = "update user set username = ?, email = ?, password = ?,role = ? where id = ?";
		try {

			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, o.getUsername());
			ps.setString(2, o.getEmail());
			ps.setString(3, o.getPassword());
			ps.setString(4, o.getRole());
			ps.setInt(5, o.getId());
			if (ps.executeUpdate() == 1) {
				
				return true;
				
			}
		} catch (SQLException e) {
			System.out.println("updateUser : erreur sql : " + e.getMessage());

		}
		return false;
	}

	public User findById(int id) {

		String sql = "select * from user where id  = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return new User(rs.getInt("id"), rs.getString("username"), rs.getString("email"), rs.getString("password"),
						rs.getString("role"));
			}

		} catch (SQLException e) {
			System.out.println("findById " + e.getMessage());
		}
		return null;
	}
	
	public User findByUsername(String username) {

		String sql = "select * from user where username  = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return new User(rs.getInt("id"), rs.getString("username"), rs.getString("email"), rs.getString("password"),
						rs.getString("role"));
			}

		} catch (SQLException e) {
			System.out.println("findByUsername " + e.getMessage());
		}
		return null;
	}
	public User findByEmail(String email) {

		String sql = "select * from user where email  = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return new User(rs.getInt("id"), rs.getString("username"), rs.getString("email"), rs.getString("role"),
						rs.getString("password"));
			}

		} catch (SQLException e) {
			System.out.println("findByEmail " + e.getMessage());
		}
		return null;
	}

	public List<User> findAll() {
		List<User> users = new ArrayList<User>();

		String sql = "select * from user";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				users.add(new User(rs.getInt("id"), rs.getString("username"), rs.getString("email"),
						rs.getString("password"), rs.getString("role")));
			}

		} catch (SQLException e) {
			System.out.println("findAll " + e.getMessage());
		}
	
		return users;
	}
	
	
	
	public boolean hasBooking(User user) {
		
		String sql = "select * from booking where clientId = ? AND (startDate > ? OR endDate > ? )";
		try {
		
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, user.getId());
			ps.setDate(2, new Date(new java.util.Date().getTime()));
			ps.setDate(3, new Date(new java.util.Date().getTime()));
			ResultSet rs = ps.executeQuery();
		
			if(rs.next()) {
				return true;
			}
		}catch (SQLException e) {
			System.out.println("hasBooking: " + e.getMessage());
		}
		return false;	
	}
	
	public boolean isVerified(User user) {
		String sql = "select verified from user where id = ? ";
		try {
			
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, user.getId());
			
			ResultSet rs = ps.executeQuery();
		
			if(rs.next()) {
				return rs.getBoolean("verified");
			}
		}catch (SQLException e) {
			System.out.println("hasBooking: " + e.getMessage());
		}
		return false;
	}
	
	public boolean verify(User user) {
		String sql = "update user set verified = ? where id = ?";
		try {

			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(2, user.getId());
			ps.setBoolean(1, true);
			
			if (ps.executeUpdate() == 1) {
				
				return true;
				
			}
		} catch (SQLException e) {
			System.out.println("verifyUser : erreur sql : " + e.getMessage());

		}
		return false;
	}
	
	
	

}
