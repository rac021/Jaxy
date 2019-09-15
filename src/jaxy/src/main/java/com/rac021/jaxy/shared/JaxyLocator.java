
package com.rac021.jaxy.shared ;

import java.io.File ;

/**
 *
 * @author ryahiaoui
 */
 
public class JaxyLocator {
    
    
    public static String getJaxyJarLocation() {
        
       return System.getProperty("user.dir")  ;  
    }
       
}
