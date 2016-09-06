from setuptools import setup

APP = ['hello_world_with_button']
DATA_FILES = []
OPTIONS = {'argv_emulation': True}

setup(
	app=APP,
	data_files=DATA_FILES,
	options={'py2app': OPTIONS},
	setup_requires=['py2app'],
	)
