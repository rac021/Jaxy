#!/bin/bash
 
  DATABASE="aero"
  
  # The USER which is used by Jax-Y
  DB_USER_CONNECTION="jaxy_user"
  DB_PASSWORD_CONNECTION="jaxy_password"
 
  PSQL_CONNECT="postgres"
 
  TABLE_NAME_AUTHENTICATION="users"
  
  LOGIN_COLUMN_NAME="login"
  PASSWORD_COLUMN_NAME="password"
  STORAGE_PASSWORD_ALGO="MD5"
  
  ## Users Example
  #### User One  
  USER_ONE_LOGIN="admin"
  USER_ONE_PASSWORD="admin"
  #### User Two 
  USER_TWO_LOGIN="public"
  USER_TWO_PASSWORD="public"
    
  TABLE_NAME_EXAMPLE="aircraft"
    
  LOG="$1" # $1 = DISPLAY ( to enable logs )
  
  #################################################
  ### PROCESSOR ###################################
  #################################################

  if [  "$STORAGE_PASSWORD_ALGO" == "MD5" ] ; then 
  
     USER_ONE_HASHED_PASS=`  echo -n $USER_ONE_PASSWORD  | md5sum  | cut -d ' ' -f 1` 
     USER_TWO_HASHED_PASS=` echo -n $USER_TWO_PASSWORD | md5sum  | cut -d ' ' -f 1` 
     
  elif [  "$STORAGE_PASSWORD_ALGO" == "SHA2" ] ; then 
  
    USER_ONE_HASHED_PASS=`  echo -n $USER_ONE_PASSWORD  | sha256sum  | cut -d ' ' -f 1 ` 
    USER_TWO_HASHED_PASS=` echo -n $USER_TWO_PASSWORD | sha256sum  | cut -d ' ' -f 1 ` 
    
  else  # PLAIN_STORAGE 
  
    USER_ONE_HASHED_PASS="$USER_ONE_PASSWORD"
    USER_TWO_HASHED_PASS="$USER_TWO_PASSWORD"
  
  fi
  
  tput setaf 2
  echo 
  echo -e " ####################################################       "
  echo -e " ################ Create DataBase ###################       "
  echo -e " ----------------------------------------------------       "
  echo -e " \e[90m$0        \e[32m                                     "
  echo 
  echo -e " ##  DATABASE                  : $DATABASE                  "
  echo -e " ##  TABLE_NAME_AUTHENTICATION : $TABLE_NAME_AUTHENTICATION "
  echo -e " ##  STORAGE_PASSWORD_ALGO     : $STORAGE_PASSWORD_ALGO     "
  echo  
  echo -e " ##  DB_USER_CONNECTION        : $DB_USER_CONNECTION        "
  echo -e " ##  DB_PASSWORD_CONNECTION    : $DB_PASSWORD_CONNECTION    "
  echo
  echo -e " ##  USER_ONE_LOGIN            : $USER_ONE_LOGIN            "
  echo -e " ##  USER_ONE_PASSWORD         : $USER_ONE_PASSWORD         "
  echo -e " ##  USER_ONE_HASHED_PASS      : $USER_ONE_HASHED_PASS      "
  echo
  echo -e " ##  USER_TWO_LOGIN            : $USER_TWO_LOGIN            "
  echo -e " ##  USER_TWO_PASSWORD         : $USER_TWO_PASSWORD         "
  echo -e " ##  USER_TWO_HASHED_PASS      : $USER_TWO_HASHED_PASS      "
  echo
  echo -e " ##  TABLE_NAME_EXAMPLE :      : $TABLE_NAME_EXAMPLE        "
  echo
  echo -e " ####################################################       "
  echo 
  
  sleep 0.5
  
  tput setaf 7

  if which psql > /dev/null ; then
     echo " postgres command OK ..   "  
  else     
     echo " postgres command NOT FOUND  "
     echo " Script will abort           "
     exit 
  fi
  
  echo 
  
  if [ "$LOG" == "display" -o "$LOG" == "DISPLAY" ] ; then 
     LOG=""
  else 
     LOG=' 2> /dev/null '
  fi
   
  COMMAND=" sudo -u $PSQL_CONNECT psql $LOG "

  eval $COMMAND  << EOF
  
  DROP  DATABASE $DATABASE ;
  DROP  USER     $DB_USER_CONNECTION  ;
 
  CREATE DATABASE $DATABASE TEMPLATE template0 ; 
  CREATE USER $DB_USER_CONNECTION WITH PASSWORD '$DB_PASSWORD_CONNECTION'  ;
  
  \connect $DATABASE ;  
  
  -- Create Table for Authentication 
   
  CREATE TABLE $TABLE_NAME_AUTHENTICATION ( $LOGIN_COLUMN_NAME     varchar(255) ,
                             $PASSWORD_COLUMN_NAME  varchar(255) ,
	                     CONSTRAINT pk_users PRIMARY KEY ( login )
  
  ) ;

  INSERT INTO $TABLE_NAME_AUTHENTICATION VALUES ( '$USER_ONE_LOGIN' , '$USER_ONE_HASHED_PASS' ) ; -- HASHED password 
  INSERT INTO $TABLE_NAME_AUTHENTICATION VALUES ( '$USER_TWO_LOGIN' , '$USER_TWO_HASHED_PASS' ) ; -- HASHED password 
  
  GRANT SELECT ON $TABLE_NAME_AUTHENTICATION to $DB_USER_CONNECTION ;
  
  
  
    CREATE TABLE $TABLE_NAME_EXAMPLE ( model            varchar(255) ,
                                       total_passengers integer      ,
                                       distance_km      integer      , 
                                       speed_km_h       integer      ,
                                       cost_euro        integer      ,

                                       CONSTRAINT pk_aircraft PRIMARY KEY ( model )
  ) ;
  -- Source http://avions.findthebest.fr
  
  INSERT INTO aircraft VALUES ( 'Tupolev TU-414A'             , 26   , 15575 , 900  , 17  ) ;
  INSERT INTO aircraft VALUES ( 'Sukhoi SU-27UBK'             , 0    , 13401 , 1400 , 23  ) ;
  INSERT INTO aircraft VALUES ( 'Airbus ACJ319'               , 156  , 1112  , 828  , 37  ) ;
  INSERT INTO aircraft VALUES ( 'Gulfstream G650'             , 18   , 12964 , 904  , 44  ) ;
  INSERT INTO aircraft VALUES ( 'Bombardier Global 8000'      , 19   , 14631 , 904  , 58  ) ;
  INSERT INTO aircraft VALUES ( 'Boeing 787-9 Dreamliner'     , 2902 , 15742 , 945  , 140 ) ;
  INSERT INTO aircraft VALUES ( 'Boeing 777-200LR Worldliner' , 301  , 17400 , 945  , 171 ) ;
  INSERT INTO aircraft VALUES ( 'Airbus A340-500'             , 375  , 16668 , 907  , 203 ) ;
  INSERT INTO aircraft VALUES ( 'Boeing 747-400ER'            , 524  , 14205 , 1093 , 207 ) ;
  INSERT INTO aircraft VALUES ( 'Boeing 747-8'                , 700  , 14816 , 1043 , 212 ) ;
  
  GRANT SELECT ON $TABLE_NAME_EXAMPLE to $DB_USER_CONNECTION ;  
  
EOF

echo

