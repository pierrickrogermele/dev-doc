WEB
===

## MIME types

 * [IANA | MIME Media Types](http://www.iana.org/assignments/media-types/).
 * [W3Schools Online Web Tutorials](http://www.w3schools.com/).
 * [XML Schema Checking Service](http://www.w3.org/2001/03/webdata/xsv).

## WEB Browsers

### IE

#### F12 DEVELOPER TOOLS
Pressing F12 inside IE, opens a window that allows to change many configuration options about the page display, included the version of the display engine (IE8, IE9 or IE10).

#### Virtual machines with different versions of IE
http://www.microsoft.com/downloads/details.aspx?FamilyId=21EABB90-958F-4B64-B5F1-73D0A413C8EF&displaylang=en

packages contain .vhd files that can be converted with qemu-img program.

### Links

 * [Links user manual](http://links.twibright.com/user_en.html).

### Lynx

 * [Lynx users guide](http://lynx.invisible-island.net/lynx_help/Lynx_users_guide.html).

Open page
```bash
lynx www.mypage.com
```
Or press "G" key inside lynx

#### Debugging

Turning on log output
```bash
lynx -trace ...
```
Log is written inside Lynx.trace file.

#### Config file

First lynx reads the common config file (On MacOS-X brew install: /usr/local/Cellar/lynx/2.8.8/etc/lynx.cfg)

Force cfg file
```bash
lynx -cfg my_file
```

#### Print configuration
```bash
lynx -show_cfg
```

Setting option value in config file:
```
character_set=utf-8
```
For a comment use #.

#### Key commands

Key       | Description
--------- | --------------------------------
`G`       | Open link.
`UP/DOWN` | Move up and down inside a page.
`LEFT`    | Back to previous page.
`RIGHT`   | Follow link.
`SPACE`   | Move down in a page.
`CTRL-R`  | Reload current page.

### W3M

Open a link:
```bash
w3m www.lemonde.fr
```

Cookie:
```bash
w3m -cookie ...
```
Don't work perfectly with cookies. Doesn't recognize/accept cookies of www.mediapart.fr for instance.

Commands:

Key      | Description
-------- | ----------------------------------------------------
`l`      | Cursor right.
`h`      | Cursor left. Cursor pad also works.
`j`      | Cursor down.
`k`      | Cursor up.
`SPC`    | Go forward one screen of page
`b`      | Go back one screen of page
`:`      | Toggle auto detection of URLs (http://...):
`B`      | Go backward (previous opened page)
`RET`    | Follow link.
`TAB`    | Next link.
`ESC TAB`| Previous link.

## WEB Servers

### Apache

#### MacOS-X

To start:
```bash
sudo apachectl start
```

Configuration file path is `/etc/apache2/httpd.conf`.

Root path is usually (see value of `DocumentRoot` in `httpd.conf`):
`/Library/WebServer/Documents`

The following rootpath is used by the Apple OS-X Server:
`/Library/Server/Web/Data/Sites/Default`

To enable PHP, edit httpd.conf and find the line:
```
LoadModule php7_module libexec/apache2/libphp7.so
```
Uncomment it.

In Server->Web: if there's only one Web Site which points to /var/empty, then look for `0000_any_80_.conf` file in `/etc/apache2/sites`, and edit it.

 1. Set ServerAdmin email address.
 2. Set DocumentRoot to point to web site root path.
 3. Set Directory element to the web site root path.

In `/etc/apache2`, edit `httpd.conf`:

 1. Set ServerAdmin email address.
 2. Set DocumentRoot to point to web site root path.

Then restart the apache service:
```bash
sudo apachectl restart
```

The main file `/etc/apache2/httpd.conf` includes `/etc/apache2/sites/0000_any_80_.conf`. So settings can be overwritten in this file.

To use Apache from Homebrew, see [macOS 10.14 Mojave Apache Setup: Multiple PHP Versions](https://getgrav.org/blog/macos-mojave-apache-multiple-php-versions).

#### Log files

On macos, the log files are in `/var/log/apache2`.

#### Alias

Add an alias (`http://localhost/myalias`) to a path situated outside `DocumentRoot`:
```apache
Alias /myalias "/Users/someuser/dev/my/project/site"
```

For the alias to work, the target directory needs to be declared in a `Directory` element.
In Apache 2.2:
```apache
<Directory "/Users/someuser/dev/my/project/site">
	Options FollowSymLinks
	AllowOverride all
	Order allow,deny
	Allow from all
</Directory>
```

In Apache 2.4:
```apache
<Directory "/Users/pierrick/dev/exhalobase/site">
	AllowOverride all
	Options Indexes FollowSymLinks
	Require all granted
</Directory>
```

Make sure that the path `/Users/someuser/dev/my/project/site` is allowed for access by everyone, as well as the files contained in the folder.

#### Adding a user to httpd user file

```bash
htpasswd /etc/httpd/users <new user name>
```

Dans `httpd.conf`:
```apache
<Directory /var/www/html/upload>
    require user fichier
</Directory>
```

#### Create passwords file or add new user

```bash
htpasswd /var/www/passwords <user name>
```

Put `.htaccess` file in each directory you want to protect with following content:
```apache
AuthUserFile /var/www/passwords
AuthGroupFile /dev/null
AuthName "Restricted access"
AuthType Basic
<LIMIT GET POST>
Require valid-user
</LIMIT>
```

autres possibilité pour les restrictions et autorisations de la balise LIMIT:
Order Allow, Deny
Require user toto
Require user toto titi tata
Deny from all
Allow from .free.fr

#### Make Apache parse HTML files for PHP code

Add the following inside `70_mod_php5.conf` or `httpd.conf`:
```apache
AddType application/x-httpd-php .php .html
```
At the following place:
```apache
 <IfModule mod_mime.c>
    AddType application/x-httpd-php .php
    AddType application/x-httpd-php .phtml
    AddType application/x-httpd-php .php3
    AddType application/x-httpd-php .php4
    AddType application/x-httpd-php .php5
    AddType application/x-httpd-php-source .phps
  </IfModule>
```

#### Default file

```apache
DirectoryIndex index.php index.html index.phtml /erreurs/403.html
```
If no file is given (ex: http://teddy/) and no index file is found, then /erreurs/403.html is displayed.

Placer le fichier `/erreurs/403.html` à la racine. Ex si la racine du site web est `/var/www/localhost/htdocs`: `/var/www/localhost/htdocs/erreurs/403.html`.

#### Directory indexing

To allow listing of directory by web browser:
```apache
Options Indexes
```

### IIS

#### Installation

##### Installation de IIS 5.1 sous Windows XP
Installer le composant "Service Internet (IIS)" à partir de:
Panneau de configuration -> Ajouter ou supprimer des programmes -> Ajouter ou supprimer des composants Windows
Bien tout inclure pour IIS, tous les composants n'étant pas sélectionnés par défaut.

##### IIS 6.0

###### FastCGI
Go to the following link in order to install FastCGI module:
<http://www.iis.net/extensions/fastcgi>.

###### PHP 5.3
needs FastCGI
download VC6 non thread safe zip version
unzip inside C:\php
open terminal and type:
```dosbatch
cd %WINDIR%\system32\inetsrv
cscript fcgiconfig.js -add -section:"PHP" -extension:php -path:"C:\PHP\php-cgi.exe"
```

##### ENABLE OUTSIDE CONNECTIONS
GO TO control panel > firewall > advanced > network connection parameters > Parameters > Services
Now allow "Web Server".

##### SMTP server response: 550 5.7.1 Unable to relay - 
1) Go to: start > settings > control panel > Administrative Tools > Internet Information Services
2) Expand the " (local computer)" node
3) Right click on your SMTP server > go to "Properties"
4) Click "Access" tab
5) Under Relay Restrictions, click the "Relay" button
6) Click "Add"
7) Select "Single Computer" and enter IP address 127.0.0.1
8) Hit OK, OK, OK (until the properties dialog is closed)

