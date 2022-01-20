package utils;

import java.util.Date;

public class RoomSearchOptions {
	public Date start;
	public Date finish;
	public int price;
	public String type;

	public RoomSearchOptions(Date start, Date finish, int price, String type) {
		super();
		this.type = type;
		this.start = start;
		this.finish = finish;
		this.price = price;
	}

	@Override
	public String toString() {
		return "RoomSearchOptions [start=" + start + ", finish=" + finish + ", price=" + price + "]";
	}

}
