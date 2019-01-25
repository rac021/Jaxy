
  DROP  DATABASE aviation  ;
  DROP  USER     jaxy_user ;
 
  CREATE DATABASE aviation  TEMPLATE       template0 ; 
  CREATE USER     jaxy_user WITH PASSWORD 'jaxy_password'  ;
  
  -- Create Table for Authentication 
   
  CREATE TABLE users  ( login     varchar(255) ,
                        password  varchar(255) ,
	                CONSTRAINT pk_users PRIMARY KEY ( login )
  
  ) ;

  -- PASSWORD STORED IN MD5 Mode 
  
  INSERT INTO users VALUES ( 'admin'  , '21232f297a57a5a743894a0e4a801fc3' ) ; -- HASHED password 
  INSERT INTO users VALUES ( 'public' , '4c9184f37cff01bcdc32dc486ec36961' ) ; -- HASHED password 
  
  GRANT SELECT ON users to jaxy_user  ;
  
  
  
  CREATE TABLE aircraft ( model            varchar(255) ,
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
  
  GRANT SELECT ON aircraft to jaxy_user ;  

