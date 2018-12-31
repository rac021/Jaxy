
package com.rac021.jaxy.api.root ;

import javax.ws.rs.PathParam ;
import javax.ws.rs.HeaderParam ;
import com.rac021.jaxy.api.exceptions.BusinessException ;

/**
 *
 * @author ryahiaoui
 */

public interface IRootService {

    Object subResourceLocators ( @HeaderParam("API-key-Token") String token  ,
                                 @HeaderParam("Accept")        String accept ,
                                 @HeaderParam("Cipher")        String cipher ,
                                 @PathParam("codeService")     String codeService) throws BusinessException ;

    Object authenticationCheck ( @PathParam("login") String login         ,
                                 @PathParam("signature") String signature ,
                                 @PathParam("timeStamp") String timeStamp) throws BusinessException ;

}
