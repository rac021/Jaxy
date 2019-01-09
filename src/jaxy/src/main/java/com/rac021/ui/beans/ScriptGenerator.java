
package com.rac021.ui.beans ;

import java.util.Objects ;
import java.util.stream.Stream ;
import java.util.stream.IntStream ;
import java.util.stream.Collectors ;
import java.io.UnsupportedEncodingException ;

/**
 *
 * @author ryahiaoui
 */

public class ScriptGenerator {
    

    protected static String generateScriptCUSTOM( String url           ,
                                                  String params        , 
                                                  String keep          , 
                                                  String accept        , 
                                                  String hashLogin     ,
                                                  String hashPassword  , 
                                                  String hashTimeStamp , 
                                                  String algoSign      , 
                                                  String cipher        , 
                                                  String security      ,
                                                  String templateSignature ) throws UnsupportedEncodingException {

        String _url      = url.trim()                                       ;

        String _params   = splitParamsToDataUrlEncoder(params)              ;
        
        String trustCert = _url.trim().startsWith("https") ? " -k " : " "   ;

        String invokeService = " curl -G " + trustCert + "-H \"Accept: "    +
                                accept + "\"  " ;

        if ( keep != null && !keep.isEmpty() )                  {
           invokeService += " -H \"Keep: " + keep + " \" "      ;
        }

        if ( cipher != null && !cipher.isEmpty() )              {
            invokeService += " -H \"Cipher: " + cipher + " \" " ;
        }

        return "#!/bin/bash \n\n" + " # Script generated by JAXY-CLIENT \n" +
                " # Author    : Jaxy-client \n\n"                           +
                " # Signature : " + templateSignature + "\n\n\n"            +
                " cmd_example()  {                           \n "           +
                "     echo                                   \n "           +
                "     echo \" Example :  \"                  \n "           +
                "     echo \" ./jaxy_client.sh "                            +
                                "login=my_login password=my_password \" ; " +
                "     echo                                              \n" +
                " }                                                   \n\n" +
                " while [[ \"$#\" > \"0\" ]] ; do \n\n  "                   +
                "     case $1 in                  \n                      " +
                "         (*=*) KEY=${1%%=*}      \n                      " +
                "               VALUE=${1#*=}     \n                      " +
                "               case \"$KEY\" in    \n                    " +
                "                    (\"login\")        LOGIN=$VALUE    \n" +
                "                    ;;                    \n"              +
                "                    (\"password\")     PASSWORD=$VALUE \n" +
                "               esac \n                                   " +
                "         ;;\n"                                             +
                "         help)  echo       \n"                             +
                "                echo \" Total Arguments : Two \"       \n" +
                "                echo \n" +
                "                echo \"   login=     : your_login    \"\n" +
                "                echo \"   password=  : your_password \"\n" +
                "                echo                                   \n" +
                "                exit;                                  \n" +
                "     esac                                              \n" +
                "     shift                                             \n" +
                "  done \n\n"                                               + 
                "  if [ -z \"$LOGIN\" ] ; then  \n"                         +
                "     echo; echo \" login can't be empty !    \" \n"        +
                "     cmd_example ; exit ;      \n"                         +
                "  fi \n"                                                   +
                "  if [ -z \"$PASSWORD\" ] ; then  \n"                      +
                "     echo; echo \" password can't be empty ! \" \n"        +
                "    cmd_example ; exit ;   \n"                             +
                "  fi \n\n"                                                 +
                " Login=\"$LOGIN\"        \n\n"                             +
                " Password=\"$PASSWORD\"  \n\n"                             +
                getHashedScript("Login", hashLogin)         + "\n\n"        +
                getHashedScript("Password", hashPassword)   + "\n\n"        +
                " TimeStamp=$(date +%s)                        \n\n"        +
                getHashedScript("TimeStamp", hashTimeStamp) + "\n\n"        +
                getSigneScript(algoSign)                    + "\n\n"        +
                invokeService                                               +
                ( ! security.toLowerCase().contains("public")
                        ? "-H \"API-key-Token: "   +
                           "$Login $TimeStamp $SIGNE\" " : "")              +
                _params + "\"" + _url.replaceAll(" ", "%20") + "\""         ;
    }
    
    
    protected static String generateScriptSSO( String url           ,
                                               String params        ,
                                               String keep          ,
                                               String accept        ,
                                               String hashLogin     ,
                                               String hashPassword  , 
                                               String hashTimeStamp ,
                                               String algoSign      , 
                                               String cipher        ,
                                               String security      ,
                                               String keyCloakUrl   ) throws UnsupportedEncodingException {
        
        String _url                 = url.trim()                                                ;

        String _params              = splitParamsToDataUrlEncoder(params)                       ;
        
        String trustCertkeyCloakUrl = keyCloakUrl.trim().startsWith("https") ? " -k " : " "     ;
        String trustCertUrl         = _url.startsWith("https") ? " -k " : " "                   ;

        String KEYCLOAK_RESPONSE    = 
            
               " KEYCLOAK_RESPONSE=`curl " + trustCertkeyCloakUrl
                + "-s -X POST $KEYCLOAKURL                                  \\\n " + getBlanc(28)
                + " -H \"Content-Type: application/x-www-form-urlencoded\"  \\\n " + getBlanc(28)
                + " -d \"username=$USER_NAME\"                              \\\n " + getBlanc(28)
                + " -d \"password=$PASSWORD\"                               \\\n " + getBlanc(28)
                + " -d \"grant_type=password\"                              \\\n " + getBlanc(28)
                + " -d \"client_id=$CLIENT_ID\"                             \\\n " + getBlanc(28)
                + " -d \"client_secret=$SECRET_ID\" `                       \n "   ;

        String _token = " ACCESS_TOKEN=`echo $KEYCLOAK_RESPONSE | "                           +
                         "sed 's/.*access_token\":\"//g' | sed 's/\".*//g'` "                 ;

        String invokeService = " curl -G " + trustCertUrl + "-H \"Accept: " + accept + "\" "  +
                               " -H \"Authorization: Bearer $ACCESS_TOKEN\" "                 ;

        if (keep != null && !keep.isEmpty())                {
            invokeService += " -H \"Keep: " + keep + " \" " ;
        }

        invokeService += _params + "\"" + _url + "\" "      ;

        return "# !/bin/bash" + "\n\n" + "# Script generated by JAXY-CLIENT \n" + "# Author : ---    \n\n\n " +
               " KEYCLOAKURL='" + keyCloakUrl + "'\n" + " USER_NAME='USERNAME'             \n"                +
               " PASSWORD='PASSWORD'              \n" + " CLIENT_ID='CLIENT_ID'            \n"                +
               " SECRET_ID='SECRET_ID'            \n\n\n " + " # INVOKE KEYCLOAD ENDPOINT       \n "          +
               KEYCLOAK_RESPONSE                                                                              + 
               "\n\n " + " # PARSE TOKEN FROM RESPONSE      \n "                                              + 
               _token                                                                                         +
               "                         \n\n " + "# INVOKE THE WEB SERVICE          \n " + invokeService     ;
    }
    
