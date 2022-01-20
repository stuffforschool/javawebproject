package utils;


import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.activation.DataHandler;

//Source : www.exelib.net
public class MailSender {
	static final String username = "skyrak1998@gmail.com";
    static final String password = "dofusgamer98";

    public static void send(String s,String email) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        //props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.transport.protocol", "smtp");
        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });
       
        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipient(Message.RecipientType.TO,new InternetAddress(email));
            message.setSubject("Confirm email");
            message.setText(s);
            System.out.println("email here");
            Transport.send(message);

            System.out.println("Email sent successfuly");

        } catch (MessagingException e) {
        	System.out.println("Sending email failed");
        	e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
//Source : www.exelib.net
}
