package test;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import connection.Connexion;
import utils.Hash;
import utils.MailSender;

public class Test {
	public static void main(String[] args) {
		try {

			String TUser2 = "create table user ("
					+ "id int primary key auto_increment,"
					+ "username varchar(20) NOT NULL UNIQUE," + "email varchar(20) NOT NULL UNIQUE,"
					+ "password varchar(20) NOT NULL ," + "role varchar(20) NOT NULL ); ";
			String TRoom = "create table room (" + "id int primary key auto_increment,"
					+ "num varchar(20) NOT NULL UNIQUE," + "type varchar(20) NOT NULL ,"
					+ "price int NOT NULL );" ;
			String TBooking = "create table booking (" + "id int primary key auto_increment,"
					+ "roomId int NOT NULL," + "clientId int NOT NULL ,"+"startDate date NOT NULL ,"+"endDate date NOT NULL ,"
					+ "price int NOT NULL );" ;
			String fk = "alter table booking add "
					+ "constraint fk foreign key (roomId) "
					+ "references room(id)"
					+ "ON DELETE CASCADE;";
			String fk2 = "alter table booking add "
					+ "constraint fk2 foreign key (clientId) "
					+ "references user(id)"
					+ "ON DELETE CASCADE;";
			/*
			 * PreparedStatement ps =
			 * Connexion.getInstane().getConnection().prepareStatement(TUser2);
			 * ps.executeQuery();
			 */
			Statement st = Connexion.getInstane().getConnection().createStatement();

			//st.execute("drop table if exists user");
			//st.executeUpdate(TUser2);
			//st.executeUpdate(TRoom);
			//st.executeUpdate(TBooking);
			//st.executeUpdate(fk);
			//st.executeUpdate(fk2);
			MailSender.send("message", "i.sigma98@gmail.com");
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