#### PHP

##### Installating PHP under IIS 7 as FastCGI
Choose Non-Thread Safe version.
Install x86 version, because x64 version is experimental.
http://windows.php.net/downloads/releases/php-5.5.12-nts-Win32-VC11-x86.zip
This PHP package requires the proper VC++ runtime to execute:
http://www.microsoft.com/en-us/download/details.aspx?id=30679

See:
http://www.iis.net/learn/application-frameworks/install-and-configure-php-applications-on-iis/using-fastcgi-to-host-php-applications-on-iis
Copy C:/php/php.ini from php.ini-developement
Unset the following lines:
extension=php_gd2.dll           --> Enable GD Graphics library
extension=php_ldap.dll          --> Enable LDAP
extension_dir=ext               --> Directory for dynamically loadable extensions
Then go to IIS Console Manager (Config Panel --> System --> Admin Tools --> IIS)
	Select the Default Site
	Double click on Handler Mappings, then select Add Module Mapping... and fill in the form with the following data:
		Request path: *.php
		Module: FastCgiModule
		Executable: "C:\[Path to your PHP installation]\php-cgi.exe"
		Name: PHP via FastCGI

Test installation by opening http://localhost/phpinfo.php

##### Installation de PHP sous IIS
download at http://windows.php.net/download/
install PHP 5.2.10 VC6 x86 Thread Safe with the zip version.
extract all files in c:/php.
create c:/php/php.ini by copying c:/php/php.ini-recommended
enable the following extensions inside php.ini:
extension=php_gd2.dll
extension=php_ldap.dll

