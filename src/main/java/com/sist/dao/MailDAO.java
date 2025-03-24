package com.sist.dao;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import java.util.Random;


public class MailDAO {
    final static String fromEmail = "festeller22@gmail.com"; // 발송할 이메일 주소 / 비밀번호 : festeller11!
    final static String password = "wopuchigyyjujnsl";        // 이메일 계정 비밀번호 또는 앱 비밀번호
    public static Session mailConfig(){
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        props.put("mail.smtp.connectiontimeout", "10000"); // 연결 Timeout (10초)
        props.put("mail.smtp.timeout", "10000"); // 읽기 Timeout (10초)

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        return session;
    }
    private static String createCode() {
        int leftLimit = 48; // number '0'
        int rightLimit = 122; // alphabet 'z'
        int targetStringLength = 6;
        Random random = new Random();

        return random.ints(leftLimit, rightLimit + 1)
                .filter(i -> (i <= 57 || i >= 65) && (i <= 90 | i >= 97))
                .limit(targetStringLength)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();
    }
    public static String sendMail(String toEmail) {
        String code=createCode();
        Session session=mailConfig();
        try {
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail, "인증시스템"));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            msg.setSubject("Festeller 인증 코드입니다.", "UTF-8");
            msg.setText("인증 코드: <b style='font-size:20px'>"+code+"</b><p>해당 인증 코드를 입력해주세요.</p>", "UTF-8","html");
            Transport.send(msg);
            System.out.println("이메일 발송 성공!");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("발송 실패: " + e.getMessage());
        }
        return code;
    }

}
