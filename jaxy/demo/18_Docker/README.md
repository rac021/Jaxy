

docker run -e POSTGRES_PASSWORD=jaxy -v jaxy_db.sql:/docker-entrypoint-initdb.d/ postgres:9.6.11-alpine
