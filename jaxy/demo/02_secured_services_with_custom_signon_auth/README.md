


### Secured Services ( Custom SingOn Auth )
 
   * Jaxy supports two ways to secure services :
 
         -  custom signOn    auth. 

         -  SSO ( Keycloak ) auth.

   In this demo, I'll focus on the custom signOn auth

----------------------------------------------------

### credentials :  Description of the Informations for the Authentication 

   * 1- **Table users** ( database : aviation ) :

   ![jaxy_auth_custom_signons](https://user-images.githubusercontent.com/7684497/50670242-9048a080-0fca-11e9-85d5-5149f199deac.png)

   * 2- **serviceConf.yaml :**

   ![jaxy_credentials](https://user-images.githubusercontent.com/7684497/50717511-fba47800-1087-11e9-87fc-fa04f4843d38.png)


   - **tableName**  : **users** =>  The table used for the authentication is named **users**
                     
       * ( this table was previously created using the **script db_script.sh**
 [ Installing the demo Database](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_db-script) ) 
 
     
   - **loginColumnName** : **login** => The Name of the column which contains the logins ( in the table **users** )

   - **passwordColumnName** : **password** => The Name of the column where **passwords** are stored. 
    
       * These passwords are  stored in **MD5** Mode ( it could have been **SHA256** )

--------------------------------------------------


### Example of how signature is calculated :


### The Configuration file ( **serviceConf.yaml** ) :  

![jaxy_signature_final](https://user-images.githubusercontent.com/7684497/50673350-592fba80-0fdd-11e9-9156-e87e6c6839ef.png)


#### Let's suppose in the following schema that :

  ``` 
      Login     =  my_login    
      password  =  my_password 
      timeStamp =  123456789   
  ```


![jaxy_calculatore_01](https://user-images.githubusercontent.com/7684497/50697489-a72ad980-1042-11e9-891f-b814506b8a91.jpg)


-----------------------------------------------------------

Jaxy is called using an HTTP Query with the header **API-Key-Token** which contains the signature 

![jaxy_calculatore_02](https://user-images.githubusercontent.com/7684497/50697672-2fa97a00-1043-11e9-9314-324264611c1d.jpg)
