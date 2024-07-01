#!/bin/bash

# Oracle Database Installation Script
# This script assumes that the Oracle installation files have been downloaded and placed in the correct directory.

# Exit immediately if a command exits with a non-zero status.
set -e

# Variables
ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1
ORACLE_BASE=/u01/app/oracle
ORACLE_INVENTORY=/u01/app/oraInventory
ORACLE_SID=orcl
INSTALL_DIR=/path/to/your/oracle/install/files

# Update and install necessary packages
sudo yum update -y
sudo yum install -y bc binutils compat-libcap1 compat-libstdc++-33 gcc gcc-c++ glibc glibc-devel ksh libaio libaio-devel libX11 libXau libXi libXtst libXrender libXrender-devel make net-tools nfs-utils python python-configshell python-rtslib python-six smartmontools sysstat unzip

# Create Oracle directories
sudo mkdir -p $ORACLE_HOME
sudo mkdir -p $ORACLE_BASE
sudo mkdir -p $ORACLE_INVENTORY
sudo chown -R oracle:oinstall /u01
sudo chmod -R 775 /u01

# Set environment variables for Oracle user
echo "export ORACLE_BASE=$ORACLE_BASE" >> ~/.bash_profile
echo "export ORACLE_HOME=$ORACLE_HOME" >> ~/.bash_profile
echo "export ORACLE_SID=$ORACLE_SID" >> ~/.bash_profile
echo "export PATH=$PATH:$ORACLE_HOME/bin" >> ~/.bash_profile
source ~/.bash_profile

# Extract Oracle installation files
cd $INSTALL_DIR
unzip linuxx64_193000_db_home.zip -d $ORACLE_HOME

# Run Oracle installer in silent mode
cd $ORACLE_HOME
./runInstaller -silent -responseFile $ORACLE_HOME/install/response/db_install.rsp -waitforcompletion -ignorePrereqFailure

# Run root scripts
sudo $ORACLE_BASE/oraInventory/orainstRoot.sh
sudo $ORACLE_HOME/root.sh

# Create a listener
netca -silent -responseFile $ORACLE_HOME/network/install/netca_typ.rsp

# Create a database
dbca -silent -createDatabase -gdbName $ORACLE_SID -templateName General_Purpose.dbc -responseFile NO_VALUE -characterSet AL32UTF8 -memoryPercentage 40 -emConfiguration NONE

echo "Oracle Database installation and configuration completed successfully."
