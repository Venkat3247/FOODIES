package com.tap.otp;

import com.tap.otp.util.EmailUtil;
import java.security.SecureRandom;

public class EmailTest {

    public static void main(String[] args) {

        try {
            String otp = String.format(
                "%06d",
                new SecureRandom().nextInt(1000000)
            );

            EmailUtil.sendOTP("yourtestemail@gmail.com", otp);

            System.out.println("OTP email sent successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}