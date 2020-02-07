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



### LetsEncrypt :

```
     cd jaxy
      
     sudo docker run -dit --name apache-web -p 80:80 -v /var/www/html/ httpd:2.4     

     ./run.sh serviceConf=demo/17_test_letsEncrypt/serviceConf.yaml     
     
```
