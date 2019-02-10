
package com.rac021.jaxy.api.exceptions ;

import java.util.logging.Level ;
import java.util.logging.Logger ;
import javax.ws.rs.ext.Provider ;
import javax.ws.rs.core.Response ;
import javax.ws.rs.core.MediaType ; 
import javax.ws.rs.ext.ExceptionMapper ;
import com.rac021.jaxy.api.metrics.Metrics ;
import static com.rac021.jaxy.api.logger.LoggerFactory.getLogger ;

/**
 *
 * @author yahiaoui
 */

@Provider
public class UnAuthorizeResourceExceptionMapper implements ExceptionMapper<UnAuthorizedResourceException> {

    static final Logger LOGGER = getLogger() ; 
    
    @Override
    public Response toResponse( UnAuthorizedResourceException ex) {
        
        Metrics.incTfailureAuthentication()            ;
         
        LOGGER.log(Level.SEVERE, ex.getMessage(), ex ) ;
         
        return Response.status( Response.Status.UNAUTHORIZED )
                       .header( "x-reason",
                                ex.getMessage()).entity ( "<status> UnAuthorizedResource : " +
                                                          ex.getLocalizedMessage() + "</status>" )
                       .type(MediaType.APPLICATION_XML)
                       .build() ;
    }
}
