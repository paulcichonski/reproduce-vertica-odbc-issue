Reproduces the issue described
[here](https://forum.vertica.com/discussion/240047/segfault-in-libverticaodbc-through-pyodbc).

Tested on Docker for Mac `2.0.0.0-mac81 (29211)`

To run:

```bash
docker-compose build --pull
docker-compose pull

# bring up vertica, watch logs and wait for db to finish initializing, takes a few minutes
docker-compose up -d vertica

# get shell into container (running from docker-compose sometimes truncates logs with segfault)
docker-compose run --entrypoint=bash reproduce -c bash

# allow core dump
$ ulimit -c unlimited

# run reproducer, replace <nest_num> with an int
$ python reproduce.py <nest_num>

# example: this _should_ cause the segfault, core dump will be at /opt/app/core:
$ python reproduce.py 50
```

Change the `<nest_num>` argument to increase the call stack. A short call stack
will not produce the segfault, but a high call stack will. In my tests, a
call stack over 50 normally caused the segfault, but it may change depending
on machine.
