# based on https://forum.vertica.com/discussion/240047/segfault-in-libverticaodbc-through-pyodbc
import pyodbc
import sys

def nest(depth, kallable, *args, **kwargs):
    """build a bunch of useless stack frames"""
    if depth <= 0:
        print(kallable, args, kwargs)
        return kallable(*args, **kwargs)
    return nest(depth - 1, kallable, *args, **kwargs)

def test_raw(num):
    conn = nest(num, pyodbc.connect, 'DSN=Vertica;UID=dbadmin;PWD=;DATABASE=docker')
    print(conn)

if __name__ == '__main__':
    test_raw(int(sys.argv[1]))
