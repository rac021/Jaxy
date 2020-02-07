
## SI_ORL_Présentation


### LetsEncrypt :

```
     cd jaxy
      
     sudo docker run -dit --name apache-web -p 80:80 -v /var/www/html/ httpd:2.4     

     ./run.sh serviceConf=demo/17_test_letsEncrypt/serviceConf.yaml     
     
```
