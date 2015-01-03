#!/bin/bash
# This script will download rpms and append the extend-compute.xml file on rocks.
cp /export/rocks/install/site-profiles/6.1.1/nodes/extend-compute.xml /root/extend-compute/extend-compute.xml.bak
echo -n "Enter the name of the package to add: "
read package
PS3='Please Select Repo: '
options=("default" "base" "epel" "Other"  "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "default")
            /usr/bin/yumdownloader --destdir=/state/partition1/rocks/install/contrib/6.1.1/x86_64/RPMS $package &&  /bin/sed -i '/package-script*/ a\<package>'$package'</package>' /export/rocks/install/site-profiles/6.1.1/nodes/extend-compute.xml
	    break
	    ;;
        "base")
            /usr/bin/yumdownloader --enablerepo=base --destdir=/state/partition1/rocks/install/contrib/6.1.1/x86_64/RPMS $package && /bin/sed -i '/package-script*/ a\<package>'$package'</package>' /export/rocks/install/site-profiles/6.1.1/nodes/extend-compute.xml
            break
            ;;
        "epel")
            /usr/bin/yumdownloader --enablerepo=epel --destdir=/state/partition1/rocks/install/contrib/6.1.1/x86_64/RPMS $package && /bin/sed -i '/package-script*/ a\<package>'$package'</package>' /export/rocks/install/site-profiles/6.1.1/nodes/extend-compute.xml
            break
            ;;
	"Other")
	    echo -n "Insert repo to use: "
	    read repo
            /usr/bin/yumdownloader --enablerepo=$repo --destdir=/state/partition1/rocks/install/contrib/6.1.1/x86_64/RPMS $package && /bin/sed -i '/package-script*/ a\<package>'$package'</package>' /export/rocks/install/site-profiles/6.1.1/nodes/extend-compute.xml
            break
	    ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

