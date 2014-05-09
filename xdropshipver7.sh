#!/bin/bash

# DROPSHIP VER 7.3 - Kiwis

# Copyright Hyunwook Shin 2014

# INITIALIZE FILE DIRECTORIES --------------------------------------------
mkdir ~/dropshiprepos/ 				2> /dev/null
mkdir ~/dropshiprepos/DownloadStore 2> /dev/null
rm ~/dropshiprepos/DownloadStore/*  2> /dev/null # clean
mkdir ~/dropshiprepos/Printer		2> /dev/null
mkdir ~/dropshiprepos/Tray			2> /dev/null
mkdir ~/dropshiprepos/Path			2> /dev/null
mkdir ~/dropshiprepos/Key			2> /dev/null
mkdir ~/dropshiprepos/Sandbox		2> /dev/null

# STATE VARIABLES --------------------------------------------------------
originalwd=$(pwd)					# Original Working Directory Location
historytracking="on"				# Record History

# CONFIGUTATION FUNCTIONS ------------------------------------------------
# gotolastlocation sets the location to the last saved location
gotolastlocation () {
	if [ -r ~/dropshiprepos/last.path ]; then
		array_inputs=()
		while read arg
		do
			echo "Jumping to " $arg
			cd "${arg//=/ }"
		done < ~/dropshiprepos/last.path
	fi
}

# SIGNATURE -------------------------------------------------------------------------
signature () {
	echo "     $(pwd) "
	echo -e " \e[1;30;32m"
	echo -e " XDropShip KIWIS [Ver 7.3] \e[0m"
	echo ""
	echo "            ... type 'about' to learn more."
	echo "            ... press enter  to navigate."
	echo "            ... type 'help'  to get started."
	echo "            ... or 'Ctrl+C'  to return to shell. "
	echo ""
	echo ""
	echo "______________________________________________________________________________"
}

# UNIX COMMAND CHANGES -------------------------------------------------
xawk () {
	value=$1
	echo $value
	array=()
	while read stdin; do
		array=( $stdin )
		echo "$stdin" | awk '{print $'"$value"'}'
	done
}

# PRINT STATE #whereami --------------------------------------------------
whereami () {
	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13; do
		echo ""
	done
	echo -ne "\e[1;30;32mcd to here >  \e[0m"
	dir=$(pwd)
	echo -e "\e[1;30;32m${dir//\//  }\e[0m"

	num=$(ls -d */ 2> /dev/null| wc -l)
	numf=$(ls  2> /dev/null| wc -l) 
	if [ $num -ge 20 ] 
	then
		echo "_______________________________________________________________________________"
		ls -d */   
		echo "_______________________________________________________________________________"
		echo -e "\e[1;94mFiles are not shown due to exceeding number of directories. Type 'detail' or 'tree'.\e[0m"
		echo ""
		echo ""
	elif [ $numf -le 20 ] 
	then
		# TWO PANEL VIEW
		echo "_______________________________________________________________________________" >~/dropshiprepos/outputright.txt
		ls  --sort=extension >> ~/dropshiprepos/outputright.txt
		echo "_______________________________________________________________________________" >>~/dropshiprepos/outputright.txt
		
		find . -maxdepth 2 -type d -print | egrep "^.([^\.])*$"  | head -n 20 | sed -e 's;[^/]*/;|____;g;s;____|; |;g' > ~/dropshiprepos/outputleft.txt
		pr -m -t ~/dropshiprepos/outputleft.txt ~/dropshiprepos/outputright.txt
	else
		echo "(Type 'tree' to show tree)"
		echo "_______________________________________________________________________________"
		ls --sort=extension
		echo "_______________________________________________________________________________"
		echo ""
		echo ""
	fi
	echo ""
}
# HELP ----------------------------------------------------------------
gethelp () {
		echo "HELP"
		echo ""
		echo "sshgo..........ssh to remote server running xdropship 5.0+ under home"
		echo "               assumes that dropship file exists in the remote server home directory"
		echo "detail.........shows which are files and which are directories	"
		echo "d..............undo 'z' command once, cd to immediately visited subdirectory by one level"
		echo "do.............allow typing a UNIX command and run it limitation"
		echo "f..............go to or cd to the first directory"
		echo "aa.............go to or cd to home directory"
		echo "<enter>........list files and directories"
		echo "<unknown>......may open target existing file, go to the directory with similar name, or run UNIX command"
		echo "z..............move up a directory"
		echo "run............run an executable"
		echo ""
		echo  -e "\e[1;94m Google Search \e[0m"
		echo ""
		echo "google........search the web with Google (Windows + Cygwin)"
		echo "xgoogle.......search the web with Google (Unix)"
		echo ""
		
		echo  -e "\e[1;94mUNIX Command Syntax Sugar  \e[0m"
		echo ""
		echo "xawk [n].......equivalent to awk '{print $^[n]}', ignore ^"
		echo ""
		echo  -e "\e[1;94mWindows  \e[0m"
		echo ""
		echo "show...........show target directory in Windows (Cygwin only)"
		echo "pop............show currend directory in Windows (Cygwin only)"
		
		echo ""
		echo  -e "\e[1;94mNavigation Assistant Components \e[0m"
		echo ""
		echo "p..............select a directory"
		echo "flag...........flag the location of the current directory"
		echo "goback.........go back to the last flagged directory location (see d)"
		echo "favthis........Save the current directory paths in favourites"
		echo "favedit........edit the list of favourites on vi"		
		echo "favs...........open the list of favourites to go to (cd to)"		
		echo "favclear.......clear the list of favourites"		
		echo "sink...........cd to deepest directory under favourites from current directory"
		echo "copytofav......copy current directories to one of favourites "	
		echo "tree...........show file tree"
		echo "search.........search in favourites (if not found in history) for files with keywords"
		echo "lookup.........look up a file or directory under current directory"
		echo ""
		echo  -e "\e[1;94mDownload Components \e[0m"
		echo ""
		echo "downloads......cd to DownloadStore in dropship repository"
		echo "import.........move a file from a download folder (must be set by the browser)"
		echo "(Type repository, go to DownloadStore (directory) and type pop)"
		echo "tagthis...*....tag the current directory so that files with filename '...<tag>...' 
		can be imported to this directory"
		echo "importx........import all files in download folders by tags see 'tag'"
		echo "tagedit........edit the list of tags on vi"		
		echo "tags...........open the list of tags"		
		echo "tagclear.......clear the list of tags"	
		echo ""
		echo -e  "\e[1;94mStage Tools [V.5.2] \e[0m"
		echo ""
		echo "setstage.......set the current directory as a primary stage"
		echo "linkstage......[after primarystage]set the current directory as a secondary stage"
		echo "linkremote.....[after primarystage]set remote directory as a secondary stage"
		echo "editstages.....edit stage links"
		echo "syncstages.....sync linked stages (if duplicates found files in the primary stage are used)"
		echo ""
		echo ""
		echo -e  "\e[1;94m Web Bookmarks [V 7.3] \e[0m"
		echo ""
		echo "bookmarkthis....set short cut for a new bookmark"
		echo "bookmarks.......choose a bookmark in a list of bookmarks to run"
		echo "bookmarkclear...clear list of bookmarks"
		echo ""
		echo ""
		echo -e  "\e[1;94mProgram (Executable) Shortcut [V 7] \e[0m"
		echo ""
		echo "programthis....set short cut for this program"
		echo "programs.......choose a program in a list of programs to run in the background"
		echo "programscmd....choose a program in a list of programs to run"
		echo "programclear...clear list of programs"
		echo ""
		echo ""
		echo -e  "\e[1;94mFile Manipulation Components\e[0m"
		echo ""
		echo "copy...........copy a file"
		echo "paste..........paste a copied file"
		echo "pasteremote....paste a copied file to remote server"
		echo "tray...........list of files in the tray"
		echo "filltray.......copy barch of files to the tray with a keyword"
		echo "cuttray........cut batch of files to the tray with a keyword"
		echo "pastetray......paste a cut files from the tray, tray contents are removed"
		echo "cleartray......clear tray"
		echo "zip............zip a directory"
		echo "zipfiles.......zip some files in a directory using temp directory"
		echo "zipsourcecode..zip .h and .cc files for submission"
		echo "addprefixall...add prefix to all filenames in the current directory"
		echo ""
		echo -e  "\e[1;94mSetting Components\e[0m"
		echo ""
		echo "historyoff.....turn off history tracking"
		echo "historyon......turn on history tracking"
		echo "history........view history"
		echo "historyedit....edit history"
		echo "repository.....go to dropship setting repository"
		echo "clearhistory...clear history"
		echo ""
		echo -e "\e[1;94mClipboard  [V.5.3]\e[0m"
		echo ""
		echo "copytext......to copy a text to clipboard to be pasted"
		echo "copied........to show copied text"
		echo "l.............last input command saved to the clipboard"
		echo "copypwd.......path to current directory saved to the clipboard"
		echo "copyaddwin....Windows path to current directory saved to the clipboard"
		echo ""
		echo -e "\e[1;94mValgrind   [V.5.3]\e[0m"
		echo ""
		echo "xvalgrind......valgrind compiled porgram from all .cc files in the current directory"
		echo ""
		echo -e "\e[1;94mRedirect  [V.5.3]\e[0m"
		echo ""
		echo "x>.............type input to be redirected to a file"
		echo ""
		echo -e "\e[1;94mPlugin Setting\e[0m"
		echo ""
		echo "setpath........set path to dropship program"
		echo "plugin.........run list of plugins (you can add plugin program under the <setting repository>/Plugin)"
		echo ""
		echo -e "\e[1;94mLocalhost Macro Setting\e[0m"
		echo ""
		echo "setlocalhost...set current directory path as localhost (you must have localhost beforehand)"
		echo "launch.........run program in under local server"		
		echo "exit...........exit Dropship"		
		echo "goout..........exit Dropship"		
		echo "about..........about Dropship"
}
# ABOUT ------------------------------------------------------------------------
about () {
echo ""
		echo -e "                   \e[1;94mXDropship\e[0m  Ver 7.3 Kiwis         "
		echo ""
		echo "           Author:  Hyunwook Shin      "
		echo "           Date:    2014               "
		echo "           Use:     Personal Use Only  "
		echo ""
		echo ""
		echo "      Dropship is a command-line file system browser for enhanced"
		echo "      and user friendly navigation experience for all Cygwin / Unix users"
		echo ""
		echo "      1) Intuitive interface for navigating through directories and opening files"
		echo "      2) Interpretation of (no io redirection) UNIX command right from the command line interface"
		echo "      3) Sync utility for multiple directories in local and remote servers"
		echo "      4) File re-distribution, SSH, Zip, Localhost, Clipboard and more"
		echo ""
}
# CONFIGURE REMOTE SSH SETTING ------------------------------------------------
configure () {
		cat ~/dropshiprepos/remoteconfig.txt 2> /dev/null
		echo "username:"
		read username
		echo "host address:"
		read hostaddress
		echo "$username@$hostaddress" >~/dropshiprepos/remoteconfig.txt
		echo "Configuration Complete!"
		remoteaddress="$username@$hostaddress"
}

