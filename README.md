dropship
========

UNIX File System Browser, SSH, and File Syncing Utility 

	HELP
		
		remoteconfig...configure remote server address  <br>
		ssshuw.........ssh (remote shell) to remote server <br>
		sshuw..........ssh to remote server running xdropship 5.0+ under home <br>
		               assumes that dropship file exists in the remote server home directory <br>
		detail.........shows which are files and which are directories	<br>
		d..............cd to a previously visited directory<br>
		do.............allow typing a UNIX command and run it limitation<br>
		f..............go to or cd to the first directory<br>
		aa.............go to or cd to home directory<br>
		<enter>........list files and directories<br>
		<unknown>......may open target existing file, go to the directory with similar name, or run UNIX command<br>
		z..............move up a directory<br>
		run............run an executable<br><br>
		
		
		  UNIX Command Syntax Sugar  <br>
		
		xawk [n].......equivalent to awk '{print $^[n]}', remove ^<br><br>
		
		  Windows  <br><br>
		
		show...........show target directory in Windows (Cygwin only)<br>
		pop............show currend directory in Windows (Cygwin only)<br><br>
		
		
		  Navigation Assistant Components <br><br>
		
		p..............select a directory<br>
		flag...........flag the location of the current directory<br>
		goback.........go back to the last flagged directory location (see d)<br>
		favthis........Save the current directory paths in favourites<br>
		favedit........edit the list of favourites on vi		<br>
		favs...........open the list of favourites to go to (cd to)		<br>
		favclear.......clear the list of favourites		<br>
		sink...........cd to deepest directory under favourites from current directory<br>
		copytofav......copy current directories to one of favourites 	<br>
		tree...........show file tree<br>
		search.........search in favourites (if not found in history) for files with keywords<br>
		lookup.........look up a file or directory under current directory<br><br>
		
		  Download Components <br><br>
		
		downloads......cd to DownloadStore in dropship repository<br>
		import.........move a file from a download folder (must be set by the browser)<br>
		(Type repository, go to DownloadStore (directory) and type pop)<br>
		tag............tag the current directory so that files with filename '...<tag>...' <br>
		can be imported to this directory<br>
		importx........import all files in download folders by tags see 'tag'<br>
		tagedit........edit the list of tags on vi		<br>
		tags...........open the list of tags		<br>
		tagclear.......clear the list of tags	<br><br>
		
		Stage Tools [V.5.2] <br><br>
		
		setstage.......set the current directory as a primary stage<br>
		linkstage......[after primarystage]set the current directory as a secondary stage<br>
		linkremote.....[after primarystage]set remote directory as a secondary stage<br>
		editstages.....edit stage links<br>
		syncstages.....sync linked stages (if duplicates found files in the primary stage are used)<br>
		
		File Manipulation Components<br><br>
		
		copy...........copy a file<br>
		paste..........paste a copied file<br>
		pasteremote....paste a copied file to remote server<br>
		tray...........list of files in the tray<br>
		filltray.......copy barch of files to the tray with a keyword<br>
		cuttray........cut batch of files to the tray with a keyword<br>
		pastetray......paste a cut files from the tray, tray contents are removed<br>
		cleartray......clear tray<br>
		zip............zip a directory<br>
		zipfiles.......zip some files in a directory using temp directory<br>
		zipsourcecode..zip .h and .cc files for submission<br><br>
		
		 mSetting Components<br><br>
		
		historyoff.....turn off history tracking<br>
		historyon......turn on history tracking<br>
		history........view history<br>
		historyedit....edit history<br>
		repository.....go to dropship setting repository<br>
		clearhistory...clear history<br><br>
		
		 Clipboard  [V.5.3]<br><br>
		
		copytext......to copy a text to clipboard to be pasted<br>
		copied........to show copied text<br>
		l.............last input command saved to the clipboard<br>
		copypwd.......path to current directory saved to the clipboard<br>
		copyaddwin....Windows path to current directory saved to the clipboard<br><br>
		
		 Valgrind   [V.5.3]<br><br>
		
		xvalgrind......valgrind compiled porgram from all .cc files in the current directory<br><br>
		
		 Redirect  [V.5.3]<br><br>
		
		x>.............type input to be redirected to a file<br><br>
		
		 Plugin Setting<br><br>
		
		setpath........set path to dropship program<br>
		plugin.........run list of plugins (you can add plugin program under the <setting repository>/Plugin)<br><br>
		
		 Localhost Macro Setting<br><br>
		
		setlocalhost...set current directory path as localhost (you must have localhost beforehand)<br>
		launch.........run program in under local server		<br>
		exit...........exit Dropship		<br>
		goout..........exit Dropship		<br>
		about..........about Dropship<br>
