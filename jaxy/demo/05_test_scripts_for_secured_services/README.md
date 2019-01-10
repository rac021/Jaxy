
## Test scripts for Secured Services [ ( watch the demo ) ](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7)
 
  In this_demo, we will see how to **generate** a **bash_client** for **secured_services**. 

  We will **focuse** on the **service "vip_plane"**
  
--------


  *  1- [ Let's open the file_configuration ](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7&t=0m26s) ( **demo 05** ) :

```               
        vim jaxy/demo/05_test_scripts_for_secured_services/serviceConf.yaml 
```
 
  **Note :** The **configuration file** used in this **demo** is the **same** as the one **used previously**


--------

  *  2- [Launch jaxy](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7&t=1m19s) : 

```	   
       ./run.sh  serviceConf=jaxy/demo/05_test_scripts_for_secured_services/serviceConf.yaml
```
      
----

  * 3- [Go to the **WEB-UI**](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7&t=1m44s) : 
  
```	   
       http://localhost:8080/
```

----

   [**Copy** ( or **Download** the script **generated by jaxy** )](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7&t=2m27s) 


   [**Run it ( using the following command line ):**](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7&t=2m55s) 

```
          ./jaxy_client.sh
```

 **Oupsssss !!!!** Something went wrong **:-/**
  
----

As **"vip_planes"** is a **secured_service** , we need to provide **login**  +  **password**

```
       login      =   admin ( the login of the user )


       password   =   admin ( the password of the user, stored in the database in  MD5  format )


So : MD5("admin") = 21232f297a57a5a743894a0e4a801fc3

```

-----

#### [Launch the bash_client as the following :](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7&t=4m37s)  

```
      ./jaxy_client.sh  login=admin  password=admin      
```

**Now**, It work's **:-)**

-----

### **Important :  The password is never sent in clear on the network**

-----

#### [3- Let's request data in XML format](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7&t=5m20s) 

-----

         
### Filetering : 

-----

#### [4- Let's now Filter the planes and keep only those :](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7&t=6m08s)

```
    distance_km  >  11000      ( AND )
    distance_km  <  16000      ( AND )

    speed_km_h   >  1000
```               
               
----


#### [5- Let's add another Filter on the model :](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7&t=7m38s)

```
    model   =   Boeing 747-8 
```

----

 [**AND KEEP ONLY the following FIELDS ( in the result ) :**](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7&t=8m35s)

```
         -  total_passengers 

         -  cost_euro
```
----

#### [6- Let's request data in JSON/ENCRYPTED format with :](https://www.youtube.com/watch?v=n3U0hMAEMnQ&list=PLgd4yhA9GWz3lc2XmuW1lwlH3sjT4gHwa&index=7&t=9m12s)

```
         CIPHER = AEC_256_CBC
```
----

 ### Take a look at  [ 06. Test scripts for Decryption](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/06_test_scripts_for_decryption) demo to see how are data **decrypted**
         