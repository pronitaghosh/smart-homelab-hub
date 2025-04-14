# Shell functions and aliases to navigate Smart Servers


functions start_firefly()
{
    # cd firefly
    if [ $(basename $PWD) != 'firefly' ]; then
        cd firefly
    fi
    docker compose -f docker-compose-firefly.yml up -d 
}

functions stop_firefly()
{
    # cd firefly
    docker compose -f docker-compose-firefly.yml down
    # docker volume prune
    # docker volume rm $(docker volume ls -qf dangling=true)

}

functions start_jelly()
{
    cd jellyfin
    docker compose -f docker-compose-jellyfin.yml up -d
}

functions stop_jellyfin()
{
    cd jellyfin
    docker compose -f docker-compose-jellyfin.yml down
    docker volumes prune
}
