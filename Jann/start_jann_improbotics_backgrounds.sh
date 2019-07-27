#!/bin/bash
gunicorn --bind 0.0.0.0:8123 app_backgrounds:JANN -w 1

