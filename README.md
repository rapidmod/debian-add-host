# debian-add-host
Add a host to debian optionally install Wordpress and activate SSL With Let's Encrypt

## Important:
Let's Encrypt requires user input and it is not recommended to run this command on cron

# Install:
```cp addsite.sh /usr/bin/addsite```

```cp DOMAINNAME.conf /etc/apache2/sites-available/DOMAINNAME.conf```

```chmod 0755 /usr/bin/addsite```

# Usage:
### Domain
```sudo addsite domain.com```

### Domain + Wordpress
```sudo addsite domain.com 1```

### Domain + Wordpress + Lets Encrypt
```sudo addsite domain.com 1 1```

### Domain + Lets Encrypt
```sudo addsite domain.com 0 1```
