from bundlebuilder import buildapp
 
buildapp(
     name='HelloWorld.app', # what to build
     mainprogram='hello_world.py', # your app's main()
     argv_emulation=1, # drag&dropped filenames show up in sys.argv
     iconfile='myapp.icns', # file containing your app's icons
     standalone=1, # make this app self contained.
     includeModules=[], # list of additional Modules to force in
     includePackages=[], # list of additional Packages to force in
     libs=[], # list of shared libs or Frameworks to include
 )
