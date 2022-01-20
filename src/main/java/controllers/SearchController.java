package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.RoomService;
import utils.RoomSearchOptions;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import entities.Room;

/**
 * Servlet implementation class SearchController
 */
public class SearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static RoomService rs = new RoomService();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String start = request.getParameter("startDate");
		String end = request.getParameter("endDate");
		
		int prix = Integer.parseInt(request.getParameter("price")) ;
		String type = request.getParameter("type");
		RoomSearchOptions options = new RoomSearchOptions(new Date(start), new Date(end), prix,type);
		List<Room> rooms = rs.search(options);
		request.setAttribute("results",rooms);
		request.getRequestDispatcher("result.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
