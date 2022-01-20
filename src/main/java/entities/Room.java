package entities;

public class Room {
	
	private int id;
	private String num;
	private String type;
	private int price;
	public Room(int id, String num, String type, int price) {
		super();
		this.id = id;
		this.num = num;
		this.type = type;
		this.price = price;
	}
	public Room(String num, String type, int price) {
		super();
		this.num = num;
		this.type = type;
		this.price = price;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "Room [id=" + id + ", num=" + num + ", type=" + type + ", price=" + price + "]";
	}
	
	
}
