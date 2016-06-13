# Redfish Lab Contents
This lab purpose is to explore Redfish and become familiar with the standard as well as the extensions provided by the HPE RESTful API on HPE ProLiant servers via multiple toolsets.

## Lab Writers and Trainers
Francois.Donze@hpe.com
Bruno.Cornec@hpe.com
Rene.ribaud@hpe.com

<!--- [comment]: # Table of Content to be added --->

## Objectives of the Redfish Lab
At the end of the Lab students should be able to navigate through the various Refish fields, understand the differences between what is in the standard and the possible OEM additions, use the appropriate tools to control servers equiped with such a standard either through a Web Browser, a CLI tool or programmatically.

This Lab is intended to be trial and error so that during the session students should understand really what is behind the environment, instead of blindly following instructions, which never teach people anything IMHO. You've been warned ;-)

This Lab presents five means for retrieving and setting parameters from and to an HPE ProLiant server via the HP RESTful API. You can work with
1. A web browser with the associated extension
2. The free to use HPE hprest tool
3. wget / curl tools
4. PowerShell commands
5. A python script

The following exercises are proposed for each method:

1. Get Properties
2. Set a property and/or perform an action

Expected duration : 120 minutes

## Prerequisite knowledge

Attendees must be familiar with the following technologies:
  - **HTTP** basics
  - **Linux commands** and utilities
  - The **vi** or **nano** editors

Having some knowledge in the following technologies might also help:
  - UEFI in HP ProLiant Gen9 servers
  - Linux shells and scripting
  - Python scripting
  - PowerShell scripting

Of course, in case you're less familiar with these technologies, the Lab is still doable, just ask for help to your instructors in order to avoid being stuck on a related topic.

## Reference documents

This lab intends to be a **complement** (not a substitute) to the following public documents:
  - Managing HP Servers Using the HP RESTful API
  - HP RESTful API Data model Reference for iLO4
  - Information library: Select HP UEFI System Utilities and HP RESTful Interface Tool
  - UEFI Shell specifications (Useful for writing shell scripts)
  - HP RESTful Interface Tool
  - Youtube: HP RESTful API overview
  - Youtube: search for “HP ProLiant UEFI”. Several videos are available

When dealing with the Redfish standard, the first approach is to look at the reference Web site http://redfish.dmtf.org/ 

Estimated time for the lab is placed in front of each part.

# Environment setup
Estimated time: 20 minutes

## Client setup

This Lab supposes that your client machine will run a Windows OS. If you're lucky to have a Linux one, don't worry as the instructions also apply to it as well.

Before starting the lab exercises, your client station must be installed with the following:
1. The Firefox browser with the HttpRequester extension. NOTE: Google Chrome with the Postman extension can be used as well. However, screen snapshots in this Lab have been performed with HttpRequester as this extension is easier to install in non-connected environments.
2. An SSH client (PuTTY on Windows clients is OK)

For the rest of this Lab, each team has received a lab number (**X**) from the instructor, and we'll refer to your server as **labX**. It has the following characteristics:
  - iLO IP: 10.3.222.100+X (login: demopaq - password: password)
  - Server IP: 10.3.222.80+X) (login: root - password: linux1)

Test first your connectivity to the iLO of your server labX with the SSH protocol. If you don't know what it means, ask your instructor.
Answer Yes to the Security Alert (if needed)
If the login is successful, exit from the iLO:

`</>hpilo->` **`exit`**

Then test the access to your OS (a preinstalled RHEL 7 Linux distribution)
Answer Yes to the confirmation query
If the login is successful, exit from the system:

`#` **`exit`**

Finally test and set your browser:
Open the Firefox browser (if not already done) and set it as your default browser, if asked, on Windows. If you don’t see the following double arrow icon in the top right corner, notify the instructor.

From Firefox, open a session toward the iLO of your server at http://10.3.222.10X
If needed, click on Advanced and then on Add Exception… then Confirm Security Exception:

Log into the iLO. Your server should be in the OFF state. If not, warn the instructor.

By default, modern browsers block Insecure Contents and packets coming from the iLO via the Remote Console are considered as such. 
In the main central pane, click on the .Net link:

Click on the upper left locker/warning icon and then on the > sign and click on Disable protection for now:

Click again on the .NET link. Push the RUN button of Security Warning popups if any. The console window should now be appear.

Of course, you don't need to do that on Linux ;-)

## REST and Redfish introduction

## REST definition

Wikipedia says: “Representational State Transfer (REST) is a software architecture style consisting of guidelines […] for creating scalable web services […] REST [is] a simpler alternative to SOAP and WSDL-based web services.

RESTful systems typically, but not always communicate over the Hypertext Transfer Protocol with the same verbs (GET, POST, PUT, DELETE…) used by web browsers…”

## Redfish definition

“Redfish is an open industry standard specification and schema that specifies a RESTful interface and utilizes JSON and OData to help customers integrate solutions within their existing tool chains.”

Hewlett Packard Enterprise started to implement its own iLO RESTful API before the Redfish 1.0 specification is published. Today iLO 4 based ProLiant servers host both the legacy iLO RESTful API and a Redfish 1.0 compliant implementation.

This hands on lab focuses on the Redfish implementation but mentions how you can switch back to the legacy iLO RESTful API.

## Web browser and REST client

Although REST is primarily used via Application Programming Interfaces (APIs), it is possible to test and debug RESTful systems with a web browser and an associated extension. The extension is used to build the correct https packets (headers, payload…) and to display nicely (or not) returned answers in different formats (JSON, XML, raw...). 

If you need to use a browser different from Firefox or Chrome, make sure its associated extension supports the PATCH verb/method, in addition to GET and POST. The PATCH method is a proposed standard (RFC 5789) and is required by the redfish specifications.

Now that your setup and some introduction has been done, let's start experimenting with Redfish

# Using Redfish
Estimated time: 60 minutes.

## 
