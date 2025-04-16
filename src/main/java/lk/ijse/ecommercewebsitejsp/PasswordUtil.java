package lk.ijse.ecommercewebsitejsp;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Generate a hashed password
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    // Verify a password against its hash
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
