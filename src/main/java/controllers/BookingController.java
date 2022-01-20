package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.BookingService;
import services.RoomService;
import services.UserService;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import entities.Booking;
import entities.Room;
import java.time.temporal.ChronoUnit;

/**
 * Servlet implementation class BookingController
 */
public class BookingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RoomService rs = new RoomService();
	private UserService us = new UserService();
	private BookingService bs = new BookingService();
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BookingController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getParameter("op") !=null) {
			if (request.getParameter("op").equals("delete")) {
				int id = Integer.parseInt(request.getParameter("id"));
				if (bs.removeBooking(bs.findById(id))) {
					response.sendRedirect("/LearningJavaWeb/GestionBookings.jsp");
				}
			}else if(request.getParameter("op").equals("filter")) {
				if(request.getParameter("criteria").equals("all")) {
					response.sendRedirect("/LearningJavaWeb/GestionBookings.jsp?criteria=all");
				}else if(request.getParameter("criteria").equals("current")) {
					response.sendRedirect("/LearningJavaWeb/GestionBookings.jsp?criteria=current");
				}else if(request.getParameter("criteria").equals("upcoming")) {
					response.sendRedirect("/LearningJavaWeb/GestionBookings.jsp?criteria=upcoming");
				}else if(request.getParameter("criteria").equals("past")) {
					response.sendRedirect("/LearningJavaWeb/GestionBookings.jsp?criteria=past");
				}
				
			}
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getParameter("op") != null) {
			if (request.getParameter("op").equals("check")) {
				String start = request.getParameter("startDate");
				String end = request.getParameter("endDate");
				
				List<Room> rooms = rs.findAvailableRooms(new Date(start),new Date(end));
				request.setAttribute("rooms",rooms);
				request.setAttribute("start",start);
				request.setAttribute("end",end);
				request.getRequestDispatcher("GestionBookings.jsp").forward(request, response);

				
			} else if (request.getParameter("op").equals("delete")) {
				int id = Integer.parseInt(request.getParameter("id"));
				if (bs.removeBooking(bs.findById(id))) {
					response.sendRedirect("/LearningJavaWeb/GestionBookings.jsp");
				}
			} else if (request.getParameter("op").equals("update")) {
				// System.out.println("here to update");
				
				int id = Integer.parseInt(request.getParameter("id"));

				
				Date startDate = new Date(request.getParameter("startDate").replace("-", "/"));
				Date endDate = new Date(request.getParameter("endDate").replace("-", "/"));
				int clientId = Integer.parseInt(request.getParameter("client"));
				int roomId = Integer.parseInt(request.getParameter("room"));
				int price = Integer.parseInt(request.getParameter("price"));
				//System.out.println("num:" + numero + " type: " + type + " price: " + price);
				
				//System.out.println("room to update" + room);
				if (bs.updateBooking(new Booking(id, rs.findById(roomId), us.findById(clientId), startDate, endDate,price))) {
					response.sendRedirect("/LearningJavaWeb/GestionBookings.jsp");
				}
			}else if(request.getParameter("op").equals("add")) {
			
				Date startDate = new Date(request.getParameter("startDate"));
				Date endDate = new Date(request.getParameter("endDate"));
				int clientId = Integer.parseInt(request.getParameter("client"));
				int roomId = Integer.parseInt(request.getParameter("room"));
				long diffInMillies =  Math.abs(endDate.getTime() - startDate.getTime());
				int diff = (int) TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
				//System.out.println("diff:"+ diff);
			
				Room room = rs.findById(roomId);
				int price = room.getPrice()*diff;
				
				if (bs.createBooking(new Booking(room, us.findById(clientId), startDate,endDate,price))) {
					if(request.getParameter("from") != null && request.getParameter("from").equals("client") ) {
						response.sendRedirect("/LearningJavaWeb/index.jsp");
					}else {
						response.sendRedirect("/LearningJavaWeb/GestionBookings.jsp");
					}
					
				}
			}
		}
	}

}
