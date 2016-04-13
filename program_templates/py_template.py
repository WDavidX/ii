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
import re

# import visa
# import numpy as np
# import pandas as pd
# import matplotlib.pyplot as plt

# from __future__ import print_function

_LOG_MOD = None
_ARGS = None
_DIR_WORK = os.path.dirname(os.path.abspath(__name__))
_FMT_TIME = '%y%m%d-%H-%M-%S'

VERSION = '0.1.0'

_DIR_WORK = r'C:\xtemp'  # Set default directory
_DIR_DATA_NAME = r''
_DIR_DATA = os.path.join(_DIR_WORK, _DIR_DATA_NAME)
_T_SCRIPT_START=None


def wait_progressbar(wait_time, update_time=None,
                     bar_width=50, progress_marker=None):
    import sys
    from time import sleep, time
    start_time = time()
    MIN_UPDATE_TIME = 0.1
    if update_time is None:
        update_time = MIN_UPDATE_TIME
    else:
        update_time = min(MIN_UPDATE_TIME, update_time)
    if progress_marker is None: progress_marker = ['-', '\\', '|', '/']
    finish_marker = "*"
    n_update = int(wait_time / update_time)
    progstr_previous = None
    if wait_time > 3:
        for i in range(n_update):
            prog = float(i) / n_update
            prog_time = prog * wait_time
            marker = progress_marker[i % len(progress_marker)]
            n_marker = int(prog * bar_width)
            n_space = bar_width - n_marker
            progstr = "[%s%s] %.0f/%.0f   %d%%\r" % (
                marker * n_marker, " " * n_space,
                prog_time, wait_time, int(prog * 100))
            if not (progstr == progstr_previous):
                sys.stdout.write(progstr)
                sys.stdout.flush()
                progstr_previous = progstr
            else:
                pass
            sleep(float(update_time))
    else:
        sleep(wait_time)

    marker = finish_marker
    progstr = "[%s%s] %.0f/%.0f   %d%%\n" % (
        marker * bar_width, " " * 0,
        wait_time, wait_time, 100)
    sys.stdout.write(progstr)
    sys.stdout.flush()
    return time() - start_time


def get_timestamp(t=None):
    if (t is None) or not (isinstance(t, float)): t = time()
    if '_FMT_TIME' not in globals():
        local_fmt_time = '%y%m%d-%H-%M-%S'
    else:
        local_fmt_time = _FMT_TIME
    return t, strftime(local_fmt_time, localtime(t))


def user_func():
    pass


class UserClass():
    pass


def main_work():
    pass
    global _T_SCRIPT_START
    # wait_progressbar(wait_time=5)


def startup(dir_working=None):
    global _ARGS
    global _LOG_MOD
    global _DIR_DATA_NAME
    global _DIR_DATA
    global _DIR_WORK
    global _T_SCRIPT_START

    # python logging module setup
    # old_logging_formatter=logging.root.handlers[0].formatter._fmt
    # loggingfmt = '%(asctime)s|%(name)-10s %(threadName)-12s|%(levelname)8s|%(lineno)4d  %(message)s'
    loggingfmt = "%(asctime)s|%(levelname)8s|%(lineno)4d| %(message)s"
    logging.basicConfig(level=logging.NOTSET, stream=sys.stdout,
                        format=loggingfmt,
                        datefmt='%m%d-%H:%M:%S')
    _LOG_MOD = logging.getLogger(__name__)

    # python argument parser setup    
    ap = argparse.ArgumentParser(description=__doc__, epilog='%(prog)s ' + VERSION, \
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('-V','--version', action='version', version='%(prog)s ' + VERSION)
                    
    ap.add_argument('--loops', type=int, default=1, metavar='int',
                    help='Number of loops of the main work function')
    ap.add_argument('--ontime', type=float, default=600, metavar='float',
                    help='Time in seconds to keep the tester in power up states')
    ap.add_argument('--offtime', type=float, default=45, metavar='float',
                    help='Time in seconds to keep the tester in power down states')       
    ap.add_argument('--flagerror', action='store_true',
                    help='Exist looping when there is an error')       
                      
    ap.add_argument('--verbose', action='store_true',
                    help='Make the program more verbose (TODO)')
    ap.add_argument('--debug', action='store_true',
                    help='Print additional debug information  (TODO)')
    _ARGS = ap.parse_args()    
    
    # working directory setup
    if dir_working is None: dir_working = _DIR_WORK    
    if dir_working:
        if not os.path.exists(dir_working): os.mkdir(dir_working, 700)
        os.chdir(dir_working)        
    _DIR_DATA=os.path.join(os.getcwd(),_DIR_DATA_NAME)    
    if (not os.path.exists(_DIR_DATA)): os.mkdir(_DIR_DATA, 700)

    # regular expression example
    # regexp_pat=[r'(.*)error(.*)']
    # regexp_inst=[None]*len(regexp_pat)
    # for idx,item in enumerate(regexp_pat):
    #   regexp_inst[idx]=re.compile(item,re.M|re.I)  
    # regexp_test_target=['Failured','An instance of error occurance']
    # for idx, item in enumerate(regexp_test_target):
    #   for re_idx,re_item in enumerate(regexp_inst):
    #     re_match=re_item.search(item)
    #     if re_match is not None:
    #       pass # found a match
    #       break

    # logging basic start up info 

    _T_SCRIPT_START,time_str = get_timestamp()
    logging.debug("%s    %s "%(os.getcwd(),time_str))   

def main():
    global _T_SCRIPT_START
    # print _ARGS

    _T_START, _T_STOP = None, None
    for main_loop_ct in xrange(_ARGS.loops):
        _T_START = time()
        main_work()
        _T_STOP = time()
        t_main = _T_STOP - _T_START
        print '>>> Sec/Min/Hour: %.2g/%.2g/%.2g' % (
            t_main, t_main / 60.0, t_main / 3600.0), '  ', \
            'Start:', \
            strftime(_FMT_TIME, localtime(_T_START)), ' Stop:', strftime(
            _FMT_TIME, localtime()), \
            ' Loop# %d/%d' % (main_loop_ct + 1, _ARGS.loops)


if __name__ == '__main__':
    startup()
    main()
