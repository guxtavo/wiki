# Education is a too important topic these days

Create a "lesson editor" for the cli to empower a community to create
lessons of any kind that can be consumed in the cli, web and mobile
apps.

The lessons are composed of 2 parts

  lesson   quiz(es)
   /       /
 +---+   +---+
 | 1 |   | 2 |            lessons 1-N quizzes
 +---+   +---+

The lesson editor should be able to capture the first part (the lesson
itself) using script(8). The lesson can also be a video or an image.
The second part is the quiz (or quizzes if your lesson has more than
one).

The lesson should contain some metadata information like:

    * language
    * course name
    * course summary
    * topic/section
    * lesson file type (script, video or image)
    * name of the lesson file
    * number of quizzes in the lesson

The quiz structure is ennunciate and options. The ennunciate can be
text, video or image. The options are one per line, and the first one
should be the correct one. The minimum number of options should be 5
(including the correct one). We would like to see a big number here, but
there are style concerns yet to be discussed.

After removing the first line from options (the correct one), the rest
goes trough a random sort and 2 more are selected to go with the correct
one to be displayed to the user.

Describe how the "lesson editor" should store the data.

# The whole system

I want to have a take at online education. I'm humbled by Duolingo, Khan
Academy, Youtube and Sololearn (to name a few). I want the help of the
community to help teaching Linux, git, shell, python, anything! I want
to achieve this by:

    * create the "lesson editor"
    * create the endpoint the "lesson editor" will send data to
    * make some marketing asking people to contribute by creating
      lessons
    * manually sort thought the lessons and organize the courses
    * create the "course enroll" -> or moodle
    * create the "course player" -> or moodle
    * create a way of allowing external trainners to support a class


Hi, I created a "lesson editor" and a webservice to receive this data
and I want your help making this Open Source project a success. If you
love Linux, git, shell, python or anything related to it, and you have
some knowledge to share, download my app now and start creating your
lessons for those courses

Users can enroll to courses and take classes and quizzes.
