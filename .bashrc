# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# workspace=$HOME/workspace
workspace=$HOME/PycharmProjects/UFS_Validation
# mist=$workspace/MIST/
# orionfw=$mist/lib/UFS/Orion/
pyPath="/usr/lib64/python2.7/site-packages/:/usr/lib64/python2.7/site-packages/gtk-2.0/"
export PYTHONPATH="${PYTHONPATH}:${pyPath}:$workspace/:$workspace/MIST/"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export http_proxy=http://proxy.micron.com:8080/
export https_proxY=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxY=$http_proxy
# export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

# - Regular - #
txtblk='\[\e[0;30m\]' # Black
txtred='\[\e[0;31m\]' # Red
#txtgrn='\[\e[0;32m\]' # Green
#txtylw='\[\e[0;33m\]' # Yellow
#txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
#txtwht='\[\e[0;37m\]' # White
txtgry='\[\e[38;5;244m\]' # Gray
txtblu='\[\e[38;5;27m\]' # blue
txtylw='\[\e[38;5;11m\]' # yellow
txtgrn='\[\e[38;5;2m\]'  # green
txtwht='\[\e[38;5;15m\]' # white
# - Bold - #
bldblk='\[\e[1;30m\]' # Black
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
# - End Coloring - #
END="\[\e[0m\]"
tput_sgr0='\[$(tput sgr0)\]'
tput_bold='\[$(tput bold)\]'

# \A : the current time in 24-hour HH:MM format
# \W : the basename of the current working directory
# \u : the username of the current user
# \n : newline
export PS1="$txtgry[\t] $txtblu\u$txtgry@$txtblu\h $txtgry[$txtylw\w$txtgry]\n$tput_bold$txtgrn:>$tput_sgr0 "

alias ll="ls -lha"
alias pip='sudo -E pip'

alias psudo='sudo -HE env PATH=$PATH PYTHONPATH=$PYTHONPATH /usr/bin/python'

# Python Process
alias pspy='ps aux | grep python'
alias killpy='echo "[Before Killing Python]"; pspy; echo "[Killing]"; sudo pkill -9 python; echo "[After Killing Python]"; pspy'

# REF_CLK
declare -A refclknames=( [00000000]='19.2MHz' [00000001]='26MHz' [00000002]='38.4MHz' [00000003]='52MHz' )
alias refclkr="sudo /opt/sig_ufsdrv/bin/bar_reader.py -d 1344:11f0 -e -l -o 0x3c0006c"
alias refclk='echo ${refclknames[$(refclkr)]}'
alias refclk19="sudo /opt/sig_ufsdrv/bin/bar_reader.py -d 1344:11f0 -e -l -o 0x3c0006c -v 0; refclk"
alias refclk26="sudo /opt/sig_ufsdrv/bin/bar_reader.py -d 1344:11f0 -e -l -o 0x3c0006c -v 1; refclk"
alias refclk38="sudo /opt/sig_ufsdrv/bin/bar_reader.py -d 1344:11f0 -e -l -o 0x3c0006c -v 2; refclk"
alias refclk52="sudo /opt/sig_ufsdrv/bin/bar_reader.py -d 1344:11f0 -e -l -o 0x3c0006c -v 3; refclk"

# DUT
alias duton="sudo /opt/sig_ufsdrv/bin/dut_power on"
alias dutoff="sudo /opt/sig_ufsdrv/bin/dut_power off"
alias dutcycle="dutoff; sleep 1s; duton"
alias dmerestartcold="ufs_trace_tool.py -t DM_IOCTL_LINK_RESTART_COLD"
alias uarton="sudo /opt/sig_ufsdrv/bin/bar_reader.py -d 1344:11f0 -e -l -o 0x3c00078 -v 0x10; dutcycle"
alias uartoff="sudo /opt/sig_ufsdrv/bin/bar_reader.py -d 1344:11f0 -e -l -o 0x3c00078 -v 0x110; dmerestartcold"
alias uartstatus="sudo /opt/sig_ufsdrv/bin/bar_reader.py -d 1344:11f0 -e -l -o 0x3c00078"
alias uartdrvon="sudo insmod /opt/sigsw/el7/modules/sig_axiuart.ko"
alias uartdrvstatus="lsmod | grep sig_axiuart"

