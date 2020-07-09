# Twogether Project overview
========================
## Welcome 
In this project, we'll be building a project collaboration app that lets users work together on multiple shared projects. If you want your team to be more productive and motivated, Twogether is here for you and helps users to manage tasks, projects and team work.
 - -
## General information
- In the main directory, you've got a Gemfile that gives you access to activerecord, pry, rake, sqlite3,tty-prompt, and json,  etc. Always keep them in Gemfile.
- In the `bin` directory, you've got a run.rb file that you can run from the command line with ruby bin/run.rb.
- In config, you've got your database set up with Active Record, as well as all of the models from the `lib` folder made available to your database.
- In db/migrate, you've got a convenient way to alter your database schema over time in a consistent and easy way.
- In Rakefile, you've got some rake tasks, specific to this application
- In the lib/app/models directory, you get all models you need, Project, User, Task, Ownership, Collaboration : A user can have many projects. A project can have many users collaborating on it. A project has many tasks. A specific task belongs to only one project, and each task only belongs to one user.

> To get started… :partying_face:

## Installation
-Fork this repo or clone it to you local machine using 
https://github.com/vuonga1103/ruby-project-alt-guidelines-nyc04-seng-ft-053120

- First run the following command in your terminal to install the dependencies required for this project
bundle install

- You might need running migration, it will update your db/schema.rb file to match the structure of your database.
rake db:migrate

- Run run.rb file from command line so you'll see the login page .
ruby bin/run.rb

> Yay! Now let's explore…

## Feature
 Please check out Anh's Project Demo Video at this link! 
[![Alt text for Demo video](https://youtu.be/sGMvnoqvHrc?t=4.png)](https://www.youtube.com/watch?v=sGMvnoqvHrc)
* Login page: It displays choices for login or register, and also displays a random inspirational quote to the user every time when they are in this page. (`Rest-client`, a ready-made tools will allows you to structure the requests to access Random Quote API )
![Login Page](https://cdn-images-1.medium.com/max/1600/1*w5A7ZpCoWtACu-iTCgcXjg.png)
* Main menu: User'll see many options let them choose, each option will call a function that will leads user to a new page. And do you remember in login page asked users type in a valid username and valid password? `TTY::Prompt` let all the magic happens! The method `prompt.ask` for username, `prompt.mask` for password, `prompt.select` and create menu with choices.
![Main Menu](https://cdn-images-1.medium.com/max/1600/1*wB7_WfLPUbBRXsi021jXPA.png)
* Project and Task Page: User can create a new project and create new task, And User with user's team members also can collaborate on an existing project. The task's date format is very important for page looks tidy, `Date.strptime` parses the given representation of date and time with the given template, and creates a date object. 
![Project And task page](https://cdn-images-1.medium.com/max/1600/1*bA7hYZeW62YifysQ_vXSUw.png)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate.