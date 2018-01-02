#--------------------------------------------
# One-step Docker VPN Server Setup
# author：jackie-1685@163.com
#--------------------------------------------
#!/bin/bash
echo "Start to install vpn server and its admin application"



# Load Linux af_key module
function loadAfKeyModule(){
	
	if lsmod | grep af_key &> /dev/null ; then
		echo "af_key module is alreay loaded!"
	else
		echo "loading af_key module"
		if sudo modprobe af_key; then
			echo "load af_key module successfully"
		else
			echo "load af_key module failed"
		fi
	fi
}

function startupDockerCompose(){
	if type docker-compose &> /dev/null; then
		echo "docker-compose is exist, starting up applications..."
	else 
		echo "docker-compose is not exist, download docker-compose image and starting up applications..."
		docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD:/rootfs/$PWD" -w="/rootfs/$PWD" docker/compose:1.18.0 up
	fi
}

loadAfKeyModule
startupDockerCompose