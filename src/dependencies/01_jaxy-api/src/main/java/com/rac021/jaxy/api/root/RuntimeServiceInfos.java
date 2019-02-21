
package com.rac021.jaxy.api.root ;

import java.util.Map ;
import java.time.Instant ;
import java.util.LinkedHashMap ;


/**
 *
 * @author ryahiaoui
 */

public interface RuntimeServiceInfos {
    
    public static final ThreadLocal<String>  SEMAPHORE_CURRENT_THREAD_NAME = new ThreadLocal<>() ;

    public static final ThreadLocal<Instant> STARTED_TIME                  = new ThreadLocal<>() ;

    public static final ThreadLocal<String>  SERVICE_NAME                  = new ThreadLocal<>() ;
    
    public static final ThreadLocal<String>  ACCEPT                        = new ThreadLocal<>() ;
    
}
