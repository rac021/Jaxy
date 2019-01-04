

Table ( **users** ) in the **aviation database** ( created by the **script db_script.sh** : 
 [ Installing the demo Database](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_db-script) ) 

- In the column password, the **passwords** are stored in **MD5** Mode ( it could have been **SHA256** )

![jaxy_auth_custom_signon](https://user-images.githubusercontent.com/7684497/50670242-9048a080-0fca-11e9-85d5-5149f199deac.png)


### Example of how signature is calculated :


### The Configuration file :  

![jaxy_signature](https://user-images.githubusercontent.com/7684497/50672853-bd9d4a80-0fda-11e9-866e-201066044304.png)


```
        Login =  my_login            password =  my_password             timeStamp =   123456789
    
```

![jaxy_signature_calcuclator](https://user-images.githubusercontent.com/7684497/50672733-2d5f0580-0fda-11e9-9b88-704d9278eaeb.jpg)
