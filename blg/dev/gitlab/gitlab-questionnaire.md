Support Engineer Take-home Assessment

Important: While working on this assessment, you can consult external
sources, but you must cite them. We are looking for answers in your own
words.

1. Write a Ruby or Bash script that will print usernames of all users on
a Linux system together with their home directories. Here's some example
output:
gitlab:/home/gitlab
nobody:/nonexistent

As you can see, each line is a concatenation of a username, the colon
character (:), and the home directory path for that username. Your
script should output such a line for each user on the system.

    Since I'm more comfortable with shell, I will start the first prototype
    with it:

    usernames.sh
    #!/bin/bash
    while IFS=':' read -r username _ _ _ _ home _
    do
        echo "$username":"$home"
    done < /etc/passwd

    I decided this didn't take much time so I should try ruby too,
    although I never wrote a piece of ruby before. For this one I had to
    make some google searches (please see my history in the end of this
    file).

    usernames.rb
    #!/usr/bin/ruby
    # frozen_string_literal: false

    require 'csv'
    filename = '/etc/passwd'
    CSV.foreach(filename, headers: false, :col_sep => ':') do |row|
      print row[0]
      print ':'
      puts row[5]
    end

Next, write a crontab entry that accomplishes the following:

● Runs once every hour.
● Takes the output of your above script and converts it to an MD5 hash.
● Stores the MD5 hash into the /var/log/current_users file.
● On subsequent runs, if the MD5 sum changes, it should log this change in
the /var/log/user_changes file with the message, DATE TIME
changes occurred, replacing DATE and TIME with appropriate
values.

Make sure to replace the old MD5 hash in /var/log/current_users file
with the new MD5 hash.

Both the script and crontab entry should be provided for the answer to be
complete.

    /etc/cron.hourly/cronhourly.sh
    #!/bin/bash
    if [ ! -e /var/log/current_users ]; then
        /bin/usernames.sh | md5sum > /var/log/current_users
    else
        current_users=$(/bin/usernames.sh | md5sum)
        previous_users=$(cat /var/log/current_users)
        if [ "$current_users" != "$previous_users" ]; then
            echo "$(date) changes occurred" >> /var/log/user_changes
            echo "$current_users" > /var/log/current_users
        fi
    fi

    /etc/cron.hourly/cronhourly.rb
    #!/usr/bin/ruby
    require 'open3'
    current_users = '/var/log/current_users'
    user_changes = '/var/log/user_changes'
    md5sum = '/bin/usernames.rb | md5sum'

    if File.exist?(current_users)
        output = Open3.popen3(md5sum) \
        { |stdin, stdout, stderr, wait_thr| stdout.read }
        previous = File.read(current_users)
        if output != previous
            time = Time.now
            changes = "#{time.inspect} changes ocurred"
            File.open(user_changes, 'a') { |file| file.puts "#{changes}" }
            File.open(current_users, 'w') { |file| file.write(output) }
        end
    else
        output = Open3.popen3(md5sum) \
        { |stdin, stdout, stderr, wait_thr| stdout.read }
        File.open(current_users, 'w') { |file| file.write(output) }
    end

    Then I found out about rubocop and made some fixes:

    /etc/cron.hourly/cronhourly.rb
    #!/usr/bin/ruby
    # frozen_string_literal: false

    require 'open3'
    current_users = '/var/log/current_users'
    user_changes = '/var/log/user_changes'
    md5sum = '/bin/usernames.rb | md5sum'

    output = Open3.popen3(md5sum) \
      { |_stdin, stdout, _stderr, _wait_thr| stdout.read }

    if File.exist?(current_users)
      previous = File.read(current_users)
      if output != previous
        time = Time.now
        changes = "#{time.inspect} changes ocurred"
        File.open(user_changes, 'a') { |file| file.puts changes.to_s }
        File.open(current_users, 'w') { |file| file.write(output) }
      end
    else
      File.open(current_users, 'w') { |file| file.write(output) }
    end

    There is still one problem with usernames.rb I could not fix:

    usernames.rb:4:39: C: Style/HashSyntax: Use the new Ruby 1.9 hash
    syntax.  CSV.foreach(filename, headers: false, :col_sep => ':') do |row|

    And all this rubocop playing made me see how my first cron bash
    prototype could be improved, so I did:

    /etc/cron.hourly/cronhourly.sh
    #!/bin/bash
    current_users="/var/log/current_users"
    user_changes="/var/log/user_changes"
    md5sum=$(/bin/usernames.sh | md5sum)

    if [ ! -e "$current_users" ]; then
        echo "$md5sum" > "$current_users"
    else
        previous_users=$(cat /home/gfigueira/current_users)
        if [ "$md5sum" != "$previous_users" ]; then
            echo "$(date) changes occurred" >> "$user_changes"
            echo "$md5sum" > "$current_users"
        fi
    fi

