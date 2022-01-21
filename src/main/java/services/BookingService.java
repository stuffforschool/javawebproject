package services;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.Connexion;
import entities.Booking;
import entities.Room;
import utils.Hash;
import utils.MailSender;

public class BookingService {
	
	private UserService userS;
	private RoomService roomS;
	
	
	public BookingService() {
		this.userS = new UserService();
		this.roomS = new RoomService();
	}
	
	public boolean createBooking(Booking o) {
		if(o.getStartDate().after(o.getEndDate())) {
			return false;
		}
		
		String sql = "insert into booking values (null, ?, ?, ?,?,?)";
		try {

			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, o.getRoom().getId());
			ps.setInt(2, o.getClient().getId());
			ps.setDate(3, new Date(o.getStartDate().getTime()));
			ps.setDate(4, new Date(o.getEndDate().getTime()));
			ps.setInt(5, o.getPrice());
			if (ps.executeUpdate() == 1) {
				
				return true;
				
			}
		} catch (SQLException e) {
			System.out.println("createBooking : erreur sql : " + e.getMessage());

		}
		return false;
	}
	
	public boolean removeBooking(Booking o) {
		if(o.getStartDate().after(new java.util.Date())) {
			UserService us = new UserService();
			MailSender.send("Nous vous informons que votre réservation pour la chambre: " + o.getRoom().getNum()+" prévu pour la date: "+o.getStartDate() +" Jusqu'a: "+o.getEndDate() + " a été annulé par l'administration . ",us.findById(o.getClient().getId()).getEmail());
		}
		String sql = "delete from booking where id = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, o.getId());
			if (ps.executeUpdate() == 1) {
				
				return true;
				
			}
		} catch (SQLException e) {
			System.out.println("removeBooking : erreur sql : " + e.getMessage());

		}
		return false;
	}
	
	public boolean updateBooking(Booking o) {
		String sql = "update booking set roomId = ?, clientId = ?, startDate = ?, endDate = ?, price = ? where id = ?";
		try {

			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, o.getRoom().getId());
			ps.setInt(2, o.getClient().getId());
			
			ps.setDate(3, new Date(o.getStartDate().getTime()));
			ps.setDate(4, new Date(o.getEndDate().getTime()));
			ps.setInt(5, o.getPrice());
			ps.setInt(6, o.getId());
			if (ps.executeUpdate() == 1) {
				
				return true;
				
			}
		} catch (SQLException e) {
			System.out.println("updateBooking : erreur sql : " + e.getMessage());

		}
		return false;
	}
	
	public Booking findById(int id) {

		String sql = "select * from booking where id  = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return new Booking(rs.getInt("id"), roomS.findById(rs.getInt("roomId")),userS.findById(rs.getInt("clientId")), rs.getDate("startDate"),rs.getDate("endDate") ,rs.getInt("price"));
			}

		} catch (SQLException e) {
			System.out.println(" Booking findById " + e.getMessage());
		}
		return null;
	}
	
	public Booking findByRoomId(int id) {

		String sql = "select * from booking where roomId  = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return new Booking(rs.getInt("id"), roomS.findById(rs.getInt("roomId")),userS.findById(rs.getInt("clientId")), rs.getDate("startDate"),rs.getDate("endDate") ,rs.getInt("price"));
			}

		} catch (SQLException e) {
			System.out.println(" Booking findById " + e.getMessage());
		}
		return null;
	}
	
	public Booking findByClientId(int id) {

		String sql = "select * from booking where clientId  = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return new Booking(rs.getInt("id"), roomS.findById(rs.getInt("roomId")),userS.findById(rs.getInt("clientId")), rs.getDate("startDate"),rs.getDate("endDate") ,rs.getInt("price"));
			}

		} catch (SQLException e) {
			System.out.println(" Booking findById " + e.getMessage());
		}
		return null;
	}
	
	public List<Booking> findAll() {
		List<Booking> bookings = new ArrayList<Booking>();

		String sql = "select * from booking";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				bookings.add(new Booking(rs.getInt("id"), roomS.findById(rs.getInt("roomId")),userS.findById(rs.getInt("clientId")), rs.getDate("startDate"),rs.getDate("endDate") ,rs.getInt("price")));
			}

		} catch (SQLException e) {
			System.out.println(" Booking findAll " + e.getMessage());
		}
		
		return bookings;
	}
	
	public List<Booking> findCurrent() {
		List<Booking> bookings = new ArrayList<Booking>();

		String sql = "select * from booking where startDate < ? AND endDate > ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setDate(1, new Date(new java.util.Date().getTime()));
			ps.setDate(2, new Date(new java.util.Date().getTime()));
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				bookings.add(new Booking(rs.getInt("id"), roomS.findById(rs.getInt("roomId")),userS.findById(rs.getInt("clientId")), rs.getDate("startDate"),rs.getDate("endDate") ,rs.getInt("price")));
			}

		} catch (SQLException e) {
			System.out.println(" Booking findCurrent " + e.getMessage());
		}
		
		return bookings;
	}
	
	public List<Booking> findUpcoming() {
		List<Booking> bookings = new ArrayList<Booking>();

		String sql = "select * from booking where startDate > ? ";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setDate(1, new Date(new java.util.Date().getTime()));
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				bookings.add(new Booking(rs.getInt("id"), roomS.findById(rs.getInt("roomId")),userS.findById(rs.getInt("clientId")), rs.getDate("startDate"),rs.getDate("endDate") ,rs.getInt("price")));
			}

		} catch (SQLException e) {
			System.out.println(" Booking findUpcoming " + e.getMessage());
		}
		
		return bookings;
	}
	
	public List<Booking> findPast() {
		List<Booking> bookings = new ArrayList<Booking>();

		String sql = "select * from booking where  endDate < ? ";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setDate(1, new Date(new java.util.Date().getTime()));
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				bookings.add(new Booking(rs.getInt("id"), roomS.findById(rs.getInt("roomId")),userS.findById(rs.getInt("clientId")), rs.getDate("startDate"),rs.getDate("endDate") ,rs.getInt("price")));
			}

		} catch (SQLException e) {
			System.out.println(" Booking findPast " + e.getMessage());
		}
		
		return bookings;
	}
	
	public List<Booking> findAllByclientId(int clientId) {
		List<Booking> bookings = new ArrayList<Booking>();

		String sql = "select * from booking where clientId = ?";
		try {
			PreparedStatement ps = Connexion.getInstane().getConnection().prepareStatement(sql);
			ps.setInt(1, clientId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				bookings.add(new Booking(rs.getInt("id"), roomS.findById(rs.getInt("roomId")),userS.findById(rs.getInt("clientId")), rs.getDate("startDate"),rs.getDate("endDate") ,rs.getInt("price")));
			}

		} catch (SQLException e) {
			System.out.println(" Booking findAll " + e.getMessage());
		}
		
		return bookings;
	}
	
	public int[] stats() {
		int[] stats = new int[12];
		List<Booking> bookings = findAll();
		for(Booking b : bookings) {
			stats[b.getStartDate().getMonth()]++;
		}
		return stats;
	}
}
