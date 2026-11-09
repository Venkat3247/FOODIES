package com.tap.otp.util;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    public static void sendOTP(String recipientEmail, String otp)
            throws Exception {

        String senderEmail = System.getenv("FOODIES_GMAIL");
        String appPassword = System.getenv("FOODIES_GMAIL_APP_PASSWORD");

        if (senderEmail == null || appPassword == null) {
            throw new IllegalStateException(
                "Gmail environment variables are not configured."
            );
        }

        Properties properties = new Properties();

        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties,
            new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                        senderEmail,
                        appPassword.replace(" ", "")
                    );
                }
            }
        );

        Message message = new MimeMessage(session);

        message.setFrom(new InternetAddress(senderEmail));

        message.setRecipients(
            Message.RecipientType.TO,
            InternetAddress.parse(recipientEmail)
        );

        message.setSubject("Foodies - Password Reset OTP");

        message.setText(
            "Hello,\n\n" +
            "Your Foodies password reset OTP is: " + otp + "\n\n" +
            "This OTP is valid for 5 minutes.\n" +
            "Do not share this OTP with anyone.\n\n" +
            "Regards,\nFoodies Team"
        );

        Transport.send(message);
    }
}