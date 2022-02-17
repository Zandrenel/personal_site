import subprocess, sys


mode = sys.argv[1]

path = sys.argv[2]


if mode == 'engine':
    query = sys.argv[3]

    subprocess.call(['python','{}/cli_querier.py'.format(path), path, query])
    
