### SI_ORL_Présentation

--------------------------------------

### **Agenda :**

| Session  | Reference  |  Time |
|:---------------------------|:----------------------------|:----------------------------|
| Talk | [ Short_Talk_2020](https://github.com/rac021/Jaxy/blob/master/docs/talk/Jaxy.pdf) | ~ 10 mn |
|  **Demo** | [Short_Demo](https://github.com/rac021/Jaxy/edit/master/docs/talk/README.md) | ~ 15 mn |
 
-----------------------------------------------------

###### **Requirements :**

| Tool               | Requirement                              | 
|:-------------------|:--------------------------------         |
| `JAVA 8`           | **Required**                             |
| `MAVEN 3.3.9 +`    | **Required for Compilation**             |
| `Postgres - mySql` | **Required**                             |
| `git`              | **Required for Cloning the project**     |
| `openssl`          | **Required for LetsEncrypt + Decryption**|
| `curl`             | **Required for Script client**           |

---

 I )   [Download](https://sourceforge.net/projects/jaxy/files/jaxy_2.2_bin.zip/download) / or [Compile](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_0_installing_jaxy) ( For the most courageour ) the project :
 
         1 ) Download : https://sourceforge.net/projects/jaxy/files/jaxy_2.2_bin.zip/download
         
         2 ) Compilation Steps : https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_0_installing_jaxy
 
         3 )  **cd jaxy** # ( the root of the project )
         
 II )   [Install demo Database](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_db-script) :
 
         1 )  https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_db-script    
         
       
 III )  [Public_services : Minimalist configuration file](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/01_public_services) :
  
         1 )  https://github.com/rac021/Jaxy/tree/master/jaxy/demo/01_public_services
       
 
 IV )  [Secured Services using CSO ( With Full_Conf )](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/Full_Conf)
 
         1 )  ./run.sh serviceConf=demo/Full_Conf/serviceConf.yaml
 
         2 )  Go to UI - Test Auth - Test secured Services
         
         3 )  Test Generated scripts client ( service plane : XML / JSON )
        
         4 )  Test Generated java client 
        
         5 )  Filter on : total_pssengers > 300 
         
         6 )  Keep Only : model 
         
         7 )  Keep Only model + distance_km 
         
 
 V  ) Test Decryption Features : 
 
         1 ) https://github.com/rac021/Jaxy/tree/master/jaxy/demo/06_test_scripts_for_decryption
         
         2 ) Using Java Client 
         
         
 VI ) [Secured Services using SSO : Keycloak  With HTTPS + Full_Conf )](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/Full_Conf)
 
         1 )  Start keycloak Server :
         
               docker run -d                     \
                          --net host             \
                          -e "TRANSPORT=https"   \
                          -e "MODE=DEMO"         \
                          --name keycloakme      \
                          rac021/jaxy-keycloakme                         
         
               => Creates :          
                   - REALM            : my_realm
                   - CLIENT_ID        : my_app
                   - CLIENT_SECRET_ID : my_secret
                   - USER_1           : with login admin  / password admin
                   - USER_2           : with login public / password public
                   - ROLE             : manager
                   - Affect the Role "Manager" to the Client "my_app" 
                   - Affect the Role "Manager" to the user Admin 
             
         2 )  Take a look at the Keycloak configuration : https://localhost:8543
         
         3 )  ./run.sh serviceConf=demo/Full_Conf/serviceConf_keycloak.yaml \
                       auto_extract_keycloak_certificate
 
         4 )  Test Generated scripts client
         
         5 )  Test Generated java client 
         
              =>     java -jar jaxyClient.jar  confPath            jaxy_conf.txt \
                                               keycloak_client_id  my_app        \
                                               keycloak_secret_id  my_secret     \
                                               keycloak_login      admin         \
                                               keycloak_password   admin
         
         6 ) Remove Manager Role for Admin User & Test vip_planes service
         
         
 VII )  [Jaxy Monitoring ( Prometheus / Grafana )](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/18_Docker#3-docker-compose-) :
         
         1 ) cd demo/18_Docker/
         
         2 ) docker-compose -f docker-compose-sso.yml up
         
         3 ) Go to : 
          
             - http://jaxy:8181
             
             - http://jaxy-prometheus:9090     
             
             - http://jaxy-grafana:3000 
             
         4 ) Test real time Total_Called_Services Dashboard 
         
         5 ) Test real time Response_Services Dashboard
         
         6 ) Test real time Monitoring Dashboard
         
         7 ) Test real time Faillure_Authentication Dashboard
         
         8 ) Test real time Exceptions Dashboard
         
         
 VIII )  [Cloud Deployment](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/18_Docker#4-try-play-with-docker-) :
         
         1 ) Because it works on the local machine, it should also works in the cloud :-) : 
             
             https://github.com/rac021/Jaxy/tree/master/jaxy/demo/18_Docker#4-try-play-with-docker-
         
  
 IX  )  [LetsEncryt Feature : X509 certificates Generator](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/17_test_letsEncrypt) :
 
         1 )  cd jaxy
      
         2 )  docker run -dit --name apache-web -p 80:80 -v /var/www/html/ httpd:2.4     

         3 ) ./run.sh serviceConf=demo/17_test_letsEncrypt/serviceConf.yaml 
       
       
 X  ) Bonus : GUI Client :
        
         1 )  cd jaxy
         
         2 )  java -jar lib/client/jaxy-client.jar



--------------------------------------

 #### Resources :

| Resource  | Link |  Link |
|:---------------------------|:----------------------------|:---------------------|
| Talks|  [Full_Talk_2017](https://github.com/rac021/Jax-Y/blob/master/demo_sourceForge/Talk_PasSageEnSeine/Jax-Y.pdf) | [ Short_Talk_2020](https://github.com/rac021/Jaxy/blob/master/docs/talk/Jaxy.pdf)  |
| Jaxy_src |    [sourceforge_project](https://sourceforge.net/projects/jaxy/files/Jaxy_2.2_src.zip/download)    |    [github_project](https://github.com/rac021/Jaxy) |
| Jaxy_bin | [bin_project](https://sourceforge.net/projects/jaxy/files/jaxy_2.2_bin.zip/download)  |    [CSO Auth Mechanism](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/02_secured_services_with_custom_signon_auth) |

