# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`puppetboard`](#puppetboard): Base class for Puppetboard. Sets up the user and python environment.
* [`puppetboard::apache::conf`](#puppetboard--apache--conf): Creates an entry in your apache configuration directory to run PuppetBoard server-wide (i.e. not in a vhost).
* [`puppetboard::apache::vhost`](#puppetboard--apache--vhost): Sets up an apache::vhost to run PuppetBoard, and writes an appropriate wsgi.py from template

### Data types

* [`Puppetboard::Syslogpriority`](#Puppetboard--Syslogpriority): type for the different Python log levels

## Classes

### <a name="puppetboard"></a>`puppetboard`

class { 'puppetboard':
   user  => 'pboard',
   group => 'pboard',
   basedir => '/www/puppetboard'
 } ->
 class { 'puppetboard::apache::conf':
   user  => 'pboard',
   group => 'pboard',
   basedir => '/www/puppetboard'
 }

#### Examples

##### 

```puppet
configure puppetboard with an apache config for a subpath (http://$fqdn/puppetboard)
```

#### Parameters

The following parameters are available in the `puppetboard` class:

* [`install_from`](#-puppetboard--install_from)
* [`user`](#-puppetboard--user)
* [`homedir`](#-puppetboard--homedir)
* [`group`](#-puppetboard--group)
* [`groups`](#-puppetboard--groups)
* [`basedir`](#-puppetboard--basedir)
* [`git_source`](#-puppetboard--git_source)
* [`puppetdb_host`](#-puppetboard--puppetdb_host)
* [`puppetdb_port`](#-puppetboard--puppetdb_port)
* [`puppetdb_key`](#-puppetboard--puppetdb_key)
* [`puppetdb_ssl_verify`](#-puppetboard--puppetdb_ssl_verify)
* [`puppetdb_cert`](#-puppetboard--puppetdb_cert)
* [`puppetdb_timeout`](#-puppetboard--puppetdb_timeout)
* [`unresponsive`](#-puppetboard--unresponsive)
* [`enable_catalog`](#-puppetboard--enable_catalog)
* [`enable_query`](#-puppetboard--enable_query)
* [`offline_mode`](#-puppetboard--offline_mode)
* [`localise_timestamp`](#-puppetboard--localise_timestamp)
* [`python_loglevel`](#-puppetboard--python_loglevel)
* [`python_proxy`](#-puppetboard--python_proxy)
* [`python_index`](#-puppetboard--python_index)
* [`python_systempkgs`](#-puppetboard--python_systempkgs)
* [`default_environment`](#-puppetboard--default_environment)
* [`revision`](#-puppetboard--revision)
* [`version`](#-puppetboard--version)
* [`use_pre_releases`](#-puppetboard--use_pre_releases)
* [`manage_git`](#-puppetboard--manage_git)
* [`manage_virtualenv`](#-puppetboard--manage_virtualenv)
* [`python_version`](#-puppetboard--python_version)
* [`virtualenv_dir`](#-puppetboard--virtualenv_dir)
* [`manage_user`](#-puppetboard--manage_user)
* [`manage_group`](#-puppetboard--manage_group)
* [`package_name`](#-puppetboard--package_name)
* [`manage_selinux`](#-puppetboard--manage_selinux)
* [`reports_count`](#-puppetboard--reports_count)
* [`settings_file`](#-puppetboard--settings_file)
* [`extra_settings`](#-puppetboard--extra_settings)
* [`override`](#-puppetboard--override)
* [`enable_ldap_auth`](#-puppetboard--enable_ldap_auth)
* [`ldap_require_group`](#-puppetboard--ldap_require_group)
* [`apache_confd`](#-puppetboard--apache_confd)
* [`apache_service`](#-puppetboard--apache_service)
* [`secret_key`](#-puppetboard--secret_key)

##### <a name="-puppetboard--install_from"></a>`install_from`

Data type: `Enum['package', 'pip', 'vcsrepo']`

Specify how the app should be installed

Default value: `'pip'`

##### <a name="-puppetboard--user"></a>`user`

Data type: `String`

Puppetboard system user.

Default value: `'puppetboard'`

##### <a name="-puppetboard--homedir"></a>`homedir`

Data type: `Optional[Stdlib::Absolutepath]`

Puppetboard system user's home directory.

Default value: `undef`

##### <a name="-puppetboard--group"></a>`group`

Data type: `String`

Puppetboard system group.

Default value: `'puppetboard'`

##### <a name="-puppetboard--groups"></a>`groups`

Data type: `Optional[Variant[String[1], Array[String[1]]]]`

additional groups for the user that runs puppetboard

Default value: `undef`

##### <a name="-puppetboard--basedir"></a>`basedir`

Data type: `Stdlib::AbsolutePath`

Base directory where to build puppetboard vcsrepo and python virtualenv.

Default value: `'/srv/puppetboard'`

##### <a name="-puppetboard--git_source"></a>`git_source`

Data type: `String`

Location of upstream Puppetboard GIT repository

Default value: `'https://github.com/voxpupuli/puppetboard'`

##### <a name="-puppetboard--puppetdb_host"></a>`puppetdb_host`

Data type: `String`

PuppetDB Host

Default value: `'127.0.0.1'`

##### <a name="-puppetboard--puppetdb_port"></a>`puppetdb_port`

Data type: `Stdlib::Port`

PuppetDB Port

Default value: `8080`

##### <a name="-puppetboard--puppetdb_key"></a>`puppetdb_key`

Data type: `Optional[Stdlib::AbsolutePath]`

path to PuppetMaster/CA signed client SSL key

Default value: `undef`

##### <a name="-puppetboard--puppetdb_ssl_verify"></a>`puppetdb_ssl_verify`

Data type: `Variant[Boolean, Stdlib::AbsolutePath]`

whether PuppetDB uses SSL or not (true or false), or the path to the puppet CA

Default value: `false`

##### <a name="-puppetboard--puppetdb_cert"></a>`puppetdb_cert`

Data type: `Optional[Stdlib::AbsolutePath]`

path to PuppetMaster/CA signed client SSL cert

Default value: `undef`

##### <a name="-puppetboard--puppetdb_timeout"></a>`puppetdb_timeout`

Data type: `Integer[0]`

timeout, in seconds, for connecting to PuppetDB

Default value: `20`

##### <a name="-puppetboard--unresponsive"></a>`unresponsive`

Data type: `Integer[0]`

number of hours after which a node is considered "unresponsive"

Default value: `3`

##### <a name="-puppetboard--enable_catalog"></a>`enable_catalog`

Data type: `Boolean`

Whether to allow the user to browser catalog comparisons.

Default value: `false`

##### <a name="-puppetboard--enable_query"></a>`enable_query`

Data type: `Boolean`

Whether to allow the user to run raw queries against PuppetDB.

Default value: `true`

##### <a name="-puppetboard--offline_mode"></a>`offline_mode`

Data type: `Boolean`

Weather to load static assents (jquery, semantic-ui, tablesorter, etc)

Default value: `false`

##### <a name="-puppetboard--localise_timestamp"></a>`localise_timestamp`

Data type: `Boolean`

Whether to localise the timestamps in the UI.

Default value: `true`

##### <a name="-puppetboard--python_loglevel"></a>`python_loglevel`

Data type: `Puppetboard::Syslogpriority`

Python logging module log level.

Default value: `'info'`

##### <a name="-puppetboard--python_proxy"></a>`python_proxy`

Data type: `Optional[String[1]]`

HTTP proxy server to use for pip/virtualenv.

Default value: `undef`

##### <a name="-puppetboard--python_index"></a>`python_index`

Data type: `Optional[String[1]]`

HTTP index server to use for pip/virtualenv.

Default value: `undef`

##### <a name="-puppetboard--python_systempkgs"></a>`python_systempkgs`

Data type: `Boolean`

Python system packages available in virtualenv.

Default value: `false`

##### <a name="-puppetboard--default_environment"></a>`default_environment`

Data type: `String[1]`

set the default environment

Default value: `'production'`

##### <a name="-puppetboard--revision"></a>`revision`

Data type: `Optional[String]`

Commit, tag, or branch from Puppetboard's Git repo to be used

Default value: `undef`

##### <a name="-puppetboard--version"></a>`version`

Data type: `Variant[Enum['latest'], String[1]]`

PyPI package version to be installed

Default value: `'latest'`

##### <a name="-puppetboard--use_pre_releases"></a>`use_pre_releases`

Data type: `Boolean`

if version is set to 'latest', then should pre-releases be used too?

Default value: `false`

##### <a name="-puppetboard--manage_git"></a>`manage_git`

Data type: `Boolean`

If true, require the git package. If false do nothing.

Default value: `false`

##### <a name="-puppetboard--manage_virtualenv"></a>`manage_virtualenv`

Data type: `Boolean`

If true, require the virtualenv package. If false do nothing.

Default value: `false`

##### <a name="-puppetboard--python_version"></a>`python_version`

Data type: `Pattern[/^3\.\d+$/]`

Python version to use in virtualenv.

##### <a name="-puppetboard--virtualenv_dir"></a>`virtualenv_dir`

Data type: `Stdlib::Absolutepath`

Set location where virtualenv will be installed

Default value: `"${basedir}/virtenv-puppetboard"`

##### <a name="-puppetboard--manage_user"></a>`manage_user`

Data type: `Boolean`

If true, manage (create) this group. If false do nothing.

Default value: `true`

##### <a name="-puppetboard--manage_group"></a>`manage_group`

Data type: `Boolean`

If true, manage (create) this group. If false do nothing.

Default value: `true`

##### <a name="-puppetboard--package_name"></a>`package_name`

Data type: `Optional[String[1]]`

Name of the package to install puppetboard

Default value: `undef`

##### <a name="-puppetboard--manage_selinux"></a>`manage_selinux`

Data type: `Boolean`

If true, manage selinux policies for puppetboard. If false do nothing.

Default value: `pick($facts['os.selinux.enabled'], false)`

##### <a name="-puppetboard--reports_count"></a>`reports_count`

Data type: `Integer[0]`

This is the number of reports that we want the dashboard to display.

Default value: `10`

##### <a name="-puppetboard--settings_file"></a>`settings_file`

Data type: `Stdlib::Absolutepath`

Path to puppetboard configuration file

Default value: `"${basedir}/puppetboard/settings.py"`

##### <a name="-puppetboard--extra_settings"></a>`extra_settings`

Data type: `Hash`

Defaults to an empty hash '{}'. Used to pass in arbitrary key/value

Default value: `{}`

##### <a name="-puppetboard--override"></a>`override`

Data type: `Variant[Array[String[1]], String[1]]`

Sets the Apache AllowOverride value

Default value: `['None']`

##### <a name="-puppetboard--enable_ldap_auth"></a>`enable_ldap_auth`

Data type: `Boolean`

Whether to enable LDAP auth

Default value: `false`

##### <a name="-puppetboard--ldap_require_group"></a>`ldap_require_group`

Data type: `Boolean`

LDAP group to require on login

Default value: `false`

##### <a name="-puppetboard--apache_confd"></a>`apache_confd`

Data type: `Stdlib::Absolutepath`

path to the apache2 vhost directory

##### <a name="-puppetboard--apache_service"></a>`apache_service`

Data type: `String[1]`

name of the apache2 service

##### <a name="-puppetboard--secret_key"></a>`secret_key`

Data type: `Optional[String[1]]`

used for CSRF prevention and more. It should be a long, secret string, the same for all instances of the app. Required since Puppetboard 5.0.0.

Default value: `undef`

### <a name="puppetboard--apache--conf"></a>`puppetboard::apache::conf`

Creates an entry in your apache configuration directory to run PuppetBoard server-wide (i.e. not in a vhost).

* **Note** Make sure you have purge_configs set to false in your apache class!

#### Parameters

The following parameters are available in the `puppetboard::apache::conf` class:

* [`wsgi_alias`](#-puppetboard--apache--conf--wsgi_alias)
* [`threads`](#-puppetboard--apache--conf--threads)
* [`max_reqs`](#-puppetboard--apache--conf--max_reqs)
* [`user`](#-puppetboard--apache--conf--user)
* [`group`](#-puppetboard--apache--conf--group)
* [`basedir`](#-puppetboard--apache--conf--basedir)
* [`enable_ldap_auth`](#-puppetboard--apache--conf--enable_ldap_auth)
* [`ldap_bind_dn`](#-puppetboard--apache--conf--ldap_bind_dn)
* [`ldap_bind_password`](#-puppetboard--apache--conf--ldap_bind_password)
* [`ldap_url`](#-puppetboard--apache--conf--ldap_url)
* [`ldap_bind_authoritative`](#-puppetboard--apache--conf--ldap_bind_authoritative)
* [`ldap_require_group`](#-puppetboard--apache--conf--ldap_require_group)
* [`ldap_require_group_dn`](#-puppetboard--apache--conf--ldap_require_group_dn)
* [`virtualenv_dir`](#-puppetboard--apache--conf--virtualenv_dir)

##### <a name="-puppetboard--apache--conf--wsgi_alias"></a>`wsgi_alias`

Data type: `Stdlib::Unixpath`

WSGI script alias source

Default value: `'/puppetboard'`

##### <a name="-puppetboard--apache--conf--threads"></a>`threads`

Data type: `Integer[1]`

Number of WSGI threads to use

Default value: `5`

##### <a name="-puppetboard--apache--conf--max_reqs"></a>`max_reqs`

Data type: `Integer[0]`

Limit on number of requests allowed to daemon process Defaults to 0 (no limit)

Default value: `0`

##### <a name="-puppetboard--apache--conf--user"></a>`user`

Data type: `String[1]`

WSGI daemon process user, and daemon process name

Default value: `$puppetboard::user`

##### <a name="-puppetboard--apache--conf--group"></a>`group`

Data type: `String[1]`

WSGI daemon process group owner, and daemon process group

Default value: `$puppetboard::group`

##### <a name="-puppetboard--apache--conf--basedir"></a>`basedir`

Data type: `Stdlib::AbsolutePath`

Base directory where to build puppetboard vcsrepo and python virtualenv.

Default value: `$puppetboard::basedir`

##### <a name="-puppetboard--apache--conf--enable_ldap_auth"></a>`enable_ldap_auth`

Data type: `Boolean`

Whether to enable LDAP auth

Default value: `$puppetboard::enable_ldap_auth`

##### <a name="-puppetboard--apache--conf--ldap_bind_dn"></a>`ldap_bind_dn`

Data type: `Optional[String[1]]`

LDAP Bind DN

Default value: `undef`

##### <a name="-puppetboard--apache--conf--ldap_bind_password"></a>`ldap_bind_password`

Data type: `Optional[String[1]]`

LDAP password

Default value: `undef`

##### <a name="-puppetboard--apache--conf--ldap_url"></a>`ldap_url`

Data type: `Optional[String[1]]`

LDAP connection string

Default value: `undef`

##### <a name="-puppetboard--apache--conf--ldap_bind_authoritative"></a>`ldap_bind_authoritative`

Data type: `Optional[String[1]]`

Determines if other authentication providers are used when a user can be mapped to a DN but the server cannot bind with the credentials

Default value: `undef`

##### <a name="-puppetboard--apache--conf--ldap_require_group"></a>`ldap_require_group`

Data type: `Boolean`

LDAP group to require on login

Default value: `$puppetboard::ldap_require_group`

##### <a name="-puppetboard--apache--conf--ldap_require_group_dn"></a>`ldap_require_group_dn`

Data type: `Optional[String[1]]`

LDAP group DN for LDAP group

Default value: `undef`

##### <a name="-puppetboard--apache--conf--virtualenv_dir"></a>`virtualenv_dir`

Data type: `Stdlib::Absolutepath`

Set location where virtualenv will be installed

Default value: `$puppetboard::virtualenv_dir`

### <a name="puppetboard--apache--vhost"></a>`puppetboard::apache::vhost`

Sets up an apache::vhost to run PuppetBoard, and writes an appropriate wsgi.py from template

#### Parameters

The following parameters are available in the `puppetboard::apache::vhost` class:

* [`vhost_name`](#-puppetboard--apache--vhost--vhost_name)
* [`wsgi_alias`](#-puppetboard--apache--vhost--wsgi_alias)
* [`ip`](#-puppetboard--apache--vhost--ip)
* [`port`](#-puppetboard--apache--vhost--port)
* [`ssl`](#-puppetboard--apache--vhost--ssl)
* [`ssl_cert`](#-puppetboard--apache--vhost--ssl_cert)
* [`ssl_key`](#-puppetboard--apache--vhost--ssl_key)
* [`ssl_chain`](#-puppetboard--apache--vhost--ssl_chain)
* [`threads`](#-puppetboard--apache--vhost--threads)
* [`user`](#-puppetboard--apache--vhost--user)
* [`group`](#-puppetboard--apache--vhost--group)
* [`basedir`](#-puppetboard--apache--vhost--basedir)
* [`override`](#-puppetboard--apache--vhost--override)
* [`enable_ldap_auth`](#-puppetboard--apache--vhost--enable_ldap_auth)
* [`ldap_bind_dn`](#-puppetboard--apache--vhost--ldap_bind_dn)
* [`ldap_bind_password`](#-puppetboard--apache--vhost--ldap_bind_password)
* [`ldap_url`](#-puppetboard--apache--vhost--ldap_url)
* [`ldap_bind_authoritative`](#-puppetboard--apache--vhost--ldap_bind_authoritative)
* [`ldap_require_group`](#-puppetboard--apache--vhost--ldap_require_group)
* [`ldap_require_group_dn`](#-puppetboard--apache--vhost--ldap_require_group_dn)
* [`virtualenv_dir`](#-puppetboard--apache--vhost--virtualenv_dir)
* [`custom_apache_parameters`](#-puppetboard--apache--vhost--custom_apache_parameters)

##### <a name="-puppetboard--apache--vhost--vhost_name"></a>`vhost_name`

Data type: `String[1]`

The vhost ServerName.

##### <a name="-puppetboard--apache--vhost--wsgi_alias"></a>`wsgi_alias`

Data type: `Stdlib::Unixpath`

WSGI script alias source

Default value: `'/'`

##### <a name="-puppetboard--apache--vhost--ip"></a>`ip`

Data type: `Optional[Stdlib::IP::Address]`

IP for the vhost to bind to

Default value: `undef`

##### <a name="-puppetboard--apache--vhost--port"></a>`port`

Data type: `Stdlib::Port`

Port for the vhost to listen on.

Default value: `5000`

##### <a name="-puppetboard--apache--vhost--ssl"></a>`ssl`

Data type: `Boolean`

If vhost should be configured with ssl

Default value: `false`

##### <a name="-puppetboard--apache--vhost--ssl_cert"></a>`ssl_cert`

Data type: `Optional[Stdlib::AbsolutePath]`

Path to server SSL cert

Default value: `undef`

##### <a name="-puppetboard--apache--vhost--ssl_key"></a>`ssl_key`

Data type: `Optional[Stdlib::AbsolutePath]`

Path to server SSL key

Default value: `undef`

##### <a name="-puppetboard--apache--vhost--ssl_chain"></a>`ssl_chain`

Data type: `Optional[Stdlib::AbsolutePath]`

Path to server CA Chain file

Default value: `undef`

##### <a name="-puppetboard--apache--vhost--threads"></a>`threads`

Data type: `Integer[1]`

Number of WSGI threads to use.

Default value: `5`

##### <a name="-puppetboard--apache--vhost--user"></a>`user`

Data type: `String[1]`

WSGI daemon process user, and daemon process name

Default value: `$puppetboard::user`

##### <a name="-puppetboard--apache--vhost--group"></a>`group`

Data type: `String[1]`

WSGI daemon process group owner, and daemon process group

Default value: `$puppetboard::group`

##### <a name="-puppetboard--apache--vhost--basedir"></a>`basedir`

Data type: `Stdlib::AbsolutePath`

Base directory where to build puppetboard vcsrepo and python virtualenv.

Default value: `$puppetboard::basedir`

##### <a name="-puppetboard--apache--vhost--override"></a>`override`

Data type: `Variant[Array[String[1]], String[1]]`

Sets the Apache AllowOverride value

Default value: `$puppetboard::override`

##### <a name="-puppetboard--apache--vhost--enable_ldap_auth"></a>`enable_ldap_auth`

Data type: `Boolean`

Whether to enable LDAP auth

Default value: `$puppetboard::enable_ldap_auth`

##### <a name="-puppetboard--apache--vhost--ldap_bind_dn"></a>`ldap_bind_dn`

Data type: `Optional[String[1]]`

LDAP Bind DN

Default value: `undef`

##### <a name="-puppetboard--apache--vhost--ldap_bind_password"></a>`ldap_bind_password`

Data type: `Optional[String[1]]`

LDAP password

Default value: `undef`

##### <a name="-puppetboard--apache--vhost--ldap_url"></a>`ldap_url`

Data type: `Optional[String[1]]`

LDAP connection string

Default value: `undef`

##### <a name="-puppetboard--apache--vhost--ldap_bind_authoritative"></a>`ldap_bind_authoritative`

Data type: `Optional[String[1]]`

Determines if other authentication providers are used when a user can be mapped to a DN but the server cannot bind with the credentials

Default value: `undef`

##### <a name="-puppetboard--apache--vhost--ldap_require_group"></a>`ldap_require_group`

Data type: `Boolean`

LDAP group to require on login

Default value: `$puppetboard::ldap_require_group`

##### <a name="-puppetboard--apache--vhost--ldap_require_group_dn"></a>`ldap_require_group_dn`

Data type: `Optional[String[1]]`

LDAP group DN for LDAP group

Default value: `undef`

##### <a name="-puppetboard--apache--vhost--virtualenv_dir"></a>`virtualenv_dir`

Data type: `Stdlib::Absolutepath`

Set location where virtualenv will be installed

Default value: `$puppetboard::virtualenv_dir`

##### <a name="-puppetboard--apache--vhost--custom_apache_parameters"></a>`custom_apache_parameters`

Data type: `Hash`

A hash passed to the `apache::vhost` for custom settings

Default value: `{}`

## Data types

### <a name="Puppetboard--Syslogpriority"></a>`Puppetboard::Syslogpriority`

type for the different Python log levels

Alias of `Enum['debug', 'info', 'notice', 'warning', 'err', 'crit', 'alert', 'emerg']`
