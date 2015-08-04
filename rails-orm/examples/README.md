# Install rails

gem install rails
sudo apt-get install nodejs

# Starting

rails s -b 0.0.0.0

192.168.33.10:3000

# Configure MySQL

# Setting up VividCortex

# Running tests

## MySQL - N+1 Queries

https://github.com/basecamp/marginalia

https://vividcortex.com/docs/top-queries/

bash tests/n1-queries.sh

https://app.vividcortex.com/VividCortex/breaking-databases/queries/5d16a30eea5651e0?tab=Details&from=1438371533&until=1438372176&difference=3600&hosts=&tag=

https://app.vividcortex.com/VividCortex/breaking-databases/queries/46bfcc01ca119b81?tab=Details&from=1438372181&until=1438372560&difference=3600&hosts=&tag=

## MySQL - Use caching

`ab -c 5 -t 900 http://192.168.33.10:3000/mysql-caching/before`

`ab -c 5 -t 900 http://192.168.33.10:3000/mysql-caching/after`