uncomment or set the line:
extension_dir=ext

Puis pour chaque site qui a besoin de PHP:
Aller sous la configuration IIS, cliquer droit sur le site web, et choisir "Propriétés":

1) "Répertoire virtuel"/"Répertoire" -> "Autorisations d'exécution" -> "Scripts seulement" (cliquer sur le bouton "Créer" si nécessaire).
     Configuration... -> Mappages :
	        Extension -> .php
	        Exécutable -> c:\php\php5isapi.dll
	        Moteur de script -> oui

2) "Documents" --> "Activer le document par défaut" --> Ajouter: "index.php"


Redémarrer l'ordinateur ou juste le service IIS pour prendre en compte les changements.

## Security

 * [Délibération n° 2017-012 du 19 janvier 2017 portant adoption d'une recommandation relative aux mots de passe](https://www.legifrance.gouv.fr/affichTexte.do?cidTexte=JORFTEXT000033928007).

## WEB Services

### SOAP

SOAP is a webservice protocol that uses XML InfoSet for its message format. It relies on HTTP and/or SMTP.
WSDL and UDDI were initially built on SOAP.

 * [SOAP page](https://en.wikipedia.org/wiki/SOAP) on Wikipedia.
 * <http://www.soapuser.com/>.

For transmitting large data (binary), the W3C has defined the Message Transmission Optimization Mechanism (MTOM).

#### APACHE AXIS2

http://projects.apache.org/projects/axis2.html
http://axis.apache.org/axis2/java/core/index.html

#### wsclient

With wsclient, one can test SOAP services on command line.

It's part of package WSF/C:
http://wso2.com/products/web-services-framework/c/

Write an request.xml file as follow:
```xml
<Envelope xmlns="http://server.climb.cea.fr">
  <Body>
    <connect>
      <args0>username</args0>
      <args1>password</args1>
    </connect>
  </Body>
</Envelope>
```

then run:
```bash
wsclient --soap --action connect http://localhost:8080/axis2/services/CLIMBServlet <request.xml
```

### WSDL

 * [WSDL page](https://en.wikipedia.org/wiki/Web_Services_Description_Language) on Wikipedia.

WSDL uses XML to describe the functionality offered by a web service.

WSDL is often used in combination with SOAP.

WSDL 2.0 is not widely provided in SDKs. WSDL 1.1 is much more common.

WSDL 2.0 accepts to bind to all HTTP request methods (not just GET and POST), and thus better support RESTful web services.

### REST

 * [REST page](https://en.wikipedia.org/wiki/Representational_state_transfer) on Wikipedia.

Representational State Transfer (REST) is a *software architecture style* for building scalable web services.

HTTP-based RESTful APIs are defined with these aspects:
 * base URI, such as `http://example.com/resources/`.
 * an Internet media type for the data. This is often JSON but can be any other valid Internet media type (e.g., XML, Atom, microformats, images, etc.)
 * standard HTTP methods (e.g., GET, PUT, POST, or DELETE)
 * hypertext links to reference state
 * hypertext links to reference-related resources[8]

### JSON

JSON, JavaScript Object Notation,  is an open standard format that uses human-readable text to transmit data objects consisting of attribute–value pairs.
It is the primary data format used for asynchronous browser/server communication (AJAJ), largely replacing XML (used by AJAX).

 * [JSON page](http://en.wikipedia.org/wiki/JSON) on Wikipedia.

JSON is a language-independent data format.
Code for parsing and generating JSON data is readily available in many programming languages.

Note: YAML version 1.2 is a superset of JSON.

### JETTY

<http://jetty.codehaus.org/jetty/>

Embedded HTTP server and servlet container.

### TOMCAT

#### Installating Tomcat 8 on MacOS-X

See <https://wolfpaulus.com/journal/mac/tomcat8/>, or `brew install tomcat`.

#### Start/stop Tomcat service

Under Windows:
	Start --> All Programs --> Apache Tomcat 7.0 --> Monitor Tomcat
	In the Systrem Tray right click on "Monitor Tomcat" and choose "Start service".

Under MacOS-X:
	`/usr/local/Cellar/tomcat/8.0.20/libexec/bin/startup.sh` for starting.
	`/usr/local/Cellar/tomcat/8.0.20/libexec/bin/shutdown.sh` for stopping.

Then open the page <http://localhost:8080> under your browser.

#### Tomcat manager
Web administration.
It requires a login/password.
See file tomcat-users.xml in <Tomcat>/conf directory, and add the role manager-gui to the user you want. This manager-gui role is required to access the Tomcat manager.

#### Embedded tomcat
Tomcat can be embedded.
http://stackoverflow.com/questions/640022/howto-embed-tomcat-6
