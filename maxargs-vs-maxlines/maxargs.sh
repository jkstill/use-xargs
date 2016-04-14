#!/bin/bash

ls -1 t/f_[0-9]* | xargs --max-args=10000 file >/dev/null