2. A user is complaining that it's taking a long time to load a page on
our web application. In your own words, write down and discuss the
possible cause(s) of the slowness. Also describe how you would begin to
troubleshoot this issue?  Keep the following information about the
environment in mind:

● The web application is written in a modern MVC web framework.
● Application data is stored in a relational database.
● All components (web application, web server, database) are running on a
single Linux box with 8GB RAM, 2 CPU cores, and SSD storage with ample
free space.
● You have root access to this Linux box.

We are interested in learning about your experience with modern web
applications, and your ability to reason about system design and
architectural trade-offs. There are no right and wrong answers to this
question. Feel free to write as much or as little as you feel is
necessary.

    I always begin troubleshooting a bug by rewriting the initial report
    with my own words. I use a simple template:

          Synopsis: page takes a long time to load on web app
          Category: not certain
       Environment: +---------------+
                    | 2 CPUS   SSD  |
                    | 8GB RAM  DB   |
                    |          ^    |
                    | WEBSERSVER    | <-------> client
                    | MVC framework |  network
                    | custom APP    |
                    +---------------+
       Description: not clear
     How-to-repeat: not clear
        How-to-fix: not clear

    As a Support Engineer we must always have in mind the "what's next".

    You are not giving me much in this hypotetical question. What I
    would ask next is what is the baseline time to load the page and the
    experienced "slow" time. Also network traces (tcpdumps) should be
    taken from client and server side. This will probably take care of
    the first two main possible causes (after an analysis is made):

        * Client problems
        * Network problems
        * Server problems
            * OS/Hardware problems
            * DB problems
            * Webserver problems
            * Framework problems
            * Custom app problems

    Future analisys will be made on all the layers unders "Server
    problems" until we can determine what component is taking the most
    time.

    > We are interested in learning about your experience with modern
    > web applications, and your ability to reason about system design
    > and architectural trade-offs.

    For every piece of software in this stack, there are debugging flags
    that can be activated or trace data can be captured.

    What also helps a lot is to try reproducing the issue if possible.
    But for this to scale there has to be some automation with images to
    quickly deploy a similar environment.

    After back and forth we could maybe gather more information until we
    could characterize the problem. A characterized problem is a problem
    half solved ;)

3. Study the Git commit graph shown below. What sequence of Git commands
could have resulted in this commit graph?

            889a8ac awesome feature     4 - 8c574a3 fourth commit
             o                          M - e047b47 Merge
            > \                         3 - 73e170d third commit
           /   >   head                 2 - 9359569 second commit
       o->o->o->o->o                    1 - e137e9b first commit
       1  2  3  M  4

    What happened here is simple. Someone commit 1 and 2 to master. From
    2 someone created a topic branch called feature-branch and that
    along with 3 were used to construct M, then from M someone created 4
    which is where the "needle" is. With that said I think I could
    reproduce this with the following sequence:

        git init

        touch README.md
        git add .
        git commit -am "first commit"
        touch usernames.rb
        git add .
        git commit -am "second commit"

        git checkout -b feature-branch
        touch cronhourly.rb
        git add .
        git commit -am "awesome feature"

        git checkout master
        touch usernames.sh
        git add .
        git commit -am "third commit"

        git merge feature-branch master

        touch cronhourly.sh
        git add .
        git commit -am "fourth commit"

        Using a test git repository and tig(8) I can verify the
        sequence:

        Gustavo Figueira o [master] fourth commit
        Gustavo Figueira M─┐ Merge branch 'feature-branch' into master
        Gustavo Figueira │ o [feature-branch] awesome feature
        Gustavo Figueira o │ third commit
        Gustavo Figueira o─┘ second commit
        Gustavo Figueira I first commit

