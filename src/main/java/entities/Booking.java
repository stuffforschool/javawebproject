package entities;

import java.util.Date;

public class Booking {
	private int id;
	private Room room;
	private User client;
	private Date startDate;
	private Date endDate;
	private int price;
	public Booking(int id, Room room, User client, Date startDate, Date endDate, int price) {
		super();
		this.id = id;
		this.room = room;
		this.client = client;
		this.startDate = startDate;
		this.endDate = endDate;
		this.price = price;
	}
	public Booking(Room room, User client, Date startDate, Date endDate, int price) {
		super();
		this.room = room;
		this.client = client;
		this.startDate = startDate;
		this.endDate = endDate;
		this.price = price;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Room getRoom() {
		return room;
	}
	public void setRoom(Room room) {
		this.room = room;
	}
	public User getClient() {
		return client;
	}
	public void setClient(User client) {
		this.client = client;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "Booking [id=" + id + ", room=" + room + ", client=" + client + ", startDate=" + startDate + ", endDate="
				+ endDate + ", price=" + price + "]";
	}
	
	
}
