package utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Hash {
	public static String md5(String s) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			BigInteger bi = new BigInteger(1, md.digest(s.getBytes()));
			return bi.toString(16);
		} catch (NoSuchAlgorithmException ex) {
			ex.printStackTrace();
			return null;
		}
	}
//Source : www.exelib.net
}
