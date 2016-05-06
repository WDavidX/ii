#!/usr/bin/env python

"""Python 2 Program Template

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
# 2001-01-01                            1      Initial
"""

import time
import os
import sys
import argparse
import logging
import platform

# import visa
# import numpy as np
# import pandas as pd
# import matplotlib.pyplot as plt

# from __future__ import print_function

############################################################
########## Global varibles initilization
############################################################
_ARGS, _LOG_MOD = None, None
_T_GLOBAL_START, _T_GLOBAL_START_STR = None, None
_DIR_WORK = os.path.dirname(os.path.abspath(__name__))
_FMT_TIME = "%y%m%d-%H-%M-%S"

VERSION = "0.1.0"

if platform.uname()[0].lower() == r"Windows".lower():
    _DIR_WORK = r"C:\temp"  # Default directory
elif platform.uname()[0].lower() == r"Linux".lower():
    _DIR_WORK = r"~/temp"
else:
    pass

_DIR_DATA_NAME = r""
_DIR_DATA = os.path.join(_DIR_WORK, _DIR_DATA_NAME)


############################################################
########## General ultility functions
############################################################
def wait_progressbar(wait_time, update_time=None,
                     bar_width=50, progress_marker=None):
    import sys
    import time
    start_time = time.time()
    MIN_UPDATE_TIME = 0.1
    if update_time is None:
        update_time = MIN_UPDATE_TIME
    else:
        update_time = min(MIN_UPDATE_TIME, update_time)
    if progress_marker is None: progress_marker = ["-", "\\", "|", "/"]
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
            time.sleep(float(update_time))
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
    if (t is None) or not (isinstance(t, float)): t = time.time()
    if "_FMT_TIME" not in globals():
        LOCAL_FMT_TIME = "%y%m%d-%H-%M-%S"
    else:
        LOCAL_FMT_TIME = _FMT_TIME
    return t, time.strftime(LOCAL_FMT_TIME, time.localtime(t))


############################################################
########## User functions
############################################################
def user_func():
    pass


############################################################
########## User classes
############################################################
class UserClass():
    pass


############################################################
########## Main work function with loop index
############################################################
def main_work(loop_index=1):
    pass
    # wait_progressbar(wait_time=5)


def startup(dir_working=None):
    global _ARGS
    global _LOG_MOD
    global _DIR_DATA_NAME
    global _DIR_DATA
    global _DIR_WORK
    global _T_GLOBAL_START_STR
    global _T_GLOBAL_START

    ## Program start time and timestamp
    _T_GLOBAL_START, _T_GLOBAL_START_STR = get_timestamp(time.time())

    ## Argument parser
    ap = argparse.ArgumentParser(description=__doc__, epilog="%(prog)s " + VERSION, \
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--version", action="version", version="%(prog)s " + VERSION)
    ap.add_argument("-i", "--in-file", metavar="FILE", nargs="*",
                    help="the files to read")
    ap.add_argument("-o", "--out-file", metavar="FILE", nargs="*",
                    help="the files to write")
    ap.add_argument("-d", "--debug", action="store_true",
                    help="Turn on the debug options")
    ap.add_argument("--log", action="store_true",
                    help="Turn on the debug options")
    ap.add_argument("--loops", type=int, default=1, metavar="int",
                    help="Number of loops of the main work function")
    ap.add_argument("--log-file", metavar="FILE", nargs=1,
                    default='pylog--%s.txt' % (_T_GLOBAL_START_STR),
                    help="Log file name")
    ap.add_argument("--verbose", action="store_true",
                    help="Make the program more verbose")
    ap.add_argument("--debuglevel", default=0, metavar="int",
                    help="Set the debug level for stdout logger")
    ap.add_argument("--lograw", action="store_true",
                    help="Log the bear minimum ")
    ap.add_argument("--loglevel", default=logging.WARNING, metavar="int",
                    help="Set the debug level for file logger")
    _ARGS = ap.parse_args()

    ## Working directory
    if dir_working is None: dir_working = _DIR_WORK
    if not os.path.exists(dir_working): os.mkdir(dir_working, 755)
    if (not _DIR_DATA_NAME) and (not os.path.exists(_DIR_DATA)):
        os.mkdir(_DIR_DATA, 755)
    os.chdir(_DIR_WORK)

    ## Python logger
    logging.basicConfig(stream=sys.stdout)
    root = logging.getLogger()
    hdlr = root.handlers[0]

    default_logging_fmt = hdlr.formatter._fmt  # _fmt is the string, fmtter is the object
    if _ARGS.debug:
        root.setLevel(level=_ARGS.debug)
    else:
        root.setLevel(level=logging.CRITICAL * 2 + 1)
    # loggingfmt = "%(asctime)s|%(name)-10s %(threadName)-12s|%(levelname)8s|%(lineno)4d  %(message)s" # Complete log
    loggingfmt = "%(asctime)s|%(levelname)8s|%(lineno)4d|  %(message)s"  # Brief log
    if _ARGS.lograw: loggingfmt = "%(message)s"  # Bare minimum logging
    logdatefmt = "%m%d-%H:%M:%S"
    fmtter = logging.Formatter(fmt=loggingfmt, datefmt=logdatefmt)  # the format object
    hdlr.setFormatter(fmtter)
    _LOG_MOD = logging.getLogger(__name__)

    if _ARGS.log:
        fh_log = logging.FileHandler(_ARGS.log_file, mode='a', encoding=None, delay=False)
        loggingfmt = "%(asctime)s|%(levelname)8s|%(message)s"  # Brief log
        fh_log.setFormatter(fmt=logging.Formatter(fmt=loggingfmt, datefmt=logdatefmt))
        root.addHandler(fh_log)

    ## Startup information
    logging.debug("%s%s", "*" * 0, time.asctime(time.localtime(_T_GLOBAL_START)))
    logging.debug("*" * 60)


def main():
    _T_START, _T_STOP = None, None
    for main_loop_ct in xrange(_ARGS.loops):
        _T_START = time.time()
        main_work(main_loop_ct)
        _T_STOP = time.time()
        t_main = _T_STOP - _T_START
        outstr = "%s\n==> %-3d/%d | %s | %s | S/M/H: %7.2g/%7.2g/%7.2g\n%s\n\n" \
                 % ("#" * 79,
                    main_loop_ct + 1, _ARGS.loops,
                    time.strftime(_FMT_TIME,
                                  time.localtime(
                                      _T_START)),
                    time.strftime(_FMT_TIME,
                                  time.localtime(
                                      _T_STOP)),
                    t_main, t_main / 60.0,
                    t_main / 3600.0, "#" * 79)
        print outstr


if __name__ == "__main__":
    startup()
    main()
