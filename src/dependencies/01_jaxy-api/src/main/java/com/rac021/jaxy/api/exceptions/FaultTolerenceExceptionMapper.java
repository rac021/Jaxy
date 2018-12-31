
package com.rac021.jaxy.api.exceptions ;

import java.util.logging.Level ;
import java.util.logging.Logger ;
import javax.ws.rs.ext.Provider ;
import javax.ws.rs.core.Response ;
import javax.ws.rs.core.MediaType ;
import javax.ws.rs.ext.ExceptionMapper ;
import static com.rac021.jaxy.api.logger.LoggerFactory.getLogger ;
import org.eclipse.microprofile.faulttolerance.exceptions.TimeoutException ;
import org.eclipse.microprofile.faulttolerance.exceptions.BulkheadException ;
import org.eclipse.microprofile.faulttolerance.exceptions.FaultToleranceException ;
import org.eclipse.microprofile.faulttolerance.exceptions.CircuitBreakerOpenException ;
import org.eclipse.microprofile.faulttolerance.exceptions.FaultToleranceDefinitionException ;

/**
 *
 * @author ryahiaoui
 */

@Provider
public class FaultTolerenceExceptionMapper implements ExceptionMapper<FaultToleranceException> {

    static final Logger LOGGER = getLogger() ; 
  
    @Override
    public Response toResponse(FaultToleranceException exception)        {
        
        System.out.println(" ***** FaultTolerenceExceptionMapper *****") ;
        
        LOGGER.log(Level.WARNING, exception.getMessage() , exception )   ;
         
        if( exception instanceof BulkheadException ) {
            
            System.out.println(" Exception TYPE : BulkheadException ")   ;
            
            return Response.status(Response.Status.OK)
                           .header("x-reason" , exception.getMessage())
                           .entity ( "<status> BulkheadException : "          +
                                     exception.getClass()                     + 
                                     " ( Maybe MaxConcurrentUsers reached ) " +
                                     "</status>" )
                           .type(MediaType.APPLICATION_XML).build() ;
        }
        
        if( exception instanceof CircuitBreakerOpenException )                         {
            System.out.println(" Exception TYPE : CircuitBreakerOpenException")        ;
        }
        
        if( exception instanceof  FaultToleranceDefinitionException )                  {
            System.out.println("  Exception TYPE : FaultToleranceDefinitionException") ;
        }
        
        if( exception instanceof   TimeoutException ) {
            System.out.println("  Exception TYPE :  TimeoutException") ;
        }
        
        return Response.status(Response.Status.OK)
                       .header("x-reason" , exception.getMessage())
                       .entity ( "<status> FaultToleranceException : " +
                                 exception.getClass()                  +
                                 " </status> ")
                       .type(MediaType.APPLICATION_XML).build() ;
    }
}