    protected static String generateScriptPUBLIC ( String url     ,
                                                   String params  , 
                                                   String keep    ,
                                                   String accept  ) throws UnsupportedEncodingException {
        
        String _url          = url.trim()                                                  ;

        String _params       = splitParamsToDataUrlEncoder(params)                         ;
        
        
        String trustCert     = _url.trim().startsWith("https") ? " -k " : " "              ;

        String invokeService = " curl -G " + trustCert + "-H \"Accept: " + accept + "\"  " ;

        if (keep != null && !keep.isEmpty() ) { 
            invokeService += " -H \"Keep: " + keep + " \" "                                ;
        }

        return "#!/bin/bash \n\n" + " # Script generated by JAXY-CLIENT \n"                +
               " # Author    : ---                  \n\n\n" + invokeService                +
               _params + "\"" + _url.replaceAll(" ", "%20") +  "\""                        ;
    }
    
    protected static String generateScriptDecryptor( String url           , 
                                                     String login         , 
                                                     String password      ,
                                                     String params        ,
                                                     String keep          ,
                                                     String accept        , 
                                                     String hashLogin     ,
                                                     String hashPassword  ,
                                                     String hashTimeStamp , 
                                                     String algoSign      , 
                                                     String cipher        , 
                                                     String security      ) throws UnsupportedEncodingException {

        if (cipher != null && !cipher.trim().equalsIgnoreCase("-")) {

            /** Hash_256 is Always Used tu Calculate the Key . */
            /** Hash_256 gives 64 characters . */
            /** Divide per 4 because of HEX  . */
            
            int LENGHT_KEY = Integer.parseInt(cipher.replaceAll("[^0-9]", "")) / 4 ;
            
            String ALGO_NAME_FOR_OPENSSL = getAlgoNameForSSL(cipher)               ;

            return  "#!/bin/bash \n\n"                                             + 
                    " # Script generated by JAXY-CLIENT \n"                        +
                    " # Author    : ---               \n\n"                        + 
                    " cmd_example()  {                  \n "                       +
                    "     echo                          \n "                       +
                    "     echo \" Example :  \"         \n "                       +
                    "     echo \" ./jaxy_decryptor.sh "                            +
                                    "file=my_encrypted_file "                      +
                                    "password=my_password \" ; "                   +
                    "     echo                                              \n"    +
                    " }                                                   \n\n"    +
                    " while [[ \"$#\" > \"0\" ]] ; do\n"                           +
                    "  \n"                                                         +
                    "     case $1 in \n"                                           +
                    "         (*=*) KEY=${1%%=*} \n"                               +
                    "               VALUE=${1#*=} \n"                              +
                    "               case \"$KEY\" in \n"                           +
                    "                    (\"password\")        PASSWORD=$VALUE \n" +
                    "                    ;;                    \n"                 +
                    "                    (\"file\")     FILE=$VALUE \n"            +
                    "               esac\n"                                        +
                    "	     ;;\n"                                                 +
                    "         help)  echo       \n"                                +
                    "                echo \" Total Arguments : Two \"\n"           +
                    "                echo \n" +
                    "                echo \"   file=     : file path to decrypt    \"\n" +
                    "                echo \"   password=  : decryption password    \"\n" +
                    "                echo                                          \n"   +
                    "                exit;                                         \n"   +
                    "     esac                                                     \n"   +
                    "     shift                                                    \n"   +
                    "  done \n\n"                                                        + 
                    "  if [ -z \"$FILE\" ] ; then  \n"                                   +
                    "    echo ; echo \" file can't be empty ! \" \n"                     +
                    "    cmd_example ; exit ;  \n"                                       +
                    "  fi \n"                                                            +
                    "  if [ -z \"$PASSWORD\" ] ; then  \n"                               +
                    "    echo ; echo \" password can't be empty ! \" \n"                 +
                    "    cmd_example ; exit ; \n"                                        +
                    "  fi \n\n"                                                          +
                    " file=\"$FILE\"          \n\n"                                      +
                    " Password=\"$PASSWORD\"  \n\n"                                      +
                    getHashedScript("Password", hashPassword) + "\n\n"                   +
                    " KEY=` echo -n $Hashed_Password | sha256sum  | cut -d ' ' -f 1 | cut -c1-" + LENGHT_KEY +
                    " ` \n\n"                                                                                +
                    (ALGO_NAME_FOR_OPENSSL.contains("cbc")
                            ? " # Split the KEY and DATA into two files : jaxy_data_1 ; jaxy_data_2 \n"                   +
                                    " # jaxy_data_1 : Contains the KEY\n" + " # jaxy_data_2 : Contains the DATA \n\n"     +
                                    " awk '{ print > \"jaxy_data_\"++i }' RS='.' $file \n\n"                              +
                                    " IV=` openssl enc -d -base64 -in jaxy_data_1 | xxd -ps -c 200 | tr -d '\\n'` ; \n\n" +
                                    " openssl " + ALGO_NAME_FOR_OPENSSL                                                   +
                                    " -A -d -base64 -K \"$KEY\" -nosalt -in jaxy_data_2 -iv \"$IV\" \n\n"                 +
                                    " # Remove jaxy_data_1 jaxy_data_2 \n" + " rm  jaxy_data_1 \n"                        +
                                    " rm  jaxy_data_2 \n"

                            : " openssl " + ALGO_NAME_FOR_OPENSSL + " -A -d -base64 -K \"$KEY\" -nosalt -in $file ")      ;
        }
        
        return ""  ;
    }      
      
