### SI_ORL_Présentation

--------------------------------------

1. #### Resources :

| Resource  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  |  Links &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
|-----------|---------------|
|  Talk_2017  |  [Full_Talk_2017](https://github.com/rac021/Jax-Y/blob/master/demo_sourceForge/Talk_PasSageEnSeine/Jax-Y.pdf)              | -- | -- |
|  **Talk_2020**  |  [Short_Talk_2020](https://github.com/rac021/Jaxy/blob/master/docs/talk/Jaxy.pdf) | -- | -- |
|  **Jaxy_bin_project**  |  [jaxy_bin_project](https://sourceforge.net/projects/jaxy/files/jaxy_2.2_bin.zip/download) | -- | -- |
|  Jaxy_src_project  |  [jaxy_src_project](https://sourceforge.net/projects/jaxy/files/Jaxy_2.2_src.zip/download) | -- | -- |
|  Jaxy_github_project |  [jaxy_github](https://github.com/rac021/Jaxy) | -- | -- |


--------------------------------------

https://github.com/rac021/Jax-Y/tree/master/demo_sourceForge

--------------------------------------

 **Demo :** 
 
 cd jaxy ( the root of the project )
 
 I )   [Download](https://sourceforge.net/projects/jaxy/files/jaxy_2.2_bin.zip/download) / or [Compile](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_0_installing_jaxy) ( For the most courageour ) the project :
 
         1 ) Download : https://sourceforge.net/projects/jaxy/files/jaxy_2.2_bin.zip/download
         
         2 ) Compilation Steps : https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_0_installing_jaxy
 
 II )   [Install demo Database](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_db-script) :
 
         1 )  https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_db-script 
       
       
 III )  [Public_services : Minimalist configuration file](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/01_public_services) :
  
         1 )  https://github.com/rac021/Jaxy/tree/master/jaxy/demo/01_public_services
       
 
 IV )  [Secured Services using CSO (With Full_Conf)](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/Full_Conf)
 
         1 )  ./run.sh serviceConf=demo/demo/Full_Conf/serviceConf.yaml
 
         2 )  Go to UI - Test Auth - Test secured Services
         
         3 )  Test Generated scripts client ( service plane : XML / JSON )
        
         4 )  Test Generated java client 
        
         5 )  Filter on : total_pssengers > 300 
         
         6 )  Keep Only : model 
         
         7 )  Keep Only model + distance_km 
         
 
 V )   [Secured Services using SSO ( With Full_Conf)](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/Full_Conf)
 
         1 )  Start keycloak Server :
         
               docker run -d                     \
                          --net host             \
                          -e "TRANSPORT=https"   \
                          -e "MODE=DEMO"         \
                          --name keycloakme      \
                          rac021/jaxy-keycloakme                         
         
         2 )  Take a look at the Keycloak configuration : https://localhost:8543
         
         3 )  ./run.sh serviceConf=demo/demo/Full_Conf/serviceConf_keycloak.yaml
 
         4 )  Test Generated scripts client
         
         5 )  Test Generated java client         
                  
         
 V  )  Run the GUI Client :
        
         1 )  java -jar GUI/jaxy-ui.jar
       
        
 VI  ) Tests ( Public serivce ) :
 
         1 ) invoke the serviceDiscovery     
             http://localhost:8080/rest/resources/infoServices
         
         2 ) invoke infoServices with XML/Encrypted - JSON/Encrypted
         
         3 ) invoke the service planes        
             http://localhost:8080/rest/resources/planes ( XML / JSON )

         4 ) Filter on total_pssengers > 300  :  total_passengers=_>_300  
         
         5 ) Keep Only model                  :  model
         
         6 ) Keep Only model + distance_km    :  model - distance_km
       

 VI ) Add new Secured Service ( customSignOn authentication ) :
 
         1 ) Stop the server
         
         2 ) Uncomment vip_planes service
         
         3 ) Uncomment customSignOn authentication in the serviceConf.yaml file
                  
         4 ) restart the server 
         
         5 ) invoke the serviceDiscovery    
             http://localhost:8080/rest/resources/infoServices
         
         6 ) invoke the service vip_planes  : 
             http://localhost:8080/rest/resources/vip_planes 
             ( XML / JSON / XML-ENCRYPTED / JSON-ENCRYPTED )
         
         7 ) Test authentication by changing login - password - timeStamp. Test timeOut 
          
         8 ) Test SQL type inference capacity

         9 ) Decrypt data locally 
         
        10 ) Filter on total_passengers=_>_300  
                       total_passengers=_>_300&model='Airbus A340-500'
                       total_passengers=_>_300&model=_not_'Airbus A340-500'
         
        10 ) Keep Only model                  :  model
         
        11 ) Keep Only model + distance_km    :  model - distance_km
         
        12 ) Change Tags using "AS" in SQL Queries
        
        13 ) Test CBC Cipher ( Explain IV )

        
 VII ) Test SSO authentication with KeyCloak ( should works with HTTPS ) :

         1 ) Start KeyCloak SERVER ( 127.0.0.1:8180 )
 
         2 ) Stop the jaxy server
         
         3 ) Comment customSignOn authentication in the serviceConf.yaml file
        
         4 ) Uncomment SSO authentication in the serviceConf.yaml file
        
         5 ) restart the server 
         
         6 ) Go to the SSO panel 
         
         7 ) invoke the serviceDiscovery 
             http://localhost:8080/rest/resources/infoServices
             
         -
         
         8 ) invoke the service vip_planes
             http://localhost:8080/rest/resources/vip_planes 
             ( XML - JSON - XML/Encrypted - JSON/Encrypted )
         
         9 ) Test authentication by changing login - password - clientID - secretID
         
        10 ) Filter On                        : total_passengers=_>_300
         
        11 ) Keep Only model                  :  model
         
        12 ) Keep Only model + distance_km    :  model - distance_km
        
        13 ) Add New User in Keycloak ( name + password + login )
        
        14 ) Test acces of the new user to the vip_planes service  
         
        15 ) Check logs in KeyCloak server for the user admin

        
 VIII ) Test Https 
 
         1 ) For customSignOn authentication
             
             - Enable HTTPS in serviceConf.yaml 
             
             - Set Self Signed Certificate vs Existing one 
             
             - Restart Server 
             
             - Go to : http://localhost:8443/rest/resources/infoServices
             
             - Tests 
         
         2 ) For SSO
          
             - Restart Keyloak using https mode ( Default port : 8545 )
             
             - Uncomment Keycloak_https.json int the serviceConf.yaml 
             
             - Restart Jax-Y server ( Default https port : 8443 )
             
             - Go to : http://localhost:8443/rest/resources/infoServices
             
             - Test Connections + Authentication for different users 
         
   
 IX  ) Generate Shell-script for automation 
 
         1 ) Generate script 
         
         2 ) test Script 
       
 X  ) Stress test - apache benchmark 
 
         1 ) Generate script for stress test
         
         2 ) Run AB

         3 ) Riddle ??
         
 Upcoming Features :
 
        * Swagger-Angular-Client intergration 
       
        * Runtime Algo Choice for Encryption ( AES - DES ... ) ( Done ! )

        * Global Configuration Supports ( Thread pool size, nb of threads by service ,
          data queue size ) ( Done ! )
          
        * Authentication server using HTTPS  ( Done ! )
              
        * GUI Https supports  ( Done ! )
        
        * Generate Jar Client for specific Configuration
        
        * Add Real Time decryption ( For Stream + Large data )
        
        * Add support Let's Encrypt
        
    



--------------------------------------
### LetsEncrypt :

```
     cd jaxy
      
     sudo docker run -dit --name apache-web -p 80:80 -v /var/www/html/ httpd:2.4     

     ./run.sh serviceConf=demo/17_test_letsEncrypt/serviceConf.yaml     
     
```
