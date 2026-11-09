package com.tap.admin;


import org.mindrot.jbcrypt.BCrypt;

public class GenerateAdminPassword {

    public static void main(String[] args) {

        String password = "9843292996@Bro";

        String hashedPassword =
                BCrypt.hashpw(password, BCrypt.gensalt(12));

        System.out.println(hashedPassword);
    }
}
