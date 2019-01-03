# Jaxy  <img src="https://cloud.githubusercontent.com/assets/7684497/25315596/e191fb00-2857-11e7-99bf-8e233b4eb795.jpg" width="50"> [![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT)



| Branch    | build status  |
|-----------|---------------|
| [master](https://github.com/rac021/Jaxy/tree/master)  |[![Build Status](https://travis-ci.org/ontop/ontop.svg?branch=master)](https://travis-ci.org/rac021/Jaxy)|


 **Jaxy** is Generic Jax-Rs web Service based over yaml configuration implementing the project  **[Jaxy-Api]( https://github.com/rac021/Jaxy/tree/master/src/dependencies/01_jaxy-api)**

**SourceForge Download Link** : **[https://sourceforge.net/projects/jaxy/?source=typ_redirect]( https://sourceforge.net/projects/jaxy/?source=typ_redirect)** 

---------------------------------------------------------------------------------

[ Take a look at Jaxy ( Features ) ](https://github.com/rac021/Jaxy/tree/master/docs)


------------------------------------------------------

**Linked Projects and structure :** 

- **Jaxy ( Java Project ) ( Directory : [src/jaxy](https://github.com/rac021/Jaxy/tree/master/src/jaxy) ) :**
   * [https://github.com/rac021/Jaxy/tree/master/src/jaxy]( https://github.com/rac021/Jaxy/tree/master/src/jaxy) 
      
- **Jaxy-Api : ( Directory : [src/dependencies/01_jaxy-api](https://github.com/rac021/Jaxy/tree/master/src/dependencies/01_jaxy-api) ) :**
   * [https://github.com/rac021/Jaxy/tree/master/src/dependencies/jaxy-api]( https://github.com/rac021/Jaxy/tree/master/src/dependencies/01_jaxy-api)

- **Default Security Provider Implementation ( Directory : [src/dependencies/02_jaxy-security-provider](https://github.com/rac021/Jaxy/tree/master/src/dependencies/02_jaxy-security-provider) ) :**
   * [https://github.com/rac021/Jaxy/tree/master/src/dependencies/jaxy-security-provider]( https://github.com/rac021/Jaxy/tree/master/src/dependencies/02_jaxy-security-provider) 
     
- **Default Service Discovery Implementation  ( Directory : [src/dependencies/03_jaxy-service-discovery](https://github.com/rac021/Jaxy/tree/master/src/dependencies/03_jaxy-service-discovery) ) :**
   * [https://github.com/rac021/Jaxy/tree/master/src/dependencies/jaxy-service-discovery]( https://github.com/rac021/Jaxy/tree/master/src/dependencies/03_jaxy-service-discovery) 

- **CertMe ( Lets's Encrypt Certificate Generator ) ( Directory : [src/dependencies/04_certMe](https://github.com/rac021/Jaxy/tree/master/src/dependencies/04_certMe) ) :**
   * [https://github.com/rac021/Jaxy/tree/master/src/dependencies/certMe]( https://github.com/rac021/Jaxy/tree/master/src/dependencies/04_certMe) 

- **Default Jaxy-Client-Api ( Downloadable from Jaxy Web-UI ) ( Directory : [src/dependencies/05_jaxyClient](https://github.com/rac021/Jaxy/tree/master/src/dependencies/05_jaxyClient) ) :**
   * [https://github.com/rac021/Jaxy/tree/master/src/dependencies/jaxyClient-Api]( https://github.com/rac021/Jaxy/tree/master/src/dependencies/05_jaxyClient) 
   
- **GUI ( Directory : [src/add-on/JaxyClientUi](https://github.com/rac021/Jaxy/tree/master/src/add-on/JaxyClientUi) ) :**
   * [https://github.com/rac021/Jaxy/tree/master/src/add-on/JaxyClientUi]( https://github.com/rac021/Jaxy/tree/master/src/add-on/JaxyClientUi) 


**Requirements :**

-    `JAVA 8`
    
-    `MAVEN 3.3.9 + `
   
-    `Postgres | mySql `

-----------------------------------------------------

## installation [ ( watch the demo ) ](https://www.youtube.com/watch?v=6IqxzSankpw&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=1)

```xml
  ./compile.sh
``` 
A jar **jaxy-thorntail.jar** is created and copied into the folder **[jaxy](https://github.com/rac021/Jaxy/tree/master/jaxy)**

  [![Watch the video](https://user-images.githubusercontent.com/7684497/50618868-c831e400-0ef5-11e9-8049-84d5c4566fb8.jpg)](https://www.youtube.com/watch?v=6IqxzSankpw&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=1)
  
------------------------------------------------------

## Demo 

 -  ### [ 00. Installing the demo Database](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_db-script)
 
 -  ### [ 01. Public_services ( Minimalist configuration file](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/01_public_services)
 
 -  ### [ 02. Secured_services](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/02_secured_services)
 
 -  ### [ 03. UI )](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/03_ui)
 
 -  ### [ 04. Test scripts for Public Services](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/04_test_scripts_for_public_services)
 
 -  ### [ 05. Test scripts_for_Secured_Services](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/05_test_scripts_for_secured_services)
  
 -  ### [ 06. Test scripts_for_Decryption](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/06_test_scripts_for_decryption)
  
 -  ### [ 07. Test_Templating](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/07_test_templating)
 
 -  ### [ 08. Test java Client_for Public Services](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/08_test_java_client_for_public_services)
  
 -  ### [ 09. Test java Client_for Secured_Services](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/09_test_java_client_for_secured_services)
 
 -  ### [ 10. Test java Client_for Decryption](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/10_test_java_client_for_decryption)
 
 -  ### [ 11. Test keycloak authentication](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/11_test_keycloak_authentication)
 
 -  ### [ 12. Test scripts keycloak](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/12_test_scripts_keycloak)
 
 -  ### [ 13. Test java Client keycloak](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/13_test_java_client_keycloak)
 
 -  ### [ 14. Test CustomSignOn Auth from Ui](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/14_test_CustomSignOn_Auth_from_Ui)

 -  ### [ 15. Test CustomSignOn Auth from Ui](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/15_test_KeyCloak_Auth_from_Ui)

 -  ### [ 16. Test Monitoring](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/16_test_monitoring)

 -  ### [ 17. Test letsEncrypt](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/17_test_letsEncrypt)
 
------------------------------------------------------


  [Talk_2017_PasSageEnSeine]( https://github.com/rac021/Jax-Y/blob/master/demo_sourceForge/Talk_PasSageEnSeine/Jax-Y.pdf
) ( PDF ) 

