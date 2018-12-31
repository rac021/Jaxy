
 package com.rac021.jaxy.api.root ;

 import javax.ws.rs.ext.Provider ;
 import javax.ws.rs.container.PreMatching ;
 import javax.ws.rs.container.ContainerRequestFilter ;
 import javax.ws.rs.container.ContainerRequestContext ;

 /**
 *
 * @author ryahiaoui
 */

 @Provider
 @PreMatching
 public class RequestInterceptor implements ContainerRequestFilter {

    @Override
    public void filter(ContainerRequestContext requestContext) {
        
         String accept = requestContext.getHeaders().getFirst("Accept")     ;
          if (accept == null || accept.equals("*/*")) {
              requestContext.getHeaders().putSingle("Accept", "json/plain") ;
          }
    }

 }
