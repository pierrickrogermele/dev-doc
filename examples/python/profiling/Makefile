all: cprofiler.pstat yappi.pstat

cprofiler.pstat:
	python3 -m cProfile -o $@ myscript.py

snakeviz:
	snakeviz cprofile.pstat

yappi.pstat:
	yappi -o $@ myscript.py
