package services;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.Connexion;
import entities.Room;
import entities.User;
import utils.RegisterResponse;
import utils.RoomSearchOptions;

public class RoomService {

	public boolean addRoom(Room o) {
		String sql = "insert into room values (null, ?, ?, ?)";
		try {

			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, o.getNum());
			ps.setString(2, o.getType());
			ps.setInt(3, o.getPrice());

			if (ps.executeUpdate() == 1) {

				return true;

			}
		} catch (SQLException e) {
			System.out.println("addRoom : erreur sql : " + e.getMessage());

		}
		return false;
	}

	public boolean removeRoom(Room o) {
		String sql = "delete from room where id = ?";
		try {

			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, o.getId());
			if (ps.executeUpdate() == 1) {

				return true;

			}
		} catch (SQLException e) {
			System.out.println("removeRoom : erreur sql : " + e.getMessage());

		}
		return false;
	}

	public boolean updateRoom(Room o) {
		String sql = "update room set num = ?, type = ?, price = ? where id = ?";
		try {

			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setString(1, o.getNum());
			ps.setString(2, o.getType());
			ps.setInt(3, o.getPrice());
			ps.setInt(4, o.getId());
			if (ps.executeUpdate() == 1) {

				return true;

			}
		} catch (SQLException e) {
			System.out.println("updateRoom : erreur sql : " + e.getMessage());

		}
		return false;
	}

	public Room findById(int id) {

		String sql = "select * from room where id  = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return new Room(rs.getInt("id"), rs.getString("num"), rs.getString("type"), rs.getInt("price"));
			}

		} catch (SQLException e) {
			System.out.println(" Room findById " + e.getMessage());
		}
		return null;
	}

	public List<Room> findAll() {
		List<Room> rooms = new ArrayList<Room>();

		String sql = "select * from room";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				rooms.add(new Room(rs.getInt("id"), rs.getString("num"), rs.getString("type"), rs.getInt("price")));
			}

		} catch (SQLException e) {
			System.out.println(" Room findAll " + e.getMessage());
		}
		return rooms;
	}

	public List<Room> findAvailableRooms(java.util.Date startDate, java.util.Date endDate) {

		List<Room> rooms = new ArrayList<Room>();
		if (startDate.after(endDate)) {
			return rooms;
		}
		String sql = "SELECT * FROM room " + "LEFT JOIN booking ON room.id = booking.roomId "
				+ "WHERE room.id NOT IN ( SELECT roomId FROM booking where booking.endDate > ?  OR booking.startDate = ? ) ";

		try {

			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setDate(1, new Date(startDate.getTime()));
			ps.setDate(2, new Date(startDate.getTime()));

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				rooms.add(new Room(rs.getInt("id"), rs.getString("num"), rs.getString("type"), rs.getInt("price")));
			}

		} catch (SQLException e) {
			System.out.println(" Room search " + e.getMessage());
		}
		return rooms;
	}

	public List<Room> search(RoomSearchOptions options) {
		List<Room> rooms = new ArrayList<Room>();
		String sql = "SELECT * FROM room " 
				+ "LEFT JOIN booking ON room.id = booking.roomId "
				+ "WHERE room.id NOT IN ( SELECT roomId FROM booking where booking.endDate > ?  OR booking.startDate = ? ) "
				+ "AND room.price < ? ";
				
		if(! options.type.equals("all")) {
			sql +=  "AND room.type = ?";
		}
		try {

			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setDate(1, new Date(options.start.getTime()));
			ps.setDate(2, new Date(options.start.getTime()));
			ps.setInt(3, options.price);
			if(! options.type.equals("all")) {
				ps.setString(4, options.type);
			}
			
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				rooms.add(new Room(rs.getInt("id"), rs.getString("num"), rs.getString("type"), rs.getInt("price")));
			}

		} catch (SQLException e) {
			System.out.println(" Room search " + e.getMessage());
		}
		return rooms;
	}

	public boolean hasBooking(Room room) {

		String sql = "select * from booking where roomId = ? AND (startDate > ? OR endDate > ? )";
		try {

			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, room.getId());
			ps.setDate(2, new Date(new java.util.Date().getTime()));
			ps.setDate(3, new Date(new java.util.Date().getTime()));
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			System.out.println(" rooom hasBooking: " + e.getMessage());
		}
		return false;
	}
}
