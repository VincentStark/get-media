## Overview

The system for distributed downloading of media content from popular video
sites, such as Vimeo, YouTube, or VKontakte.

Central host sends download URLs to the Collectors, which perform actual
download task and provide direct links to downloaded content. Collectors
communicate with the Core using SOAP/WSDL.

Web-based management interface allows having multiple users with multiple
content queues.

The system consists of the following components:

* Core. Ruby-on-Rails MVC application, with a special SOAP API exposed to the
  collectors.

* Web Interface. Is a subset of Core. Provides UI for users and system
  administrators.

* Collectors. Perl daemons responsible for downloading the content, and for
  providing information to the Core.

Central Host is a place where Core and Web Interface are deployed. The
Central Host connects to one or more Collectors, and typically one of them is
deployed locally.

## License

This software is released under the [MIT License](http://opensource.org/licenses/MIT).

Copyright (c) 2013 vst42
