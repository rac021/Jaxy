
package com.rac021.jaxy.client.security ;

import java.math.BigInteger ;
import java.security.MessageDigest ;
import java.nio.charset.StandardCharsets ;
import java.security.NoSuchAlgorithmException ;

/**
 *
 * @author yahiaoui
 */

public class Digestor {
    
    public static byte[] toMD5(final String password) throws NoSuchAlgorithmException{
        MessageDigest md = MessageDigest.getInstance("MD5")         ;
        return md.digest(password.getBytes(StandardCharsets.UTF_8)) ;
    }
    
    public static byte[] toSHA1(String message) throws NoSuchAlgorithmException {
        MessageDigest md   = MessageDigest.getInstance("SHA-1")     ;
        return  md.digest(message.getBytes(StandardCharsets.UTF_8)) ;
    }

    public static byte[] toSHA256(String password) throws NoSuchAlgorithmException {
        MessageDigest sha256 = MessageDigest.getInstance("SHA-256")  ;        
        byte[] passBytes = password.getBytes(StandardCharsets.UTF_8) ;
        return sha256.digest(passBytes)                              ;
    }
    
    public static String toString( byte[] array )    {
       BigInteger    bI   = new BigInteger(1, array) ;
       return bI.toString(16)                        ;
    }

    /*
    public static String generateSignature( String login     , 
                                            String password  ,
                                            String timeStamp ) 
                                            throws NoSuchAlgorithmException {
        return toString(toSHA256 (login + password + timeStamp )) ;
    }
    */
    
    private Digestor() { }

}
