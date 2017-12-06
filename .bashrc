# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# override vim
if [ -e /usr/local/bin/nvim ]; then 
	alias vim='/usr/local/bin/nvim'; 
elif [ -e /usr/bin/nvim ]; then 
	alias vim='/usr/bin/nvim'; 
elif [ -e /usr/bin/vimx ]; then 
	alias vim='/usr/bin/vimx';
fi

#source /usr/share/git-core/contrib/completion/git-prompt.sh
set -o vi
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
#if [ $UID -ne 0 ]; then
#	UFSHOME=$HOME
#else
#	if [ -d "/home/bcapener" ]; 
#	then
#		UFSHOME=/home/bcpener
#	else
#		UFSHOME=/home/ufs
#	fi
#fi

if [ -d "$HOME/projects/validation/MIST" ]; 
then
	workspace=$HOME/projects/validation
else
	workspace=$HOME/workspace
fi

pyufs=$HOME/projects/pyufs
pyPath="" #"/usr/lib64/python2.7/site-packages/:/usr/lib64/python2.7/site-packages/gtk-2.0/"
#export PYTHONPATH="${PYTHONPATH}:${pyPath}:$workspace/:$workspace/MIST/:$pyufs/:$pyufs/ufs/"
export PYTHONPATH="${pyPath}:$workspace/:$workspace/MIST/:$pyufs/:$pyufs/ufs/"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias sudo='sudo '

export http_proxy=http://proxy.micron.com:8080/
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxy=$http_proxy
# export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
# Add below to sudo config (via visudo) to keep proxy settings through sudo. 
# "Defaults env_keep += "http_proxy https_proxy ftp_proxy""

##########
## grep ##
##########
# i=case-insensitive
# n=print line number
# I=skip binary files
# E=treat pattern as posix extended reg ex
# r=recursive
# --exclude={}
alias grepy="grep -nIr --color=ALWAYS --exclude-dir={.svn,.git,release,obj}"
alias gittree='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'

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
# export PS1="$txtgry[\t] $txtblu\u$txtgry@$txtblu\h $txtgry[$txtylw\w$txtgry]$(declare -F __git_ps1 &>/dev/null && __git_ps1 " (%s)")\n$tput_bold$txtgrn:>$tput_sgr0 "

# if user is not root, pass all commands via sudo #
if [ $UID -ne 0 ]; then
	alias reboot='sudo reboot'
	alias yumup='sudo yum update'
fi

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
alias uartdrvoff="sudo rmmod /opt/sigsw/el7/modules/sig_axiuart.ko"
alias uartdrvstatus="lsmod | grep sig_axiuart"
alias unlockSLCR='/opt/sig_ufsdrv/bin/bar_reader.py -d 1344:11f0 -l -e -o 0x03c00078 -v 0x0d'
alias resetFPGA='/opt/sig_ufsdrv/bin/bar_reader.py -d 1344:11f0 -l -e -o 0x03c00078 -v 0x0c'
alias restartHercules='unlockSLCR && resetFPGA && sleep 5 && sudo /sbin/shutdown -r now'
alias resherc=restartHercules

# DMX
alias verdmx='rpm -q dmx'
alias uninstalldmx='verdmx; sudo rpm -e $(verdmx); verdmx'
installdmx() { sudo rpm -i $1; echo $(verdmx);}
alias update='/usr/bin/python ~/boiseufs/fw_drivers/hercules_update.py'

# SIG_UFSDRV
alias verdrv='rpm -q sig_ufsdrv'
alias trace="python /usr/bin/ufs_trace_tool.py -c"
alias ftrace='python ~/boiseufs/users/bcapener/scripts/trace_filter.py'
traceout() { trace > ~/boiseufs/users/bcapener/traces_outputs/$1.trace; }
alias link='trace | grep link'
alias restartd="sudo systemctl restart sig_ufsdrv"
alias res="restartd; sleep 1s; ftrace; echo"
alias eres="killpy; echo; echo '[Restarting sig_ufsdrv]'; restartd; sleep 1s; ftrace; echo; echo '[Current Reference Clock]'; refclk; echo"
alias restart2="restartd; sleep 1s; trace; refclk"
alias status='sudo systemctl status sig_ufsdrv'
alias stop='sudo systemctl stop sig_ufsdrv; status'
alias start='sudo systemctl start sig_ufsdrv; ftrace'
rdp() {
	echo 'Ctrl-Alt-Enter to toggle fullscreen mode'; 
	if [ -z "$1" ]; then
		echo "please pass in username."
		return 1
	fi
	if ! xfreerdp -z --disable-wallpaper -u $1 -a 32 -g workarea $1; then
		echo 'freerdp might not be installed: sudo yum install freerdp'; 
	fi
}

alias fwuart='xterm -hold -e "minicom -D /dev/ttyAUL0" &'

alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc;source ~/.bashrc'
alias inputrc='vim ~/.inputrc'

alias template='/usr/bin/python $workspace/MIST/templates/t_template_UFS.py startupReconfig=False'
alias ctemplate='/usr/bin/python $workspace/MIST/templates/t_template_UFS.py startupReconfig=True'
alias debug='/usr/bin/python $workspace/MIST/scripts/t_DEBUG.py'
alias fw='/usr/bin/python $workspace/MIST/scripts/FirmwareUpdater.py'
alias ateflow='/usr/bin/python $workspace/MIST/scripts/t_AteFlow.py'
alias clone='/usr/bin/python $workspace/MIST/scripts/UfsCloneTool.py'
alias udr='/usr/bin/python $workspace/MIST/scripts/UfsDeviceReport.py logFilePath=~/boiseufs/users/bcapener/device_reports/'
alias report='udr'
alias builddtfw='cd $HOME/projects/ufskmldtfw/Build/ && /usr/bin/python BuildDtfw.py'
alias buildbe='/home/ufs/projects/ufskmlfw/master/Build/create_BEMain.sh 4x B16A SM2752 DTFW && cp -v /home/ufs/projects/ufskmlfw/master/Build/BinaryTool/ISP-2752.smi /home/ufs/boiseufs/users/bcapener/tmp/ISP_2752_BEMain.smi '
#alias builddtfw='$HOME/projects/ufskmldtfw/Build/create_BEMain.sh 4x B16A SM2752 DTFW && cp -v $HOME/projects/ufskmldtfw/Build/BinaryTool/ISP-2752.smi $workspace/MIST/lib/UFS/Leo/ISP_2752_BEMain.smi'
alias builddtfwdbg='$HOME/projects/ufskmldtfw/Build/create_BEMain.sh 4x B16A SM2752 DTFWDBG && cp -v $HOME/projects/ufskmldtfw/Build/BinaryTool/ISP-2752.smi $workspace/MIST/lib/UFS/Leo/ISP_2752_BEMain.smi'
alias buildbedbg='/home/ufs/projects/ufskmlfw/master/Build/create_BEMain.sh 4x B16A SM2752 DTFWDBG && cp -v /home/ufs/projects/ufskmlfw/master/Build/BinaryTool/ISP-2752.smi /home/ufs/boiseufs/users/bcapener/tmp/ISP_2752_BEMain.smi '
alias loadbe='cp -v $HOME/boiseufs/users/bcapener/tmp/ISP_2752_BEMain.smi $workspace/MIST/lib/UFS/Leo/ && fw product=jf9d config=False mpflowmode=0 mpflow=True choose=False fwName=ISP_2752_BEMain.smi skipExitMpFlow=True'
alias loadbeserial='cp -v $HOME/boiseufs/users/bcapener/tmp/ISP_2752_BEMain.smi $workspace/MIST/lib/UFS/Leo/ && fw product=jf9d config=False mpflowmode=2 serial=True dtfw=True choose=False fwName=ISP_2752_BEMain.smi'
alias loaddtfw='fw product=jf9d config=False mpflowmode=2 serial=True dtfw=True choose=False fwName=ISP_2752_BEMain.smi'
alias makebe='buildbe && sshpass -p "bufs" ssh bcapener@gallifrey -t bash -ci loadbe'
alias makebe2='buildbe && sshpass -p "ufs" ssh ufs@boiufs102 -t bash -ci loadbe'
alias uartsnoop='/usr/bin/python $HOME/boiseufs/users/bcapener/scripts/UartSnooper.py'

# Print info
printf 'UFS Driver:      %s\n' $(verdrv)
printf 'UFS DMX:         %s\n' $(verdmx)
printf 'Reference Clock: %s\n' $(refclk)
printf 'UFS Library:     %s\n' $workspace
echo