# NOTES ON SSH WITHOUT PASSWORD 
		# Install PuTTY key generator (or use ssh-keygen -t rsa in UNIX)
		# generate and save the public and private key in .ssh directory under your home/user directory
		# use SSH-2 RSA
		# rename the public and private key as id_rsa.pub and id_rsa.
		# Use the following code to copy id_rsa.pub
		# scp /home/user/.ssh/id_rsa.pub ...@.../.ssh/id_rsa.pub
		# Then attach it to the authorized_keys
		# cat ~/.ssh/id_rsa.pub | ssh ...@... "cat >> ~/.ssh/authorized_keys"
		# Try running ssh session with ssh -v option
		# you will get a warning saying that the permission is too open (otherwise use chmod a+r id_rsa)
		# Hence change the permission
		# chgrp Users id_rsa
		# chmod 600 id_rsa

# LINK TWO STAGES -------------------------------------------------------------
# Linkstages allows users to set relationship between two directories
# so that they can be synced 
linkstages() {
	#same as linkcomplete but with remote server directory (you must use beacon)
	linkdirscd=$(pwd)
	if [ $linkdir != "" ]; then
	
		echo "username: (Enter to skip as h7shin)"
		read username
		echo "server: (Enter to skip as linux.student.cs.uwaterloo.ca)"
		read server
		echo "Path from remote home directory to dropship bash script (Must be Compatible with Version 5+ Check about) :"
		read path
		echo "Navigate to the directory in the remote server by SSH and type exit"
		
		if [ "$username" == "" ]
		then
			username="h7shin"
		fi
		if [ "$server" == "" ]
		then
			server="linux.student.cs.uwaterloo.ca"
		fi
		#echo "ssh $user@$server . xdropshipver5.sh;pwd"
		ssh $username@$server "cd $path;. xdropshipver5.sh;"
		scp $username@$server:~/dropshiprepos/last.path last_temp.path
		linkdirscd=$(cat last_temp.path)
		rm last_temp.path
		echo "${linkdir// /=}^$username@$server:${linkdirscd// /=}" >> ~/dropshiprepos/stage.txt
		
	fi
	echo "Link Completed!"
}
# SYNCSTAGES ------------------------------------------------------------------
# Syncstages syncs two or more directories together (one of them is a primary directory,
# and the others are secondary (remote or local) directories) 
syncstages() {
	array_primary=()
	array_secondary=()
	echo "Commands (Inner)"
	echo " importoverwite:   Overwrite current files with files from secondary local stage"
	echo " exportoverwite:   Overwrite secondary stage files with current files"
	echo " unionoverwite:    (exportoverwrite + importoverwrite)"
		
	echo " importexplicit:   Make current directory identical to secondary stage"
	echo " exportexplicit:   Make secondary stage identical to current directory"
		
	echo " importremote: 	 Overwrite current files with files from remote stage"
	echo " exportremote: 	 Overwrite remote stage files with current stage"
	echo "Enter command: "
	read command
	
	primarytosecondary=0
	secondarytoprimary=0
	primarytosecondarydir=0
	primarytoremote=0
	remotetoprimary=0
	primarytoremotedir=0
	remotetoprimarydir=0	
	deleterestsecondary=0
	while read arg
	do
		#echo ${arg//=/' '}
		i=$(echo ${arg//\^/' '} | awk '{print $1}')
		j=$(echo ${arg//\^/' '} | awk '{print $2}')
		echo $i "..." $j
		echo -ne '\n'
		array_primary+=( $i ) # string --> array
		array_secondary+=( $j ) # string --> array
	done < ~/dropshiprepos/stage.txt
	
	i=0
	for link in "${array_primary[@]}"
	do
		echo "Analyzing link ..."
			
		primary="${array_primary[$i]}"
		secondary="${array_secondary[$i]}"		
		location=$(pwd)
		num=$(echo $secondary | egrep "@" | wc -w)
		fixedlocation="${location// /=}"
		num2=$(echo $primary | egrep "${location// /=}" | wc -w)
		#echo $primary | egrep "$location" 
		echo "Remote...?" $num
		#echo "Curent directory?" $num2
		echo "${primary}|"
		echo "${location}|"
		
		if [ "${primary}" == "${location}" ]; then
			mkdir "${secondary//=/ }" 2> /dev/null
			
			if [ "$command" == "importoverwrite" ]; then
					secondarytoprimary=1
			elif [ "$command" == "exportoverwrite" ]; then
					primarytosecondary=1
			elif [ "$command" == "unionoverwrite" ]; then
					primarytosecondary=1
					secondarytoprimary=1
			elif [ "$command" == "importexplicit" ]; then
					echo "Press enter to proceed to delete current files"
					read buffer
					rm -r *
					secondarytoprimary=1
			elif [ "$command" == "exportexplicit" ]; then
					primarytosecondary=1
					deleterestsecondary=1
			elif [ "$command" == "importremote" ]; then
					remotetoprimary=1					
			elif [ "$command" == "exportremote" ]; then
					echo "Remote Export ..."
					primarytoremote=1
			else
					echo "No matching command found (Press Enter to continue)"
					read bufer
			fi

			if [ $primarytosecondary -eq 1 ]; then
				cp "${primary//=/ }/"* "${secondary//=/ }/"
			fi
			
			if [ $secondarytoprimary -eq 1 ]; then
				cp "${secondary//=/ }/"* "${primary//=/ }/"
				echo "setting"
			fi
			
			if [ $deleterestsecondary -eq 1 ]; then
				location=$(pwd)
				cd "${secondary//=/ }/"
				rm -r $(diff -bur ../"${primary//=/ }" ../"${secondary//=/ }" | awk '{print $4}')
				fixedlocation="${location// /=}"
				cd "${fixedlocation//=/ }/"
			fi
			
			if [ $primarytosecondarydir -eq 1 ]; then
				cp -r "${primary//=/ }/"* "${secondary//=/ }/"
			fi
			if [ $primarytoremote -eq 1 -a $num -eq 1 ]; then
				scp "${primary//=/ }/"* "${secondary//=/ }/"
			fi 
			if [ $remotetoprimary -eq 1 -a $num -eq 1 ]; then
				scp "${secondary//=/ }/"* "${primary//=/ }/"
			fi
			if [ $primarytoremotedir -eq 1 -a $num -eq 1 ]; then
				scp -r "${primary//=/ }/"* "${secondary//=/ }/"
			fi 
			if [ $remotetoprimarydir -eq 1 -a $num -eq 1 ]; then
				scp -r "${secondary//=/ }/"* "${primary//=/ }/"
			fi	
		fi
		i=$(($i+1))
	done
}
# -----------------------------------------------------------------------------
# opening a file
# GET -------------------------------------------------------------------------
# get runs open or cygstart depending on the OS 
get () {
	if [ "$os" == 'win' ]; then
		cygstart "$1"
	else
		open "$i"
	fi
}

# SET OS ----------------------------------------------------------------------
# set os sets the type of os to be used to run the right command
setos() {
	echo "Enter OS, 'win' for windows, 'unx' for unix/mac"
	read os
	echo "$os" > ~/dropshiprepos/os.txt
}
# -----------------------------------------------------------------------------

# Get the history switch setting
if [ -r ~/dropshiprepos/history.opt ]; then
	while read arg
		do
			if [ $arg == "history_off" ]
			then
				echo "History set to off"
				historytracking="off"
			else 
				echo "$arg ///History set to on"
			fi
			
	done < ~/dropshiprepos/history.opt
fi

# Set Remote Configuration
if [ -r ~/dropshiprepos/remoteconfig.txt ]; then
	while read arg; do
		remoteaddress=$arg			
	done < ~/dropshiprepos/remoteconfig.txt
fi

if [ -r ~/dropshiprepos/pathtokey.path ]; then
	while read arg; do
		pathtokey=$arg			
	done < ~/dropshiprepos/pathtokey.path
fi

if [ -r ~/dropshiprepos/os.txt ]; then
	while read arg; do
		os=$arg			
	done < ~/dropshiprepos/os.txt
else
	setos
fi

# Set Localhost Configuration
if [ -r ~/dropshiprepos/localhostmacro.opt ]; then
	while read arg
		do
			localhostmacro=$arg
	done < ~/dropshiprepos/localhostmacro.opt
fi

# -----------------------------------------------------------------------------
whereami
gotolastlocation
signature

while [ 1 ]
do
	#----------------------------------------------------------------------------------------
	# READ COMMAND INPUT
	read input
	#----------------------------------------------------------------------------------------
	if [ "$input" == "help" ]
	then
		gethelp 		
	elif [ "$input" == "about" ]
	then
		about
	elif [ "$input" == "l" ]
	then
		echo $lastinput > /dev/clipboard
	elif [ "$input" == "copypwd" ]
	then
		pwd > /dev/clipboard
	elif [ "$input" == "copyaddwin" ]
	then
		dir=$(pwd)
		dir="${dir//'/cygdrive/c'/C:}"
		dir="${dir//'/'/\\}"
		echo $dir > /dev/clipboard	
	elif [ "$input" == "osconfig" ]
	then
		setos
	elif [ "$input" == "remoteconfig" ]
	then
		configure
	elif [ "$input" == "setpath" ]
	then
		echo "Set path to dropship program location."
		read path
		echo "${path}" >~/dropshiprepos/program.path
	elif [ "$input" == "plugin" ]
	then
		PS3="Type a number or 'q' to quit: "
			dir="${pwd}"
			cd ~/dropshiprepos/Plugin
			ls
			options=($(ls -l | egrep ^- | awk '{print $9}' |  xargs printf '%-24s\n'))
			select opt in "${options[@]}"
			do
				if [[ "$opt" == *[a-zA-Z0-9]* ]]
				then
					cd ~/dropshiprepos/Plugin
					ls
					bash ~/dropshiprepos/Plugin"/$opt"
					cd $dir
				fi
				whereami
				break
			done
	
	elif [ "$input" == "sshgo" ]
	then
		echo "SSH"
		if [ "$remoteaddress" == "" ]; then
			echo "Set up remote address by typing 'remoteconfig'"
			echo "And restart dropship"
		else 
			#http://www.unix.com/unix-dummies-questions-answers/147672-how-stay-remote-shell-after-executing-commands-ssh.html
			while [ 1 -eq 1 ]; do
				
				ssh -t "$remoteaddress" './xdropshipver5.sh; cd $(cat dropshiprepos/last.path)' ';' exec /bin/sh
				echo "Type q to return to local:"
				read command
				if [ "$command" == "q" ]; then
					break
				fi
			done
			# Do Stuff in Remote Server
			
			#cd "$down"
			whereami
		fi
	elif [ "$input" == "detail" ]
	then
		echo "Directories:"
		ls -l | egrep ^d | awk '{print $9}' | cut -c 1-20 |  xargs printf '%-24s\n' | sed '$p;N;s/\n//;$p;N;s/\n//;' | head -n -1
		echo "Files:"
		ls -l | egrep ^- | awk '{print $9}' | cut -c 1-20 |  xargs printf '%-24s\n' | sed '$p;N;s/\n//;$p;N;s/\n//;' | head -n -1
	
	elif [ -d "$input" ]
	then
		echo "Moving to input"
		cd "$input"
		whereami
	elif [ -f "$input" ]
	then
		echo "Opening  file"
		get "$input"
	elif [ "$input" == "" ]
	then
		whereami
	elif [ "$input" == "z" ]
	then
		# Save the subdirectory revisited 
		downprev="$down"
		down=$(pwd)
		echo "Moving up a directory (cd ../)"
		cd ../
		whereami
	elif [ "$input" == "do" ]
	then 
		# UNIX COMMAND SCRIPT ----------------------------------
		OIFS="$IFS"
		IFS=" "
		echo -n "$ "
		blanks=""
		read unix
		combined=$unix$blanks
		cmdarray=( $combined )
		"${cmdarray[@]}"
		#----------------------------------------------------------------
	elif [ "$input" == "f" ]
	then
		echo "Moving down to first directory (cd <first directory>)"
		down="$downprev"
		downprev="$downpprv"
		downpprv="$downpppv"
		cd $(ls -l | grep -m 1 "^d" | awk '{print $9}' )
		whereami
	elif [ "$input" == "d" ]
	then
		echo "Moving down a directory (cd $input)"
		cd "$down"
		whereami
	elif [ "$input" == "sink" ]
	then
		sink=$(cat ~/dropshiprepos/fav.path | awk '{print length, $0}' | egrep "$(pwd)" | cut -d " " -f2- | tail -1)
		echo "${sink//=/ }"
		cd "${sink//=/ }"
		whereami
	elif [ "$input" == "aa" ]
	then
		down=$(pwd)
		echo "Moving to home directory (cd ~/)"
		cd
		whereami	
	elif [ "$input" == "addprefixall" ]
	then
		echo "Enter prefix"
		read prefix
		n=0;
		for file in * 
		do 
			mv  "${file}" "${prefix}${file}"
			n=$((n+1))
		done
	elif [ "$input" == "run" ]
	then
		echo ""
		PS3="Type a number or 'q' to quit: "
		options=($(ls -l | egrep ^- | awk '{print $9}' | cut -c 1-20 |  xargs printf '%-24s\n' | sed '$p;N;s/\n//;$p;N;s/\n//;' | head -n -1))
		echo "./$opt"
		echo "Enter program arguments (optional): "
		select opt in "${options[@]}"
		do
			echo $opt
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				echo "Enter program arguments (optional): "
				read arguments
				cmdarray=( $arguments )
				./$opt "${cmdarray[@]}"
			fi
			whereami
			break
		done
		#select opt in "${options[@]}"
	elif [ "$input" == "flag" ]
	then	
		dir=$(pwd)
		flagdir=${dir// /=}
	
	elif [ "$input" == "tray" ]
	then
		dir=$(pwd)
		dir=${dir// /=}
		cd ~/dropshiprepos/Tray
		ls
		cd "${dir//=/ }"
	elif [ "$input" == "filltray" ]
	then
		echo -e "\e[1;94mEnter full or part of a file (directory) name to be copied:"
		echo -e "WARNING: 'pastetray' will remove all files in the tray.\e[0m"
		read filename
		cp *$filename* ~/dropshiprepos/Tray
		whereami
	elif [ "$input" == "cuttray" ]
	then
		echo -e "\e[1;94mEnter full or part of a file (directory) name to cut:"
		echo -e "WARNING: this will remove all files currently in the tray.\e[0m"
		read filename
		rm ~/dropshiprepos/Tray/*
		mv *$filename* ~/dropshiprepos/Tray
		whereami
	elif [ "$input" == "cleartray" ]
	then
		rm ~/dropshiprepos/Tray/*
	elif [ "$input" == "pastetray" ]
	then
		mv ~/dropshiprepos/Tray/* .
		whereami
	elif [ "$input" == "pasteremote" ]
	then
		#same as linkcomplete but with remote server directory (you must use beacon)	
		echo "username: (Enter to skip as h7shin)"
		read username
		echo "server: (Enter to skip as linux.student.cs.uwaterloo.ca)"
		read server
		echo "Path from remote home directory to dropship bash script (Must be Compatible with Version 5+ Check about) :"
		read path
		echo "Navigate to the directory in the remote server by SSH and type exit"
			
		if [ "$username" == "" ]
		then
			username="h7shin"
		fi
		if [ "$server" == "" ]
		then
			server="linux.student.cs.uwaterloo.ca"
		fi
		#echo "ssh $user@$server . xdropshipver5.sh;pwd"
		ssh -t $username@$server "cd $path;. xdropshipver5.sh;"
		scp $username@$server:~/dropshiprepos/last.path last_temp.path
		linkdir=$(cat last_temp.path)
		scp "${copyfrom//=/ }" $username@$server:"${linkdir}"
			
	elif [ "$input" == "copy" ]
	then
		PS3="Type a number or 'q' to quit: "
		options=($(ls -l | awk '{print $9}' ));#| cut -c 1-20 |  xargs printf '%-24s\n' | sed '$p;N;s/\n//;$p;N;s/\n//;' | head -n -1))
		select opt in "${options[@]}"
		do
			echo $opt
			dir=$(pwd)
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				copyfrom=${dir// /=}/${opt// /=}
			fi
			whereami
			break
		done
	elif [ "$input" == "paste" ]
	then
		if [[ $copyfrom = *[a-zA-Z0-9]* ]]
		then
			echo 'cp' ${copyfrom//=/ } './'
			cp "${copyfrom//=/ }" ./
		fi
		whereami
	elif [ "$input" == "copytext" ]
	then
		echo "Enter text to be copied"
		stty -echo
		read sensitive
		echo $sensitive > /dev/clipboard
		stty echo
		whereami
	elif [ "$input" == "copied" ]
	then
		cat /dev/clipboard
		stty echo
	elif [ "$input" == "xgoogle" ]
	then
		echo "Search web (Linux):"
		read web
		open "https://www.google.ca/search?q=${web}"
	elif [ "$input" == "google" ]
	then
		echo "Search web (Windows+Cygwin Only):"
		read web
		cygstart "https://www.google.ca/search?q=${web}"
	elif [ "$input" == "bookmarkthis" ]
	then
		echo "Enter file or web address"
		read address
		echo "$address" >> ~/dropshiprepos/bookmarks.path
	elif [ "$input" == "bookmarkclear" ]
	then 
		echo > ~/dropshiprepos/bookmarks.path
	elif [ "$input" == "bookmarks" ]
	then
		PS3="Type a number or 'q' to quit (must have 'open' program installed): "
		array_inputs=()
		while read arg
		do
			#echo $arg
			array_inputs+=( ${arg//[=]/'='} ) # string --> array
		done < ~/dropshiprepos/bookmarks.path
		select opt in "${array_inputs[@]}"
		do
			echo "${opt//=/ }"
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				echo "${opt//=/ }"
				open "${opt//=/ }" & # run program
			fi
			whereami
			break
		done		
	elif [ "$input" == "programclear" ]
	then
		echo > ~/dropshiprepos/programs.path
	elif [ "$input" == "programthis" ]
	then
		echo ""
		PS3="Type a number or 'q' to quit: "
		options=($(ls -l | egrep ^- | awk '{print $9}' | cut -c 1-20 |  xargs printf '%-24s\n' | sed '$p;N;s/\n//;$p;N;s/\n//;' | head -n -1))
		echo "./$opt"
		select opt in "${options[@]}"
		do
			echo $opt
			if [[ $opt == *[a-zA-Z0-9]* ]]
			then
				path="$(pwd)"
				echo "Enter program arguments (optional):"
				read arguments
				cmdarray=( $arguments )
				echo "${path// /=}/$opt ${cmdarray[@]}" >> ~/dropshiprepos/programs.path
			fi
			whereami
			break
		done
	elif [ "$input" == "programscmd" ]
	then
		PS3="Type a number or 'q' to quit: "
		array_inputs=()
		while read arg
		do
			#echo $arg
			array_inputs+=( ${arg//[=]/'='} ) # string --> array
		done < ~/dropshiprepos/programs.path
		select opt in "${array_inputs[@]}"
		do
			echo "${opt//=/ }"
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				echo "${opt//=/ }"
				"${opt//=/ }" # run program
			fi
			whereami
			break
		done
	elif [ "$input" == "programs" ]
	then
		PS3="Type a number or 'q' to quit: "
		array_inputs=()
		while read arg
		do
			#echo $arg
			array_inputs+=( ${arg//[=]/'='} ) # string --> array
		done < ~/dropshiprepos/programs.path
		select opt in "${array_inputs[@]}"
		do
			echo "${opt//=/ }"
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				echo "${opt//=/ }"
				"${opt//=/ }" & # run program
			fi
			whereami
			break
		done		
	elif [ "$input" == "favthis" ]
	then	
		path="$(pwd)"
		echo ${path// /=} >> ~/dropshiprepos/fav.path
	elif [ "$input" == "favclear" ]
	then
		echo > ~/dropshiprepos/fav.path
	elif [ "$input" == "favedit" ]
	then
		vi ~/dropshiprepos/fav.path
	elif [ "$input" == "tags" ]
	then
		while  read output; do
			echo ${output//^/   }
		done <  ~/dropshiprepos/tags.txt
	elif [ "$input" == "tagedit" ]
	then
		vi ~/dropshiprepos/tags.txt
	elif [ "$input" == "tagclear" ]
	then
		echo "" > ~/dropshiprepos/tags.txt	
	elif [ "$input" == "tagthis" ]
	then
		echo "Set up a tag for this directory:"
		read tag
		thispath=$(pwd)
		echo "$tag^${thispath// /=}" >> ~/dropshiprepos/tags.txt
		whereami
	elif [ "$input" == "importx" ]
	then
		array_tags=()
		array_dirs=()
		while read arg
		do
			#echo ${arg//=/' '}
			i=$(echo ${arg//\^/' '} | awk '{print $1}')
			j=$(echo ${arg//\^/' '} | awk '{print $2}')
			echo $i "..." $j
			echo -ne '\n'
			array_tags+=( $i ) # string --> array
			array_dirs+=( $j ) # string --> array
		done < ~/dropshiprepos/tags.txt
		i=0
		for tag in "${array_tags[@]}"
		do
			echo $tag
			echo "${array_dirs[$i]}<---"
			dir="${array_dirs[$i]}"
			mkdir "${dir//=/ }" 2> /dev/null
			mv ~/dropshiprepos/DownloadStore/*$tag*  "${dir//=/ }" 2> /dev/null
			i=$(($i+1))
			
		done
		whereami
	elif [ "$input" == "downloads" ]
	then
		cd ~/dropshiprepos/DownloadStore
		whereami
	elif [ "$input" == "import" ]
	then
		echo "Enter full or part of a file (directory) name:"
		read filename
		PS3="Type a number or 'q' to quit: "
		options=($(find ~/dropshiprepos/DownloadStore -name "*$filename*"))
		#echo "${options[@]}"
		select opt in "${options[@]}"
		do
			echo $opt
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				mv "${opt//=/ }" .
			fi
			whereami
			break
		done
	elif [ "$input" == "copytofav" ]
	then
		echo "\e[1;94mEnter directory you wish to copy\e[0m"
		read copieddir
		PS3="Type a number (destination directory) or 'q' to quit: "
		array_inputs=()
		while read arg
		do
			#echo $arg
			array_inputs+=( ${arg//[ ]/'='} ) # string --> array
		done < ~/dropshiprepos/fav.path
		select opt in "${array_inputs[@]}"
		do
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				dir=$opt
			fi
			whereami
			break
		done
		cp -r ./$copieddir "${dir//=/ }"
	elif [ "$input" == "lookup" ]
	then
		echo -e "\e[1;94mEnter full or part of a file (directory) name:\e[0m"
		read filename
		PS3="Type a number or 'q' to quit: "
		options=($(find . -name "*$filename*"))
		#echo "${options[@]}"
		select opt in "${options[@]}"
		do
			echo $opt
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				cd "${opt//=/ }"
			fi
			whereami
			break
		done
	elif [ "$input" == "search" ]
	then
		echo -e "\e[1;94msearch: \e[0m\c"
		read query;
		array_inputs=()
		PS3="Type a number or 'q' to quit: "
		while read arg
		do
			#echo $arg
			array_inputs+=( ${arg//[ ]/'='} ) # string --> array
		done < ~/dropshiprepos/fav.path	
		
		searched_locs=(  )
		
		# SEARCH IN FAVOURITES --------------------------------------
		match=0
		for i in "${array_inputs[@]}"
		do
		   lines=$(ls "${i//=/ }" | egrep ".*$query.*" | wc -l )
		  
		   if [ "$lines" -gt 0 ]
		   then
				echo "$lines match(es) in $i "
				echo ""
				searched_locs+=( $i )
				match=$(($match + 1))
		   fi
		done
		echo "Directories with matched files in favourites: $match"
		# SEARCH IN HISTORY  ---------------------------------
		array_inputs=()
		while read arg
		do
			#echo $arg
			array_inputs+=( ${arg//[ ]/'='} ) # string --> array
		done < ~/dropshiprepos/hist.path	
		
		if [ "$match" -eq 0 ] 
		then
			echo "Not found in favourites... Checking history..."
			for i in "${array_inputs[@]}"
			do
			   lines=$(ls "${i//=/ }" | egrep ".*$query.*" | wc -l )
			  
			   if [ "$lines" -gt 0 ]
			   then
					echo "$lines match(es) in $i "
					echo ""
					searched_locs+=( $i )
					match=$(($match + 1))
			   fi
			done
		fi
		if [ "$match" -eq 0 ] 
		then
			echo "No match found in history."
		fi
		select opt in "${searched_locs[@]}"
		do
			echo $opt
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				echo "${opt//=/ }"
				cd "${opt//=/ }"
			fi
			whereami
			break
			searched_locs=(  )
		done
	elif [ "$input" == "favs" ]
	then	
		PS3="Type a number or 'q' to quit: "
		array_inputs=()
		while read arg
		do
			#echo $arg
			array_inputs+=( ${arg//[=]/'='} ) # string --> array
		done < ~/dropshiprepos/fav.path
		select opt in "${array_inputs[@]}"
		do
			echo "${opt//=/ }"
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				echo "${opt//=/ }"
				cd "${opt//=/ }"
			fi
			whereami
			break
		done
	elif [ "$input" == "goback" ]
	then	
		cd "${flagdir//=/ }"
		whereami
	elif [ "$input" == "pop" ]
	then
		get "${pwd//=/ }"
	elif [ "$input" == "show" ]
	then
		echo ""
		PS3="Type a number or 'q' to quit: "
		options=($(ls -l | egrep ^d | awk '{print $9}' |  xargs printf '%-24s\n' | sed '$p;N;s/\n//;$p;N;s/\n//;' | head -n -1))
		select opt in "${options[@]}"
		do
			echo $opt
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				get "${opt//=/ }"
			fi
			whereami
			break
		done
		#select opt in "${options[@]}"
	elif [ "$input" == "zipfiles" ]
	then
		echo "Enter full or part of a file (directory) name to cut:"
		read filename
		mydir=$(mktemp -dt "tempfolderXXXXXXXX")
		echo $mydir
		cp *$filename* $mydir
		zip -j $filename.zip $mydir
		rm -r $mydir
	elif [ "$input" == "zipsourcecode" ]
	then
		echo "Enter project name:"
		read prjname
		mydir=$(mktemp -dt "tempfolderXXXXXXXX")
		echo $mydir
		cp *.cc $mydir
		cp *.h	$mydir
		zip -j $prjname.zip $mydir
		rm -r $mydir
	elif [ "$input" == "zip" ]
	then
		echo "Enter directory name to be zipped."
		PS3="Type a number or 'q' to quit: "
		options=($(ls -l | egrep ^d | awk '{print $9}' |  xargs printf '%-24s\n' | sed '$p;N;s/\n//;$p;N;s/\n//;' | head -n -1))
		select opt in "${options[@]}"
		do
			echo $opt
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				zip -r $opt.zip $opt
			fi
			whereami
			break
		done
		#select opt in "${options[@]}"
	elif [ "$input" == "p" ]
	then
		echo ""
		PS3="Type a number or 'q' to quit: "
		options=($(ls -l | egrep ^d | awk '{print $NF}' |  xargs printf '%-24s\n' | sed '$p;N;s/\n//;$p;N;s/\n//;' | head -n -1))
		select opt in "${options[@]}"
		do
			echo $opt
			if [[ $opt = *[a-zA-Z0-9]* ]]
			then
				cd $opt
			fi
			whereami
			break
		done
		#select opt in "${options[@]}"
	elif [ "$input" == "tree" ]
	then
		find . -maxdepth 2 -type d -print -not -name ".*" | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
		echo "..."
	elif [ "$input" == "repository" ]
	then
		cd ~/dropshiprepos
		whereami
	elif [ "$input" == "historyedit" ]
	then
		vi ~/dropshiprepos/hist.path
	elif [ "$input" == "history" ]
	then
		cat ~/dropshiprepos/hist.path
	elif [ "$input" == "historyoff" ]
	then
		historytracking="off"
		echo "History set to off"
		echo "history_off" > ~/dropshiprepos/history.opt
	elif [ "$input" == "historyon" ]
	then
		historytracking="on"
		echo "History set to on"
		echo "history_on"> ~/dropshiprepos/history.opt	
	elif [ "$input" == "clearhistory" ]
	then
		echo "Are you sure you want to delete the history? [type x to continue]"
		read response
		if [ "$response" == "x" ]
		then
			echo "" > ~/dropshiprepos/hist.path
		fi

	elif [ "$input" == "setlocalhost" ]
	then
		pwd > ~/dropshiprepos/localhostmacro.opt
	elif [ "$input" == "launch" ]
	then
		echo -ne "Filename (i.e. PHP): \c"
		read filename;
		dir=$(pwd)
		echo "http://${dir//$localhostmacro/localhost}/$filename"
		open "http://${dir//$localhostmacro/localhost}/$filename"
	elif [ "$input" == "create" ]
	then
		echo "Filename:"
		read filename
		echo "Input Contents of the File:"
		read contents
		echo $contents > $filename
	elif [ "$input" == "setstage" ]
	then
		linkdir=$(pwd)
		echo "This will be the primary stage, navigate into the directory where you want it to be the secondary stage"
		echo -e "then type 'linkstage'. If you want to link to the remote server directory then type 'linkremote' anywhere. \e[1;94m WARNING: \e[0m Once stage syncing is complete all of the files in the secondary
		stage will be overwritten with files from the first stage."
		
	elif [ "$input" == "stages" ]
	then
		cat ~/dropshiprepos/stage.txt
	elif [ "$input" == "linkstage" ]
	then
		linkdirscd=$(pwd)
		if [ $linkdir != "" ]; then
			echo "${linkdir// /=}^${linkdirscd// /=}" >> ~/dropshiprepos/stage.txt
		fi
		echo "Link Completed!"
	elif [ "$input" == "editstages" ]
	then
		vi ~/dropshiprepos/stage.txt
	
	elif [ "$input" == "linkremote" ]
	then
		linkstages		
	elif [ "$input" == "syncstages" ]
	then
		syncstages
		whereami
	elif [ "$input" == "xvalgrind" ] 
	then
		g++ *.cc;
		valgrind --leak-check=full --show-reachable=yes ./a.out;
	elif [ "$input" == "x>" ] 
	then
		echo "Filename:"
		read filename
		echo "Contents:"
		read contents
		echo "$contents" > "$filename"
	elif [ "$input" == "goout" ]
	then
		exit 0
	elif [ "$input" == "exit" ]
	then
		exit 0
	else 
		
		dir=$(ls -l | grep "^d" | grep -m 1 "$input" | awk '{print $9}' )
		potentialdirpath=$(echo ./*/$input )
		potentialdirpath=${potentialdirpath//"$input "/"$input[space]"} #protecting the real space
		potentialdirpath=${potentialdirpath// /=}
		potentialdirpath=${potentialdirpath//"$input[space]"/"$input "}
		potentialdirpath=$(echo "$potentialdirpath" | awk '{print $1}' )
		if [[ $dir == *[a-z0-9]* ]]; then
			echo "Nothing found, opening directory with related name!"
			echo DIR:$dir
			cd $dir
			whereami		
		elif [[ -d ${potentialdirpath//=/ } ]]; then
			cd ./*/$input
			whereami
		else
			#echo "..."
			#echo ${potentialdirpath//=/ } 
			#echo "..."
			echo "Nothing found, executing UNIX Command"
			cmdarray=( $input )
			j=0
			counter=0
			filteredarray=()
			for i in "${cmdarray[@]}"; do
				if [ $i == "|" ]; then
					j+=1
					counter=0
				else 
					if [ $counter -gt 0 ]; then
						filteredarray[$j]+="===$i"
					else
						filteredarray[$j]="$i"
					fi
					counter+=1
				fi
			done
			# no execute commands with pipes inserted between
			init=$j
			ha=()
			while [ $j -ge 0 ]; do
				diff=$(($init-$j))
				ha+=( "${filteredarray[$diff]}" )
				j=$(($j-1));
			done
			if [ $init -eq 0 ]; then
				${ha[0]//===/ }
			elif  [ $init -eq 1 ]; then	
				${ha[0]//===/ } | ${ha[1]//===/ }
			elif  [ $init -eq 2 ]; then
				${ha[0]//===/ } | ${ha[1]//===/ } | ${ha[2]//===/ }	
			elif  [ $init -eq 3 ]; then
				${ha[0]//===/ } | ${ha[1]//===/ } | ${ha[2]//===/ }	| ${ha[3]//===/ }
			elif  [ $init -eq 4 ]; then
				${ha[0]//===/ } | ${ha[1]//===/ } | ${ha[2]//===/ }	| ${ha[3]//===/ }	| ${ha[4]//===/ }	
			elif  [ $init -eq 5 ]; then
				${ha[0]//===/ } | ${ha[1]//===/ } | ${ha[2]//===/ }	| ${ha[3]//===/ }	| ${ha[4]//===/ }	| ${ha[5]//===/ }	
			elif  [ $init -eq 6 ]; then
				${ha[0]//===/ } | ${ha[1]//===/ } | ${ha[2]//===/ }	| ${ha[3]//===/ }	| ${ha[4]//===/ }	| ${ha[5]//===/ }	| ${ha[6]//===/ }	
			fi
		fi
	fi
	lastinput=$input
	#clear
	 
	
	#-----------------PATH HISTORY UPDATE-------------------
	mkdir ~/dropshiprepos 2> /dev/null
	pathc="$(pwd)"
	pathc="${pathc// /=}"
	numfound=0
	if [ -f $FILE ]
	then
		numfound=$(cat ~/dropshiprepos/hist.path | egrep "^$pathc$" | wc -l)
	fi
	if [ $numfound -eq 0 ]
	then
		if [ $historytracking != "off" ]
		then
			echo "New Path Explored (history tracking: $historytracking )..." 
			echo ${pathc// /=} >> ~/dropshiprepos/hist.path
		fi
	fi
	echo ${pathc// /=} >  ~/dropshiprepos/last.path
done

