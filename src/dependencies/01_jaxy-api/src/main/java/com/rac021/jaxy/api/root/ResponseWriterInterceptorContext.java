
package com.rac021.jaxy.api.root;

/**
 *
 * @author ryahiaoui
 */

import java.io.IOException ;
import javax.ws.rs.ext.Provider ;
import javax.ws.rs.ext.WriterInterceptor ;
import javax.ws.rs.WebApplicationException ;
import javax.ws.rs.ext.WriterInterceptorContext ;
import static com.rac021.jaxy.api.root.ConcurrentUsersManager.tryingReleaseSemaphore ;

@Provider
public class ResponseWriterInterceptorContext implements WriterInterceptor {

    public static final ThreadLocal<String> SEMAPHORE_THREAD_LOCAL = new ThreadLocal<>() ;
    
    @Override
    public void aroundWriteTo(WriterInterceptorContext context) throws WebApplicationException, IOException {
        
        try {
            context.proceed()  ;
            
        } finally {
            
            /** RELEASE SEMAPHORE . **/
            if(  SEMAPHORE_THREAD_LOCAL.get() != null ) {
                 tryingReleaseSemaphore()               ;
                 SEMAPHORE_THREAD_LOCAL.remove()        ;
               
            }
        }
    }
}
