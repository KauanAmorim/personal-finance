![alt text](image.png)


# Start

1. docker volume create personal-postgresql-volume 
2. docker run --name personal-postgre --rm -d -p 5432:5432 --mount type=volume,source=personal-postgresql-volume,target=/var/lib/postgresql/data nauakavlis/my-personal-postgre-config
3. docker exec -i personal-postgre psql -U postgres < personal_finance_structure.sql
4. backup -> /var/lib/postgresql/data

# Doing Backup

backup -> docker exec -t personal-postgresql pg_dump -U postgres personal_finance > backup_financeiro_$(date +%Y%m%d).sql
restore -> cat backup_financeiro_20260310.sql | docker exec -i personal-postgresql psql -U postgres -d personal_finance

Obs: docker exec foi necessário para não usar o bind de arquivos e somente executar o arquivo .sql
