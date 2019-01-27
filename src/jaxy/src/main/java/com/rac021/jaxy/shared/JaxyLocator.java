
package com.rac021.jaxy.shared ;

import java.io.File ;

/**
 *
 * @author ryahiaoui
 */
 
public class JaxyLocator {
    
    
    public static String getJaxyJarLocation() {
        
        String jarFileLocation = System.getProperty("java.class.path")
                                       .split(":" + System.getProperty("java.io.tmpdir"))[0] ;
        
        return new File(jarFileLocation).getParentFile().getAbsolutePath()                   ;
    }
       
}