    protected static String generateClientConfig( String url           ,
                                                  String urlKeycloak   ,
                                                  String params        ,
                                                  String keep          ,
                                                  String accept        ,
                                                  String security      ,
                                                  String algoSign      ,
                                                  String hashLogin     , 
                                                  String hashPassword  ,
                                                  String hashTimeStamp ,
                                                  String signature     ,
                                                  String cipher        ) throws UnsupportedEncodingException {

        return "\n\n ## Dwonload jaxyClient.jar + jaxy_conf.txt    \n\n"                    + 
               " ## Run the command : java -jar jaxyClient.jar confPath jaxy_conf.txt \n\n" + 
               " ## And follow the instructions by running jaxyClient.jar ...  \n\n"        + 
               
               ( ( security != null && 
                   security.equalsIgnoreCase("CustomSignOn")  ) ? 
               ( " ## Signature : "  + signature  + "\n\n"  ) : "" )            + 
                
               "\n\n Url                   = "  + url       + "\n\n"            + 
                 " Security              = "  + security    + "\n\n"            + 
               ( ( urlKeycloak != null ) ? 
               ( " UrlKeycloak           = "  + urlKeycloak + "\n\n" ) : "" )   + 
              
                 " Params                = "  + params      + "\n\n"            + 
                 " Accept                = "  + accept      + "\n\n"            +
               
               ( ( accept != null && 
                   accept.trim().toLowerCase().contains("encrypted")  ) ? 
               ( " Cipher                = "  + cipher      + "\n\n"  ) : "" )  + 
                
                 " Keep                  = "  + keep        + "\n\n"            +
                
               ( ( security != null && 
                   security.equalsIgnoreCase("CustomSignOn")  ) ? 
               ( " AlgoSign              = "  + algoSign    + "\n\n"  ) : "" )  + 
                
               ( ( security != null && 
                   security.equalsIgnoreCase("CustomSignOn")  ) ? 
               ( " HashLoginAlgo         = "  + hashLogin  + "\n\n"  ) : "" )   + 
                
               ( ( security != null && 
                   security.equalsIgnoreCase("CustomSignOn")  ) ? 
               ( " HashPasswordAlgo      = " + hashPassword  + "\n\n"  ) : "" ) + 
               ( ( security != null && 
                   security.equalsIgnoreCase("CustomSignOn")  ) ? 
               ( " HashTimeStampAlgo     = " + hashTimeStamp + "\n\n"  ) : "" ) ; 
                
    }
     
