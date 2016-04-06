#!/usr/bin/env python

'''Python 2 Program Template

This program does something.

# Author            :
# Project           :
# Date created      : YYYY-MM-DD
# Purpose           :
# Description       :
#
# Parameters        :
#
# Date(YYYYMMDD)        Author          Ref    Revision (Date in  format)
# 2001-01-01            David           1      Initial
'''

from time import time, localtime, strftime
import os
import sys
import argparse
import logging

# import visa
# import numpy as np
# import pandas as pd


# from __future__ import print_function

_LOG_MOD = None
_ARGS = None
_DIR_WORK = os.path.dirname(os.path.abspath(__name__))
_T_START, _T_STOP = None, None
_FMT_TIME = '%y%m%d-%H-%M-%S'

VERSION = '0.1.0'

_DIR_WORK = r'C:\xtemp'  # Set default directory
_DIR_DATA = r''


def wait_progressbar(wait_time, update_time=None,
                     bar_width=50, progress_marker=None):
    import sys
    from time import sleep,time
    start_time=time()
    MIN_UPDATE_TIME = 0.1
    if update_time is None:
        update_time = MIN_UPDATE_TIME
    else:
        update_time = min(MIN_UPDATE_TIME, update_time)
    if progress_marker is None: progress_marker = ['-', '\\', '|', '/']
    finish_marker="*"
    n_update = int(wait_time / update_time)
    progstr_previous=None
    if wait_time>3:
        for i in range(n_update):
            prog = float(i) / n_update
            prog_time = prog * wait_time
            marker = progress_marker[i % len(progress_marker)]
            n_marker = int(prog * bar_width)
            n_space = bar_width - n_marker
            progstr = "[%s%s] %.0f/%.0f   %d%%\r" % (
                        marker * n_marker, " " * n_space,
                        prog_time, wait_time, int(prog*100))
            if not (progstr==progstr_previous):
                sys.stdout.write(progstr)
                sys.stdout.flush()
                progstr_previous=progstr
            else:
                pass
            sleep(float(update_time))
    else:
        sleep(wait_time)

    marker=finish_marker
    progstr = "[%s%s] %.0f/%.0f   %d%%\n" % (
        marker * bar_width, " " * 0,
        wait_time, wait_time,100)
    sys.stdout.write(progstr)
    sys.stdout.flush()
    return time()-start_time

def get_timestamp(t=None):
    if (t is None) or not (isinstance(t, float)): t = time()
    if '_FMT_TIME' not in globals(): _FMT_TIME = '%y%m%d-%H-%M-%S'
    return t, strftime(_FMT_TIME, localtime(t))


def user_func():
    pass


class UserClass():
    pass


def main_work():
    pass
    # wait_progressbar(wait_time=5)


def startup(dir_working=_DIR_WORK):
    global _ARGS
    global _LOG_MOD
    if not os.path.exists(dir_working): os.mkdir(dir_working, 755)


os.chdir(_DIR_WORK)
print "Current directory:", os.getcwd()

loggingfmt = '%(asctime)s|%(name)-10s %(threadName)-12s|%(levelname)8s|%(lineno)4d  %(message)s'
logging.basicConfig(level=logging.NOTSET, stream=sys.stdout, format=loggingfmt,
                    datefmt='%m%d-%H:%M:%S')
_LOG_MOD = logging.getLogger(__name__)

ap = argparse.ArgumentParser(description=__doc__, epilog='%(prog)s ' + VERSION, \
                             formatter_class=argparse.RawDescriptionHelpFormatter)
ap.add_argument('--version', action='version', version='%(prog)s ' + VERSION)
ap.add_argument('-i', '--in-file', metavar='FILE', nargs='*',
                help='the files to read')
ap.add_argument('-o', '--out-file', metavar='FILE', nargs='*',
                help='the files to write')
ap.add_argument('--loops', type=int, default=1, metavar='int',
                help='Number of loops of the main work function')
ap.add_argument('--verbose', action='store_true',
                help='Make the program more verbose')
ap.add_argument('--debug', action='store_true',
                help='Print additional debug information')
_ARGS = ap.parse_args()


def main():
    # print _ARGS

    for main_loop_ct in xrange(_ARGS.loops):
        _T_START = time()
        main_work()
        _T_STOP = time()
        t_main = _T_STOP - _T_STOP
        print '>>> Sec/Min/Hour: %.2g/%.2g/%.2g' % (
            t_main, t_main / 60.0, t_main / 3600.0), '  ', \
            'Start:', \
            strftime(_FMT_TIME, localtime(_T_START)), ' Stop:', strftime(
            _FMT_TIME, localtime()), \
            '  Loop# %d / %d' % (main_loop_ct + 1, _ARGS.loops)


if __name__ == '__main__':
    startup()
    main()
