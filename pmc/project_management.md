# project manegement on the cli

$ pmc -dash cccd4045
# project cccd4045 dashboard - design a PM cli within 80 columns

  Planning   Development                    Launch date  | Release date
      \-----\-----\--*--\-----\               107 days      Wed, Feb 19
          Design      Testing                Wed, Nov 21     107 days

         Time Budget                          Overdue Tasks

     1. total : 17h 35min      Overdue Task              Deadline   Contributor
     2. used  : 12h 5min        1 day  create a protoype YYYY-MM-DD user1
     3. remain: 5h 30min        4 days sort data         YYYY-MM-DD user2
                               10 days find template     YYYY-MM-DD user3

        Contributors                       Upcoming deadlines

     1. user1 - 3 hours    Contributor Task             Deadline   Workload
     2. user2 - 2 hours          user1 Design interf    YYYY-MM-DD 2h 30min
     3. user3 - 45 min           user2 Define structure YYYY-MM-DD 15 min
     4. user4 - 5 min            user3 Create Schema    YYYY-MM-DD 5 min

$ pmc -n "project text" -l capcom
$ pmc -n "my prj" -l capcom
$ pmc -p cccd4045 -t "task1" -y 0 -d YYY-MM-DD -b 20
$ pmc -p 14572b66 -t "task1" -y 0 -d YYY-MM-DD -b 20
$ pmc -p cccd4045 --list
$ pmc -p cccd4045 -t 1 -e 15m "http://link"
$ pmc -p cccd4045 -a 1

# projects table

 id | project id | project text | launch date      | release date | leader id
  1   cccd4045     project text   YYYY-MM-DD HH:MM                  1
  2   14572b66     my prj         YYYY-MM-DD HH:MM                  1

# project_tasks table

 id | prj | taskid | text | creator | deadline  | creation   | budget | concluded
  1     1      0     task1        1   YYYY-MM-DD  YYYY-MM-DD   20h      0
  2     2      0     task1        1   YYYY-MM-DD  YYYY-MM-DD   10h      0

# budget table

 id | task id | creator | expense | conclusion      | result text | approved
  1         1         1   15min     YYYY-MM-DD HH:MM  http://link   0

# contributers table

 creator id | creator nick | pay rate
          1   capcom         14

# tasks table

 task id | task type
       0   Planning
       1   Design
       2   Development
       3   Testing
