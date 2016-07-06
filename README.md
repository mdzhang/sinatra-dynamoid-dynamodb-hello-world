# sinatra-dynamoid-dynamodb-hello-world

A simple Hello World app that connects [Sinatra](sinatrarb.com) to [DynamoDB](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html) using [Dynamoid](https://github.com/Dynamoid/Dynamoid)

## Installation


### OS X

- install [brew](http://brew.sh/#install)

    ```
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```

- checkout project

    ```
    cd ~/Code
    git clone git@github.com:mdzhang/sinatra-dynamoid-dynamodb-hello-world.git
    cd sinatra-dynamoid-dynamodb-hello-world
    cp config/environment/sample.yml config/environment/development.yml
    ```

- configure application

    ```
    brew install rbenv
    rbenv install $(cat ./.ruby-version)
    rbenv global $(cat ./.ruby-version)
    gem update --system
    gem install bundler
    rbenv rehash
    bundle install
    ```

- configure and start database

    ```
    # see http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html
    mkdir -p ~/tmp/dynamodb
    cd ~/tmp/dynamodb
    wget http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.zip
    unzip dynamodb_local_latest.zip

    # start dynamodb
    java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb
    ```

- run app

    ```
    bundle exec rake run_app_locally
    ```

- view app

    ```
    open localhost:4567
    ```

    - I'm just using [postman](http://www.getpostman.com/) to interact with the endpoints

- view local DynamoDB contents

    ```
    brew tap caskroom/cask
    brew cask install sqlitebrowser
    open /Applications/sqlitebrowser.app/
    # click "Open Directory"
    # choose ~/tmp/dynamodb/shared-local-instance.db
    # name of table should be "dynamoid_app_development_stockkeepingunits"
    # et voila
    ```

#### Versions

This repo is known to work with

- ruby 2.3.1
- rbenv 1.0.0
- Homebrew 0.9.9
- sqlitebrowser 3.8.0
- DynamoDB Local 1.0
- OS X El Capitan 10.11.5


### OS X using Docker

- install [brew](http://brew.sh/#install)

    ```
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```

- install docker

    ```
    brew tap caskroom/cask
    brew cask install virtualbox
    brew cask install dockertoolbox
    ```

- configure docker

    ```
    echo 'eval "$(docker-machine env)"' >> $HOME/.bashrc
    # switch this to e.g. .bash_exports if you prefer
    echo 'export DOCKER_HOST_IP=$(docker-machine ip $(docker-machine active));' >> $HOME/.bashrc
    bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'
    source  $HOME/.bashrc
    ```

- checkout project

    ```
    cd ~/Code
    git clone git@github.com:mdzhang/sinatra-dynamoid-dynamodb-hello-world.git
    cd sinatra-dynamoid-dynamodb-hello-world
    cp config/environment/sample.yml config/environment/development.yml
    ```

- run project

    ```
    source docker/pre_docker_compose.sh && docker-compose up -d

    # or, if you already have ruby/rbenv/bundler installed
    bundle exec rake run_app_docker
    ```

- view app

    ```
    http://$DOCKER_HOST_IP:4567
    ```

    - I'm just using [postman](http://www.getpostman.com/) to interact with the endpoints

- stop app

    ```
    docker-compose down
    ```

#### Versions

This repo is known to work with

- Homebrew 0.9.9
- docker 1.11.1
- docker-machine 0.7.0
- docker-compose 1.7.1
- OS X El Capitan 10.11.5