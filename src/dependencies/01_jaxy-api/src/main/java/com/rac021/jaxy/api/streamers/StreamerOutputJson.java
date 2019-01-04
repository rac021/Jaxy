
package com.rac021.jaxy.api.streamers ;

import java.io.Writer ;
import java.io.IOException ;
import java.io.OutputStream ;
import java.io.BufferedWriter ;
import java.util.logging.Level ;
import java.util.logging.Logger ;
import javax.xml.namespace.QName ;
import javax.xml.bind.Marshaller ;
import java.io.OutputStreamWriter ;
import javax.xml.bind.JAXBElement ;
import javax.xml.bind.JAXBException ;
import java.util.concurrent.TimeUnit ;
import java.io.ByteArrayOutputStream ;
import javax.ws.rs.core.MultivaluedMap ;
import com.rac021.jaxy.api.manager.IDto ;
import javax.ws.rs.core.StreamingOutput ;
import com.rac021.jaxy.api.manager.IResource ;
import com.rac021.jaxy.api.crypto.AcceptType ;
import com.rac021.jaxy.api.qualifiers.Format ;
import com.rac021.jaxy.api.exceptions.BusinessException ;
import static com.rac021.jaxy.api.logger.LoggerFactory.getLogger ;
import static com.rac021.jaxy.api.streamers.DefaultStreamerConfigurator.* ;

/**
 *
 * @author yahiaoui
 */

@Format(AcceptType.JSON_PLAIN)
public class StreamerOutputJson extends Streamer implements StreamingOutput {

    private static final Logger LOGGER = getLogger() ;
   
    public StreamerOutputJson() {
    }

    @Override
    public void write(OutputStream output) throws IOException {
        
       LOGGER.log(Level.FINE ," Processing data in StreamerOutputJson ... ") ;

       if( checkIfExceptionsAndNotify( "StreamerOutputJson-RuntimeException",false )) return ;
            
       configureStreamer() ;

       /** Submit Producers . */
       poolProducer.submit( () -> producerScheduler() ) ;      
      
       try (  Writer writer = new BufferedWriter ( new OutputStreamWriter(output, "UTF8")) ;
              ByteArrayOutputStream baoStream = new ByteArrayOutputStream()              ) {

            System.setProperty( "javax.xml.bind.context.factory" ,
                                "org.eclipse.persistenputce.jaxb.JAXBContextFactory") ;

            Marshaller marshaller  =  getMashellerWithJSONProperties() ;
            int iteration          =  0                                ;

            while ( ! isFinishedProcess || !dtos.isEmpty() )           {

                IDto poll = dtos.poll( 50 , TimeUnit.MILLISECONDS)     ;
                   
                if( poll != null ) {
                    
                      JAXBElement<IDto> je2 = new JAXBElement<> ( new QName("Data") , 
                                                                  resource.getDto() , 
                                                                  poll            ) ;
                      
                      marshaller.marshal(je2, baoStream)       ;

                      writer.write(baoStream.toString("UTF8")) ;
                      baoStream.reset()                        ;
                      iteration ++                             ;
                      
                      if (iteration % responseCacheSize == 0 )  writer.flush() ;
                }
             }

             writer.flush()    ;
             
             checkIfExceptionsAndNotify( "StreamerOutputJson-RuntimeException",true )  ;
             
        } catch (JAXBException | IOException ex)          {
            
            LOGGER.log(Level.SEVERE, ex.getMessage(), ex) ;
            
            if (ex.getClass().getName().endsWith(".ClientAbortException")) {
                try {
                    throw new BusinessException("ClientAbortException !! " + ex.getMessage()) ;
                } catch (BusinessException ex1) {
                     LOGGER.log(Level.SEVERE, ex1.getMessage(), ex1) ;
                }
            } else {
                try {
                    throw new BusinessException("Exception : " + ex.getMessage(), ex)         ;
                } catch (BusinessException ex1 )                   {
                    LOGGER.log(Level.SEVERE, "Exception : ", ex1 ) ;
                }
            }
        }   catch (InterruptedException ex) {
            LOGGER.log(Level.SEVERE, "Exception : ", ex) ;
        } finally {
             LOGGER.log(Level.CONFIG, " StreamerOutputJson : CLOSE WRITER AND BAOSTREAM")     ;
       }
    }

    public ResourceWraper getResource() {
        return resource ;
    }
 
    @Override
    public StreamerOutputJson wrapResource( IResource resource   , 
                                            Class     dto        ,
                                            String    keepFields ,
                                            MultivaluedMap<String, String> ... filedsFilter ) {

        rootResourceWraper( resource, dto, keepFields, filedsFilter ) ;
        
        return this ;
    }
    
    public StreamerOutputJson wrapResource( IResource resource , Class dto ) {

        rootResourceWraper( resource, dto, null ) ;        
        return this                               ;
    }
}
