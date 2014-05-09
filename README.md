dropship
========

Get the seamless and productive user experience out of any OS.

Description:

UNIX File System Browser, SSH, and File Syncing Utility 

Compatibility:

Like any other bash scripts, make sure to run the script from Cygwin in Windows.
For Mac and Linux users, it should be okay to run this script as an executable.
However, features specific to Windows + Cygwin will not work as indicated in the
help section.

Running:

It is recommended to add a shortcut to this program so that it can be run
from any directory. Otherwise, run the script as '. xdropshipverX.sh'
so that the directory location is preserved when exiting the program.


Commands (Help):
		
HELP

	
		
	HELP

		sshgo..........ssh to remote server running xdropship 5.0+ under home
		               assumes that dropship file exists in the remote server home directory
		detail.........shows which are files and which are directories	
		d..............undo 'z' command once, cd to immediately visited subdirectory by one level
		do.............allow typing a UNIX command and run it limitation
		f..............go to or cd to the first directory
		aa.............go to or cd to home directory
		<enter>........list files and directories
		<unknown>......may open target existing file, go to the directory with similar name, or run UNIX command
		z..............move up a directory
		run............run an executable
		
		Google Search 
		
		google........search the web with Google (Windows + Cygwin)
		xgoogle.......search the web with Google (Unix)
		
		
		UNIX Command Syntax Sugar  
		
		xawk [n].......equivalent to awk '{print $^[n]}', ignore ^
		
		Windows  
		
		show...........show target directory in Windows (Cygwin only)
		pop............show currend directory in Windows (Cygwin only)
		
		
		Navigation Assistant Components 
		
		p..............select a directory
		flag...........flag the location of the current directory
		goback.........go back to the last flagged directory location (see d)
		favthis........Save the current directory paths in favourites
		favedit........edit the list of favourites on vi		
		favs...........open the list of favourites to go to (cd to)		
		favclear.......clear the list of favourites		
		sink...........cd to deepest directory under favourites from current directory
		copytofav......copy current directories to one of favourites 	
		tree...........show file tree
		search.........search in favourites (if not found in history) for files with keywords
		lookup.........look up a file or directory under current directory
		
		Download Components 
		
		downloads......cd to DownloadStore in dropship repository
		import.........move a file from a download folder (must be set by the browser)
		(Type repository, go to DownloadStore (directory) and type pop)
		tagthis...*....tag the current directory so that files with filename '...<tag>...' 
		can be imported to this directory
		importx........import all files in download folders by tags see 'tag'
		tagedit........edit the list of tags on vi		
		tags...........open the list of tags		
		tagclear.......clear the list of tags	
		
		Stage Tools [V.5.2] 
		
		setstage.......set the current directory as a primary stage
		linkstage......[after primarystage]set the current directory as a secondary stage
		linkremote.....[after primarystage]set remote directory as a secondary stage
		editstages.....edit stage links
		syncstages.....sync linked stages (if duplicates found files in the primary stage are used)
		
		
		m Web Bookmarks [V 7.3] 
		
		bookmarkthis....set short cut for a new bookmark
		bookmarks.......choose a bookmark in a list of bookmarks to run
		bookmarkclear...clear list of bookmarks
		
		
		mProgram (Executable) Shortcut [V 7] 
		
		programthis....set short cut for this program
		programs.......choose a program in a list of programs to run in the background
		programscmd....choose a program in a list of programs to run
		programclear...clear list of programs
		
		
		mFile Manipulation Components
		
		copy...........copy a file
		paste..........paste a copied file
		pasteremote....paste a copied file to remote server
		tray...........list of files in the tray
		filltray.......copy barch of files to the tray with a keyword
		cuttray........cut batch of files to the tray with a keyword
		pastetray......paste a cut files from the tray, tray contents are removed
		cleartray......clear tray
		zip............zip a directory
		zipfiles.......zip some files in a directory using temp directory
		zipsourcecode..zip .h and .cc files for submission
		addprefixall...add prefix to all filenames in the current directory
		
		mSetting Components
		
		historyoff.....turn off history tracking
		historyon......turn on history tracking
		history........view history
		historyedit....edit history
		repository.....go to dropship setting repository
		clearhistory...clear history
		
		Clipboard  [V.5.3]
		
		copytext......to copy a text to clipboard to be pasted
		copied........to show copied text
		l.............last input command saved to the clipboard
		copypwd.......path to current directory saved to the clipboard
		copyaddwin....Windows path to current directory saved to the clipboard
		
		Valgrind   [V.5.3]
		
		xvalgrind......valgrind compiled program from all .cc files in the current directory
		
		Redirect  [V.5.3]
		
		x>.............type input to be redirected to a file
		
		Plugin Setting
		
		setpath........set path to dropship program
		plugin.........run list of plugins (you can add plugin program under the <setting repository>/Plugin)
		
		Localhost Macro Setting
		
		setlocalhost...set current directory path as localhost (you must have localhost beforehand)
		launch.........run program in under local server		
		exit...........exit Dropship		
		goout..........exit Dropship		
		about..........about Dropship
