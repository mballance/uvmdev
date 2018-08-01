
UVMDEV_MKFILES_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
UVMDEV := $(abspath $(UVMDEV_MKFILES_DIR)/..)
export UVMDEV
