
package com.rac021.jaxy.api.streamers ;

import java.io.Writer ;
import javax.inject.Inject ;
import java.io.IOException ;
import java.io.OutputStream ;
import java.io.BufferedWriter ;
import java.util.logging.Level ;
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
import static com.rac021.jaxy.api.streamers.DefaultStreamerConfigurator.* ;

/**
 *
 * @author yahiaoui
 */

@Format(AcceptType.JSON_PLAIN)
public class StreamerOutputJson extends Streamer implements StreamingOutput {

    @Inject
    @com.rac021.jaxy.api.qualifiers.MarshallerType("JSON")
    Marshaller marshaller ;
   
    public StreamerOutputJson() {
    }

    @Override
    public void write(OutputStream output) throws IOException  {
        
       LOGGER.log( Level.FINE ," Processing data in StreamerOutputJson ... ")          ;

       checkIfExceptionsAndNotify( "StreamerOutputJson-RuntimeException",false, null ) ;
            
       configureStreamer() ;

       /** Submit Producers . */
       poolProducer.submit( () -> producerScheduler() ) ;      
      
       /** StreamingOutput must not be closed **/
       Writer writer = new BufferedWriter ( new OutputStreamWriter(output, "UTF8")) ;
        
       try ( ByteArrayOutputStream baoStream = new ByteArrayOutputStream ()   )     {

            int iteration                    =  0                      ;

            while ( ! isFinishedProcess || !dtos.isEmpty() )           {

                IDto poll = dtos.poll ( 30 , TimeUnit.MILLISECONDS)    ;
                   
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

             checkIfExceptionsAndNotify( "StreamerOutputJson-RuntimeException",true, null ) ;
           
             writer.flush()                                                                 ;
             
        } catch ( JAXBException | IOException ex )          {
            
            LOGGER.log( Level.SEVERE, ex.getMessage(), ex ) ;
            
            if ( ex.getClass().getName().endsWith(".ClientAbortException")) {
                
                throw new RuntimeException("ClientAbortException !! " + ex.getMessage())   ; 
                
            } else {
                
                throw new RuntimeException("Exception : " + ex.getMessage(), ex )          ;
            }
           
        }   catch ( InterruptedException ex ) {
           
            LOGGER.log(Level.SEVERE, "InterruptedException : ", ex )                       ;
            throw new RuntimeException("InterruptedException !! " + ex.getMessage())       ; 
           
        } finally {
             LOGGER.log(Level.CONFIG, " StreamerOutputJson : CLOSE WRITER AND BAOSTREAM")  ;
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
