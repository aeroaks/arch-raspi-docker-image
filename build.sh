#!/bin/bash

uid=`id -u`

if [ ${uid} -ne 0 ]; then
	echo "This script requires root privilege."
	echo "Please run as root user".
	exit -1
fi

function download_arch-bootstrap_script() {
	curl -O https://raw.githubusercontent.com/yannayl/arch-bootstrap/master/arch-bootstrap.sh
	if [ $? -ne 0 ]; then
		echo "Failed to download arch-bootstrap.sh."
		exit -1
	fi

	chmod 755 arch-bootstrap.sh
}

function install_wget() {
	which wget >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		pacman --noconfirm --sync wget
		if [ $? -ne 0 ]; then
			echo "Failed to install wget"
			exit -1
		fi
	fi
}

build_tmp_dir="build_tmp"
result_dir="bootstrap"
bootstrap_tarfile="bootstrap.tar.xz"

function remove_old_dir() {
	if [ -d ${build_tmp_dir} ]; then
		rm -fr ${build_tmp_dir}
	fi

	if [ -d ${result_dir} ]; then
		rm -fr ${result_dir}
	fi
	
	if [ -f ${bootstrap_tarfile} ]; then
		rm -fr ${bootstrap_tarfile}
	fi
}

function create_bootstrap() {
	if [ ! -d ${build_tmp_dir} ]; then
		mkdir ${build_tmp_dir}
	fi

	./arch-bootstrap.sh -a arm -r http://mirror.archlinuxarm.org -d ${build_tmp_dir} ${result_dir}
	if [ $? -ne 0 ]; then
		echo "Faild to create bootstrap image"
		exit -1
	fi
}

function make_bootstrap_tar_file() {
	if [ -f ${bootstrap_tarfile} ]; then
		rm -f ${bootstrap_tarfile}
	fi

	cd ${result_dir}

	tar cJvf ../${bootstrap_tarfile} .
	if [ $? -ne 0 ]; then
		"echo Failed to create bootstrap tar file"
		exit -1
	fi
}


remove_old_dir
download_arch-bootstrap_script
install_wget
create_bootstrap
make_bootstrap_tar_file

exit 0

