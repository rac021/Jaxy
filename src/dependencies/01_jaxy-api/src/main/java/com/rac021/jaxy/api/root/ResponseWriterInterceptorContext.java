
package com.rac021.jaxy.api.root ;

/**
 *
 * @author ryahiaoui
 */
import java.time.Instant ;
import java.time.Duration ;
import java.io.IOException ;
import javax.ws.rs.ext.Provider ;
import java.util.concurrent.TimeUnit ;
import javax.ws.rs.ext.WriterInterceptor ;
import javax.ws.rs.WebApplicationException ;
import com.rac021.jaxy.api.metrics.Metrics ;
import javax.ws.rs.ext.WriterInterceptorContext ;
import static com.rac021.jaxy.api.root.ConcurrentUsersManager.tryingReleaseSemaphore ;

@Provider
public class ResponseWriterInterceptorContext implements WriterInterceptor {
    
    @Override
    public void aroundWriteTo( WriterInterceptorContext context ) throws WebApplicationException, IOException {

        try {
            context.proceed();

        } finally {

            if ( RuntimeServiceInfos.STARTED_TIME.get() != null ) {

                Instant finish = Instant.now();
                long timeElapsed = Duration.between( RuntimeServiceInfos.STARTED_TIME.get(), finish ).toMillis() ;

                String timer = RuntimeServiceInfos.SERVICE_NAME.get() +  "_"           +
                               RuntimeServiceInfos.ACCEPT.get().replaceAll("/", "_")   +
                               "_timer" ;
                
                Metrics.updateTimerService( timer, timeElapsed, TimeUnit.MILLISECONDS) ;

                RuntimeServiceInfos.STARTED_TIME.remove();
                RuntimeServiceInfos.SERVICE_NAME.remove();

            }

            /**
             * RELEASE SEMAPHORE . *
             */
            if (RuntimeServiceInfos.SEMAPHORE_CURRENT_THREAD_NAME.get() != null) {
                tryingReleaseSemaphore() ;
                RuntimeServiceInfos.SEMAPHORE_CURRENT_THREAD_NAME.remove() ;

            }
        }
    }
}