# DMX
alias verdmx='rpm -q dmx'
alias uninstalldmx='verdmx; sudo rpm -e $(verdmx); verdmx'
installdmx() { sudo rpm -i $1; echo $(verdmx);}
updatedmx() { uninstalldmx; sleep 1s; installdmx $1;}

# SIG_UFSDRV
alias verdrv='rpm -q sig_ufsdrv'
alias trace="python /usr/bin/ufs_trace_tool.py -c"
traceout() { trace > ~/boiseufs/User_Folders/Individual_Folders/bcapener/traces_outputs/$1.trace; }
alias link='trace | grep link'
alias restartd="sudo systemctl restart sig_ufsdrv"
alias ufsrestart="killpy; echo; echo '[Restarting sig_ufsdrv]'; restartd; sleep 1s; trace; echo; echo '[Current Reference Clock]'; refclk; echo"
alias restart="restartd; sleep 1s; trace; refclk"
alias ufsstatus='sudo systemctl status sig_ufsdrv'
alias ufsstop='sudo systemctl stop sig_ufsdrv; ufsstatus'
alias ufsstart='sudo systemctl start sig_ufsdrv; trace; ufsstatus'
alias ufson='ufsstart'
alias ufsoff='ufsstop'
alias uninstalldrv='sudo yum remove sig_ufsdrv'

updatedrv() { 
	if [$1 == '']; then
		sudo yum install sig_ufsdrv; 
	else
		sudo yum install sig_ufsdrv-$1; 
	fi
}

installdrv() { 
	if [$1 == '']; then
		sudo yum install sig_ufsdrv; 
	else
		sudo yum install sig_ufsdrv-$1; 
	fi
}
downgradedrv() { sudo yum downgrade sig_ufsdrv-$1; }

base() {

	num="${1^^}"
	if [[ $1 == 0x* || $1 == 0X* ]]; then
		#printf 'DEC: %d\n' $1
		dec=$(bc <<< "obase=10;ibase=16;${num#"0X"}")
		#echo $dec
	elif [[ $1 == 0b* || $1 == 0B* ]]; then
		dec=$(bc <<< "obase=10;ibase=2;${num#"0B"}")
		#echo 'obase=2;$1' | bc
	elif [[ $1 == 0o* || $1 == 0O* ]]; then
		dec=$(bc <<< "obase=10;ibase=8;${num#"0O"}")
	else
		#printf 'HEX: 0x%x\n' $1
		dec=$1
	fi
	printf 'DEC: %d\n' $dec
	printf 'HEX: 0x%x\n' $dec
	#printf 'BIN: 0b%s\n' 'obase=2;$dec' | bc #$dec
	printf 'OCT: 0o%o\n' $dec
}


bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'

alias template='/usr/bin/python $workspace/MIST/templates/t_template_UFS.py startupReconfig=False |less -S'
alias ctemplate='/usr/bin/python $workspace/MIST/templates/t_template_UFS.py startupReconfig=True'

fw_search_str="l_HostVersionInfo \|FirmwareUpdater \|Test Result: \|l_VuCmd \|l_VuLookUpTable \|l_VuCmdTranslate \|Current configuration descriptor matches \|Writing configuration descriptor"
alias mpflow='/usr/bin/python $workspace/MIST/scripts/FirmwareUpdater.py mpflow=True config=True choose=True | tee ~/tlastrun.log | grep "$fw_search_str";'
# mpflow() {
	# search_str="l_HostVersionInfo \|FirmwareUpdater \|Test Result: \|l_VuCmd \|l_VuLookUpTable \|l_VuCmdTranslate \|Current configuration descriptor matches \|Writing configuration descriptor"
	# if [$1 == '']; then
		# /usr/bin/python $workspace/MIST/scripts/FirmwareUpdater.py mpflow=True config=True choose=True | tee ~/tlastrun.log | grep "$search_str"; 
	# else
		# /usr/bin/python $workspace/MIST/scripts/FirmwareUpdater.py mpflow=True config=True fwName=$1 | tee ~/tlastrun.log | grep "$search_str"; 
	# fi
# }

# Print info
printf 'UFS Driver:      %s\n' $(verdrv)
printf 'UFS DMX:         %s\n' $(verdmx)
printf 'Reference Clock: %s\n' $(refclk)
echo
