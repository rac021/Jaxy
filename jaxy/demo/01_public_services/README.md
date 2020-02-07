

##  Public_services ( Minimalist configuration file ) [ ( watch the demo ) ](https://www.youtube.com/watch?v=-uH29g2xSFg&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=3)

  #### 1- Let's take a look at the configuration file :
        
         vim jaxy/demo/01_public_services/serviceConf.yaml

  #### 2 - Run jaxy using the configuration file located in the directory jaxy/demo/01_public_services  :
             
         cd jaxy   
         
         java -jar                                                   \
              -DserviceConf=demo/01_public_services/serviceConf.yaml \
               jaxy-thorntail.jar    
        
-----------------------------------------------------------------

  ~~**Note :** If the jar **jaxy-thorntail** and the file **serviceConf.yaml** are located in the same **directory**,
         you don't need to provide the -DserviceConf=.. ( this will be **automatically**  **detected**  by jaxy )~~

-----------------------------------------------------------------

  By default jaxy starts on the port **8080** ( which is **configurable** in the **serviceConf.yaml** ) 

-----------------------------------------------------------------

  Jaxy deploy a **serviceDiscovery** wich l**ist all the services** that have been **created** during the **deployement time** 

       curl http://localhost:8080/rest/resources/infoServices

-----------------------------------------------------------------

  In order to **invoke a specific service**, juste replace **infoServices** by the **name of the service**

   * Example using curl : 

     * Service One ( **plane** Service )

         -  ```curl http://localhost:8080/rest/resources/planes```

     * Service Two  ( **vip_plane** Service )

         -  ```curl http://localhost:8080/rest/resources/vip_planes```

-----------------------------------------------------------------

   We can also controle the **number of threads** that will be **used** by **each service** by adding 
   **MaxThreads** attribute 

   Example : **MaxThreads : 2**
 
-----------------------------------------------------------------

   In the following demos, we will use the script **run.sh** for running jaxy which provides options like
   ( starts in **debug_mode**, or add some **certificates** to the **trustStore** ,that will be **trusted** by jaxy 
   ( see demo : **keycloak** ) )


