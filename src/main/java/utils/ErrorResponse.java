package utils;

public class ErrorResponse {
	public String field;
	public String message;
	public ErrorResponse(String field, String message) {
		super();
		this.field = field;
		this.message = message;
	}
	@Override
	public String toString() {
		return "ErrorResponse [field=" + field + ", message=" + message + "]";
	}
	
	
	
}
