#!/bin/sh

# Some guessing after we have all d_funcs ready

mstart "Checking whether you have the full shm*(2) library"
case "$d_shmctl$d_shmget$d_shmat$d_shmdt" in
	*undef*)
		result 'no'
		setvar "d_shm" 'undef'
		;;
	*)
		result 'yes'
		setvar 'd_shm' 'define'
		;;
esac

mstart "Looking how to get error messages"
# Configure has quite a long piece on this, which basically means just this:
if [ "$d_strerror" == 'define' ]; then
	setvar 'd_strerrm' 'strerror(e)'
	result 'strerror()'
elif [ "$d_sys_errlist" == 'define' ]; then
	setvar 'd_strerrm' '((e)<0||(e)>=sys_nerr?"unknown":sys_errlist[e])'
	result 'sys_errlist[]'
else
	setvar 'd_strerrm' 'unknown'
	result 'nothing found'
fi
# note: this was tested already, it's just the name that's different (?)
setvar 'd_syserrlst' "$d_sys_errlist"