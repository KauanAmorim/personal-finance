docker run --name personal-postgre --rm -d -p 5432:5432 --mount type=volume,source=ersonal-postgresql-volume,target=/var/lib/postgresql/data nauakavlis/my-personal-postgre-config
