

Table ( **users** ) in the **aviation database** ( created by the **script db_script.sh** : 
 [ Installing the demo Database](https://github.com/rac021/Jaxy/tree/master/jaxy/demo/00_db-script) ) 

- In the column password, the **passwords** are stored in **MD5** Mode ( it could have been **SHA256** )

![jaxy_auth_custom_signon](https://user-images.githubusercontent.com/7684497/50670242-9048a080-0fca-11e9-85d5-5149f199deac.png)


### Example of how signature is calculated :


### The Configuration file :  

![jaxy_signature_final](https://user-images.githubusercontent.com/7684497/50673350-592fba80-0fdd-11e9-9156-e87e6c6839ef.png)

```
        Login =  my_login            password =  my_password             timeStamp =   123456789
    
```

![jaxy_calculatore_01](https://user-images.githubusercontent.com/7684497/50697489-a72ad980-1042-11e9-891f-b814506b8a91.jpg)


-----------------------------------------------------------

![jaxy_calculatore_02](https://user-images.githubusercontent.com/7684497/50697672-2fa97a00-1043-11e9-9314-324264611c1d.jpg)
