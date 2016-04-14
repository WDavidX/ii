* Notes for bash shell scripting

** Commands to learn
- *tee*
- *select* loop

** Tests and options

*** File tests

#+begin_src shell
test option file
# or
[ option file ]
#+end_src

|-------------+------------------------------------------------------|
| option      | Description                                          |
|-------------+------------------------------------------------------|
| -d pathanme | True if pathanme exists and is a directory           |
| -e pathname | True if the file or directory specified exists       |
| -f pathname | True if the file is a regular file                   |
| -r pathname | True if the file or directory exists and if readable |
| -w pathname | True if the file or directory exists and is writable |
|-------------+------------------------------------------------------|

*** String test

|-----------+-------------------------------------+---+---+---|
| option    | Description                         |   |   |   |
|-----------+-------------------------------------+---+---+---|
| -z string | True if string is empty             |   |   |   |
| -n string | True if string has non-zero size    |   |   |   |
| string    | True if string is NOT null (" ")    |   |   |   |
| s1 = s2   | True if string s1 equals s2         |   |   |   |
| s1 != s2  | True if string s1 does not equal s2 |   |   |   |
|-----------+-------------------------------------+---+---+---|


*** Debug settings

#+begin_src shell
set [option]
#+end_src

|--------+-------------------+-----------------------------------------------------|
| option | Name              | Description                                         |
|--------+-------------------+-----------------------------------------------------|
| -n     | No execution      | Read all commands, do syntax check only             |
| -v     | Verbose           | Display all ines as they are read                   |
| -x     | Executation Trace | Display commands and their arguments, shell tracing |
|--------+-------------------+-----------------------------------------------------|

