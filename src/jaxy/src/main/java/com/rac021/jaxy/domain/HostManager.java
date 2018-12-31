
package com.rac021.jaxy.domain ;

import javax.ejb.Startup ;
import javax.ejb.Singleton ;
import java.net.InetAddress ;
import java.util.logging.Level ;
import java.util.logging.Logger ;
import java.net.UnknownHostException ;
import javax.annotation.PostConstruct ;
import javax.enterprise.context.ApplicationScoped ;
import static com.rac021.jaxy.api.logger.LoggerFactory.getLogger ;

/**
 *
 * @author ryahiaoui
 */

@Singleton
@Startup
@ApplicationScoped

public class HostManager {

    public static        String HOST_NAME = null     ;

    private static final Logger LOGGER = getLogger() ;

    @PostConstruct
    public void init()            {
        HOST_NAME = getHostName() ;
    }

    public static String getHostName()               {

       if ( HOST_NAME != null ) return HOST_NAME     ;
        
       try {

           HOST_NAME      = InetAddress.getLocalHost().getCanonicalHostName() ;
           InetAddress ip = InetAddress.getByName(HOST_NAME)                  ; 
           
       } catch( UnknownHostException ex )                   {
            LOGGER.log(Level.WARNING, ex.getMessage(), ex ) ;
            HOST_NAME = "localhost"                         ;
       }
       
       return HOST_NAME ;
       
    }

}
