# Breaking Databases

### Keeping your Ruby on Rails ORM under control

Welcome and thanks for joining me. This is a new webinar series called "Breaking Databases" where we uncover database abuse and look for solutions to stop it.

In this webinar we will focus specially on the Ruby on Rails framework and the ActiveRecord ORM using MySQL. We will be trying to replicate common Rails ORM mistakes and use VividCortex to identify them, the we will fix them, and finally measure the results.

# Don't Hate the ORM

Googling the internet for ORMs and you will find allot of articles about how bad they are. Generally speaking the authors points tend to boil down to that they are a "Leaky Abstraction" which means abstraction does not fully encapsulate the complexity and that complexity can leak out in strange and unexpected ways. Or that blinds the developer from what is really happening with the underlining database technology and encourages them to not care about really understanding it.

These are really great points and I fully agree with them. However keep in mind that an ORM is just a tool. Like any tool if you don't use it the right way you won't get the result you expect or it will cause some serious pain. When used right it results in a huge productivity boost. This is one of the reasons why Rails is so popular with startups. In this industry to call this "Worse is Better" technology. Despite Ruby being slow and the Rails Active Record ORM being a leaky abstraction it allow startups to execute on ideas quickly and get to market faster.

As you're startup begins to scale up these "Worse is Better" technology choices will eventually start to show more and more of their bad side. This is where it's going to be important that you have some deep insights into the performance of your system and be able to identify those problems. This is were a performance monitoring tool VividCortex is going to be indispensable.

For today's webinar we are going to look at these common Rails ORM problems.

# Common Rails ORM Problems

- N+1 Queries
- Missing Indexes
- Caching

To try to emulate these problems I have setup a Vagrant box with Rails 4.0, a MySQL database, and VividCortex's agent's running. Running in that box I have a simple rails up with a couple of controllers one for each of the types of problems. In each of those controllers we have two actions. One called "before" which misuses the ORM or queries the misconfigured table and one called "after" that uses the ORM correctly or calls the corrected table. I have a setup a couple of benchmark script that will run Apache ab against the before route for a given period of time, then against the after route for the same amount of time. While these benchmark scripts are running our agents will be collecting metrics about the queries the mysql app's ORM is creating. We will then inspect the results in VividCortex's UI to see the difference. I'm also making use of a library called "marginalia" that tags the queries with the controller and action. This is how we can better understand where in the application these queries came from.

Note: This are very simple examples of these types of ORM problems and the database server we are testing with does not have any significant workload going on. So the scale of these improvements will be rather small. With that said we will see measurable improvements and give you some tips on how you can use VividCortex to do the same in your infrastructure.

Enough talk let's get started. To save time I have already ran benchmarks but we will go over everything.

#N+1 Queries

N+1 Queries is a very well known and avoidable problem when using Active Record. The code in the before action looks good, but the query is going to generate multiple select statements for each user in the loop to query the email address. This is very inefficient way to query that data. Instead we want to query all of those id with a single query.

```
SELECT `emails`.* FROM `emails` WHERE `emails`.`user_id` IN (965, 966, 967, 968, 969, 970, 971, 972, 973, 974)
```

[Controller](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/controllers/mysql_n1_queries_controller.rb)

[User Model](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/models/user.rb)

[User Schema](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/db/migrate/20150731154235_create_users.rb)

[Email Model](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/models/email.rb)

[Email Schema](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/db/migrate/20150731171810_create_emails.rb)


[View Before](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/views/mysql_n1_queries/before.html.erb)

[View After](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/views/mysql_n1_queries/after.html.erb)

[Benchmark](file:///Users/owen/code/breaking-dbs/rails-orm/benchmarks/n1-queries.sh)

[Results](https://app.vividcortex.com/vividcortex/breaking-databases/top-queries?from=1438700340&until=1438701738&difference=3600&hosts=&tag=&limit=10&rankBy=time_us&rank=tags&selectedProfile=e.5d16a30eea5651e0&filter=&filterTagName=&filterTagValue=&columns=time&columns=count&columns=latency&columns=firstSeen&columns=action&columns=cpu&columns=ops&tz=null)

#Missing Indexes

[Controller](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/controllers/use_indexes_controller.rb)

[User Model](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/models/user.rb)

[Bad Prescription Model](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/models/bad_prescription.rb)

[Good Prescription Model](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/models/good_prescription.rb)

[View Before](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/views/use_indexes/before.html.erb)

[View After](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/views/use_indexes/after.html.erb)

[Benchmark](file:///Users/owen/code/breaking-dbs/rails-orm/benchmarks/use-indexes.sh)

[Results](https://app.vividcortex.com/vividcortex/breaking-databases/top-queries?from=1438706760&until=1438707535&difference=3600&hosts=&tag=&limit=10&rankBy=time_us&rank=tags&selectedProfile=action.after&filter=&filterTagName=&filterTagValue=&columns=time&columns=count&columns=latency&columns=firstSeen&columns=action&columns=cpu&columns=ops)

#Caching

[Controller](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/controllers/use_cache_controller.rb)

[User Model](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/models/user.rb)

[View Before](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/views/use_cache/before.html.erb)

[View After](file:///Users/owen/code/breaking-dbs/rails-orm/examples/mysql-app/app/views/use_cache/after.html.erb)

[Benchmark](file:///Users/owen/code/breaking-dbs/rails-orm/benchmarks/use-cache.sh)

Bad Query Example

```
SELECT  `bad_prescriptions`.* FROM `bad_prescriptions` INNER JOIN `users` ON `users`.`id` = `bad_prescriptions`.`user_id` WHERE `bad_prescriptions`.`id` = ? LIMIT 1
```

[Results](https://app.vividcortex.com/vividcortex/breaking-databases/top-queries?from=1438705539&until=1438706035&difference=3600&hosts=&tag=&limit=10&rankBy=tput&rank=tags&selectedProfile=controller.mysql_n1_queries&filter=&filterTagName=&filterTagValue=&columns=time&columns=count&columns=latency&columns=firstSeen&columns=action&columns=cpu&columns=ops&tz=null)