4. GitLab has hired you to write a Git tutorial for beginners on: Using Git to
implement a new feature/change without affecting the master branch

In your own words, write a tutorial/blog explaining things in a
beginner-friendly way. Make sure to address both the "why" and "how" for
each Git command you use. Assume the audience are readers of a
well-known blog.

    BLOG: Using Git to implement a new feature/change without affecting the
    master branch - for beginners

    # TL;DR:

        $ git clone <url> && cd <dir>             1
        $ # fork the project                      2  # gitlab
        $ git remote add upstream <url-fork>      3
        $ git fetch upstream                      4
        $ git checkout -b my_topic_branch         5
        $ # implement your changes                6
        $ git add <files>                         7
        $ git commit -m "my changes"              8
        $ git push upstream                       9
        $ # create the merge request              10 # gitlab
        $ # wait for the merge                    11
        $ git checkout master                     12
        $ git pull                                13

    It is your first day at your new job and your boss asks you to fix a
    bug in the ticketing app. Your company has Gitlab Enterprise and all
    CI/CD stuff is in place. Your boss wants your peers to evaluate your
    code during the first 3 months, so you are not allowed to push
    directly to master.

    # Why? The track analogy:

                ==|==|==|==|==|==|==|==|== master
                         ==|==|=           fix1
                ==|==|=                    fix2
                               ==|==|==|== feature1
                                     ==|== feature2

                Figure 1 - different branches are possible in git

    When you create a topic branch in a repo, you have a different
    "track" where you can use as your sandbox until you get your code
    tuned for production. You can have as many tracks (branches) as you
    need. You have the opportunity to make mistakes and get your code
    reviewed by your colleagues in this branch. Imagine if all this mess
    (the several minor tweaks you make to your code that are present in
    the commit log) is recorded directly in the master branch? We don't
    want that, right?  We want a clean and concise log with all the
    changes and we want different areas (branches) where we can be
    playful and able to use squash :)

    # So what now?

    First thing we need to do is to clone the git repository localy (1),
    to have a copy we can work on. But we are not going to work on that
    copy per se, but instead we will fork (2) this project to our own
    namespace so we can make the changes there and not in the origin.

    After adding the remote (3) repository (we need this so we can push
    the code there) and fetching (4) it, we can start (5) a new topic
    branch and implement (6) our changes. We add (7) and commit (8) them
    and push them (9) to the copy on our namespace. Now we need to tell
    the maintainers of the project we have a merge request (10) and
    after some time (11) the code is merged to master (12) and you can
    pull it (13).

    # EOL

    You now know why and how to contribute to a project without messing
    with its master branch. What are you going to contribute next?

