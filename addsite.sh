#!/usr/bin/env bash
DOMAIN=$1
DIR="/var/www/${DOMAIN}"
PUBLIC="${DIR}/public"
if [[ ! -d $DIR ]]; then
    mkdir -p $PUBLIC
fi
if [[ ! -d $PUBLIC ]]; then
    echo "couldnt create directory: ${PUBLIC}"
  #  exit 1
fi


if [[ "${2}" == "1" ]]; then
    echo "Installing Wordpress"
    if [[  -d $PUBLIC ]]; then
    echo "Removong Public Directory ${PUBLIC}"
       /bin/rm -rf  $PUBLIC
    fi
    /usr/bin/wget http://wordpress.org/latest.tar.gz -O "${DIR}/latest.tar.gz"
    echo "Finished Downloading"
    /bin/tar xfz "${DIR}/latest.tar.gz"
    echo "FINISHED Unzipping"
    /bin/mv "${DIR}/wordpress" "${DIR}/public"
    echo "Finished Moving to /public"
    /bin/rm -f "${DIR}/latest.tar.gz"
    echo "Finished re Moving tar"
    if [[ ! -e "${PUBLIC}/wp-config-sample.php" ]]; then
        echo "Wordpress Not Installed"
        exit 1
    fi
    echo "Done Installing Wordpress."
    echo "Dont forget to set up the database."
  #  exit 1
fi
chown -Rf www-data:www-data $PUBLIC
chmod -Rf 0755 $PUBLIC

if [[ ! -e "/etc/apache2/sites-available/${DOMAIN}.conf" ]]; then
    /bin/cp "/etc/apache2/sites-available/DOMAINNAME.conf" "/etc/apache2/sites-available/${DOMAIN}.conf"
    /bin/sed -i -e "s/:DOMAINNAME:/${DOMAIN}/g" "/etc/apache2/sites-available/${DOMAIN}.conf"
  #  exit 1
fi

if [[  -e "/etc/apache2/sites-available/${DOMAIN}.conf" ]]; then
    /usr/sbin/a2ensite $DOMAIN
    service apache2 reload
fi

if [[ "${3}" == 1 ]]; then
    /usr/bin/certbot --apache -d $DOMAIN
fi
