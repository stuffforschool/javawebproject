package utils;

import entities.User;

public class RegisterResponse {
	private User user;
	private ErrorResponse error;
	public RegisterResponse(User user, ErrorResponse error) {
		super();
		this.user = user;
		this.error = error;
	}
	public User getUser() {
		return user;
	}
	public ErrorResponse getError() {
		return error;
	}
	@Override
	public String toString() {
		return "RegisterResponse [user=" + user + ", error=" + error + "]";
	}
	
	
}
