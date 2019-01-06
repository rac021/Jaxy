
## Web-Ui ( Quick Overview ) [ ( watch the demo ) ](https://www.youtube.com/watch?v=KUDcK6-_BZk&index=6&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa)
 
   With jaxy, you can **choose** to **deploy** the **web-ui** ( **or not** ) ( **with** or **without** **Controle access** ) 

   - The **Web-Ui can be useful** to  :

        * **List deployed services** ( with details : parameters of each service )

        * Show the **global configuration** of jaxy

        * **Generate on the fly bash client or java client** 

        * **Test Authentication** ( for **Custom-SingOn** and **Keycloak** ) ...

--------



  #### Start Jaxy : 
  
       ./run.sh  serviceConf=jaxy/demo/03_web_ui/serviceConf.yaml

  #### Goto The 
      
       http://localhost:8080
       
 #### Authentication :
      
         LOGIN    = jaxy 
         PASSWORD = jaxy
         
 ------- 
 
====  NOTE ====

  Jaxy, provides **Two additional** services :
            
     * infoServices : ( Service Discovery ), list the existing services 

     * time : Used to get a timeStamp from  jaxy ( in order to synchronize the clients with  the server )

--------

 The **service details** is composed of **three parts**  :


      1. Description Part

      2. Filter      Part 

      3. Client      Part


  The **filter part** and the **client part** will be **discussed** in the **following demos**