    private static String getAlgoNameForSSL(String cipher)             {

        Objects.requireNonNull(cipher)                                 ;
        String ciph = cipher.trim().replace("_", "-").toLowerCase()    ;
        
        if (ciph.startsWith("des"))                                    {
            ciph = ciph.replaceAll("\\d", "").replace("--", "-")       ;
        }
        
        if (ciph.contains("ede"))                                      {
            ciph = ciph.replaceAll("ede", "-ede3").replace("-ecb", "") ;
        }

        return ciph ;
    }

    private static String getHashedScript(String variable, String algo ) {

        if (algo.equalsIgnoreCase("SHA1"))              {
            
            return " Hashed_" + variable.trim()         +
                   "=` echo -n $" + variable.trim()     +
                   " | sha1sum  | cut -d ' ' -f 1 ` \n" +
                   " Hashed_" + variable.trim()         +
                   "=` echo $Hashed_"                   +
                   variable.trim() + " | sed 's/^0*//'`";
        }
        
        if (algo.equalsIgnoreCase("SHA2")) {
            
            return " Hashed_" + variable.trim() + "=` echo -n $"     + 
                   variable.trim()                                   +
                   " | sha256sum  | cut -d ' ' -f 1 ` \n"            +
                   " Hashed_" + variable.trim() + "=` echo $Hashed_" +
                    variable.trim() + " | sed 's/^0*//'`"            ;
            
        } else if (algo.equalsIgnoreCase("MD5")) {
            return " Hashed_" + variable.trim()  + "=` echo -n $"       + 
                   variable.trim() + " | md5sum  | cut -d ' ' -f 1` \n" +
                   " Hashed_" + variable.trim() + "=` echo $Hashed_"    + 
                   variable.trim() + " | sed 's/^0*//'`"                ;
        }

        return " Hashed_" + variable.trim() + "=\"$" +
               variable.trim() + "\""                ;
    }

    private static String getSigneScript(String algo) {

        if (algo.equalsIgnoreCase("SHA1")) {
            return " SIGNE=`echo -n $Hashed_Login$Hashed_Password$Hashed_TimeStamp"                   +
                   " | sha1sum  | cut -d ' ' -f 1 ` \n" + " SIGNE=` echo $SIGNE | sed 's/^0*//' ` "   ;
        }
        if (algo.equalsIgnoreCase("SHA2")) {
            
            return " SIGNE=`echo -n $Hashed_Login$Hashed_Password$Hashed_TimeStamp"                   +
                   " | sha256sum  | cut -d ' ' -f 1 ` \n" + " SIGNE=` echo $SIGNE | sed 's/^0*//' ` " ;
        }
        
        else if (algo.equalsIgnoreCase("MD5")) {
       
            return " SIGNE=`echo -n $Hashed_Login$Hashed_Password$Hashed_TimeStamp "                  +
                   "| md5sum  | cut -d ' ' -f 1 ` \n" + " SIGNE=` echo $SIGNE | sed 's/^0*//' ` "     ;
        }
        
        return " SIGNE=`echo -n $Hashed_Login$Hashed_Password$Hashed_TimeStamp ` "                    ;
    }

    private static String splitParamsToDataUrlEncoder( String params ) {
        
       if ( params != null &&  ! params.isEmpty() )            {
            
           params = params.trim()                              ;
            
           return Stream.of( params.split("&"))
                        .map( param ->  " --data-urlencode \"" +
                                        param.trim()   + "\""  )
                        .collect(Collectors.joining()) + " "   ;
       }
        
       return ""  ;
    } 
    
    private static String getBlanc(int nbr)             {
        
      return  IntStream.range( 0, nbr )
                       .mapToObj( i -> " " )
                       .collect( Collectors.joining() ) ;
    }
       
}

