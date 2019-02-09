
package com.rac021.jaxy.api.metrics ;

import java.util.logging.Level ;
import java.util.logging.Logger ;
import javax.annotation.PostConstruct ;
import javax.enterprise.event.Observes ;
import javax.enterprise.context.Initialized ;
import java.util.concurrent.atomic.LongAdder ;
import javax.enterprise.context.ApplicationScoped ;
import org.eclipse.microprofile.metrics.annotation.Gauge ;
import static com.rac021.jaxy.api.logger.LoggerFactory.getLogger ;

/**
 *
 * @author ryahiaoui
 */

@ApplicationScoped
public class Metrics {
   
    private static final Logger LOGGER = getLogger() ;
    
    private static final LongAdder totalExceptions       = new LongAdder() ;
    private static final LongAdder failureAuthentication = new LongAdder() ;            
    
    @Gauge(unit = "count", absolute = true , name = "exceptions")
    public long getTotalExceptions()       {
        return totalExceptions.longValue() ;
    }
    
    @Gauge(unit = "count", absolute = true , name = "failureAuthentication")
    public long getFailureAuthentication()       {
        return failureAuthentication.longValue() ;
    }
    
    
    public static void incTotalExceptions() {
       totalExceptions.increment()          ;
    }
    public static void incTfailureAuthentication() {
        failureAuthentication.increment()          ;
    }
    
    @PostConstruct
    public void init( @Observes 
                      @Initialized(ApplicationScoped.class ) Object init ) {
        LOGGER.log(Level.INFO, " ++ Metrics Initialization.. " ) ;
    }
    
}

     
     