5. What is a technical book/blog you read recently that you enjoyed?
Please include a brief review of what you especially liked or didn’t
like about it.

    The last technical book I tried (didn't finish) to read was "Pro
    Git, 2nd Edition" and I enjoyed the clarity of the graphs, like this
    one in question #3. Those simple sequence graphs go a long way
    representing the data.

    I am always (for the past 3 years) reading "The C Programming
    Language, 2nd Edition" and I like that in chapter 6, structures, the
    first example is about graphics. They use an example structure with
    tag "point" and two members, x and y. Later they nest two "point"
    type structure to create a "rectangle" tag. I point this out because
    again it makes it easier to understand complex subjects when you
    can relate to the examples used.

# History - external sources I used to complete this assignment

http://www.google.com/search?q=bash%20while%20read%20separator
http://www.google.com/url?q=https://stackoverflow.com/questions/27500692/split-string-in-shell-script-while-reading-from-file&sa=U&ved=2ahUKEwi96e2L8JrrAhVMmqQKHZcyB0kQFjABegQICBAB&usg=AOvVaw0yMeBQYRxs5EJW9qw6l5-l
http://www.google.com/search?q=ruby%20how%20to%20check%20if%20a%20file%20exists
http://www.google.com/url?q=https://stackoverflow.com/questions/8590098/how-to-check-for-file-existence&sa=U&ved=2ahUKEwihmPSSo5vrAhUGmxQKHd8HDLsQFjAAegQIBRAB&usg=AOvVaw0mC3YhsAklJw0-RuBWoQ9G
https://stackoverflow.com/questions/8590098/how-to-check-for-file-existence
http://www.google.com/search?q=ruby%20how%20to%20read%20a%20csv%20file%20and%20print%20some%20fields
http://www.google.com/url?q=https://www.rubyguides.com/2018/10/parse-csv-ruby/&sa=U&ved=2ahUKEwjqp6HSo5vrAhXJ8OAKHYowByEQFjAAegQIAhAB&usg=AOvVaw1DEu5mpOfXqY9vErGRVtn3
http://www.google.com/url?q=https://ruby-doc.org/stdlib-2.6.1/libdoc/csv/rdoc/CSV.html&sa=U&ved=2ahUKEwjJwYrNupzrAhUWUBUIHSwJBX0QFjAAegQIABAB&usg=AOvVaw1XHKVdM96r3vONEhaun7YT
http://www.google.com/search?q=ruby%20CSV.foreach%20col_sep
http://www.google.com/url?q=https://tool.oschina.net/uploads/apidocs/ruby-library/libdoc/csv/rdoc/CSV.html&sa=U&ved=2ahUKEwj1mKumu5zrAhVQZxUIHS-bDZgQFjAHegQIARAB&usg=AOvVaw2Xm1MrrlNUC_x3RgWdTl_u
http://www.google.com/search?q=ruby%20check%20if%20file%20exists
http://www.google.com/url?q=https://stackoverflow.com/questions/8590098/how-to-check-for-file-existence&sa=U&ved=2ahUKEwjur_bXvpzrAhUE6aQKHSNtBCoQFjAAegQIARAB&usg=AOvVaw3hnK-jDoXDeJQ66xNI3srt
https://stackoverflow.com/questions/4897568/how-to-check-if-a-directory-file-symlink-exists-with-one-command-in-ruby
http://www.google.com/search?q=ruby%20File.noexist
http://www.google.com/url?q=https://stackoverflow.com/questions/39394204/ruby-keeps-telling-me-my-file-does-not-exist&sa=U&ved=2ahUKEwih2MrUv5zrAhWDtXEKHWxSAkAQFjAAegQIBhAB&usg=AOvVaw0F1GNZpcuesblmvr2AB3wx
http://www.google.com/search?q=ruby%20system%20output
http://www.google.com/url?q=https://stackoverflow.com/questions/690151/getting-output-of-system-calls-in-ruby&sa=U&ved=2ahUKEwj9hLO-w5zrAhXG26QKHaosAEgQFjAAegQICBAB&usg=AOvVaw2pOWn4q4p89B0tKHjcM-qp
http://www.google.com/search?q=ruby%20open3
http://www.google.com/url?q=https://docs.ruby-lang.org/en/2.0.0/Open3.html&sa=U&ved=2ahUKEwiW1fWdxJzrAhVMDuwKHVAnDdwQFjAAegQIARAB&usg=AOvVaw3Pz_0k-egVchmmemDiYFdu
https://docs.ruby-lang.org/en/2.0.0/Open3.html#method-i-popen3
http://www.google.com/search?q=rubu%20comparing%20variable
http://www.google.com/url?q=https://stackoverflow.com/questions/2062026/comparing-a-variable-against-two-different-values-in-ruby&sa=U&ved=2ahUKEwjGwPD0x5zrAhUR_KQKHfR6DwMQFjABegQICRAB&usg=AOvVaw1sQncs3R_A1IIUCWSVPD4k
http://www.google.com/search?q=ruby%20save%20contents%20of%20a%20file%20to%20a%20variable
http://www.google.com/url?q=https://stackoverflow.com/questions/3055339/read-contents-of-a-local-file-into-a-variable-in-rails&sa=U&ved=2ahUKEwjl58Gr05zrAhWRWhUIHTEoCOcQFjAAegQICRAB&usg=AOvVaw0N7qfcGiyf3InMGZZKoa62
https://github.com/koalaman/shellcheck/wiki/SC2034
https://www.rubydoc.info/gems/rubocop/RuboCop/Cop/Style/RedundantInterpolation
https://www.rubydoc.info/gems/rubocop/RuboCop/Cop/Style/FrozenStringLiteralComment
https://www.rubydoc.info/gems/rubocop/RuboCop/Cop/Style/HashSyntax
