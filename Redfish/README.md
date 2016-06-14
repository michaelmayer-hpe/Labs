# Redfish Lab Contents
This lab purpose is to explore Redfish and become familiar with the standard as well as the extensions provided by the HPE RESTful API on HPE ProLiant servers via multiple toolsets.

## Lab Writers and Trainers
  - Francois.Donze@hpe.com
  - Bruno.Cornec@hpe.com
  - Rene.Ribaud@hpe.com

<!--- [comment]: # Table of Content to be added --->

## Objectives of the Redfish Lab
At the end of the Lab students should be able to navigate through the various Refish fields, understand the differences between what is in the standard and the possible OEM additions, use the appropriate tools to control servers equiped with such a standard either through a Web Browser, a CLI tool or programmatically.

This Lab is intended to be trial and error so that during the session students should understand really what is behind the environment, instead of blindly following instructions, which never teach people anything IMHO. You've been warned ;-)

This Lab presents five means for retrieving and setting parameters from and to an HPE ProLiant server via the HPE RESTful API. You can work with:
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
  - UEFI in HPE ProLiant Gen9+ servers
  - Linux shells and scripting
  - Python scripting
  - PowerShell scripting

Of course, in case you're less familiar with these technologies, the Lab is still doable, just ask for help to your instructors in order to avoid being stuck on a related topic.

## Reference documents

This lab intends to be a **complement** (not a substitute) to the following public documents:
  - [Managing HPE Servers Using the HPE RESTful API](http://h20564.www2.hpe.com/hpsc/doc/public/display?docId=c04423967)
  - [HPE RESTful API Data model Reference for iLO4](http://h20564.www2.hpe.com/hpsc/doc/public/display?docId=c04423960&lang=en-us&cc=us)
  - [UEFI Shell specifications](http://www.uefi.org/sites/default/files/resources/UEFI_Shell_Spec_2_0.pdf) (Useful for writing shell scripts)
  - [HPE RESTful Interface Tool](http://www8.hp.com/us/en/products/server-software/product-detail.html?oid=7630408)
  - Youtube: [HPE RESTful API overview](https://www.youtube.com/watch?v=0OjD2lHNWUU)
  - Youtube: search for “HPE ProLiant UEFI”. [Several videos are available](https://www.youtube.com/results?search_query=HPE+ProLiant+UEFI)

When dealing with the Redfish standard, the first approach is to look at the reference Web site http://redfish.dmtf.org/ 

Estimated time for the lab is placed in front of each part.

# Environment setup
Estimated time: 20 minutes

## Client setup

This Lab supposes that your client machine will run a Windows OS. If you're lucky to have a Linux one, don't worry as the instructions also apply to it as well.

Before starting the lab exercises, your client station must be installed with the following:
1. The [Firefox](http://www.mozilla.org/firefox) browser with the [HttpRequester extension](https://addons.mozilla.org/en-US/firefox/addon/httprequester/). NOTE: Google Chrome with the Postman extension can be used as well. However, screen snapshots in this Lab have been performed with HttpRequester as this extension is easier to install in non-connected environments.
2. An SSH client ([PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) on Windows clients is OK)

For the rest of this Lab, each team has received a lab number (**X**) from the instructor, and we'll refer to your server as **labX**. It has the following characteristics:
  - iLO IP: 10.3.222.100+X (login: demopaq - password: password)
  - Server IP: 10.3.222.80+X (login: root - password: password)

Test first your connectivity to the iLO of your server labX with the SSH protocol. If you don't know what it means, ask your instructor.
Answer Yes to the Security Alert (if needed).
If the login is successful, exit from the iLO:

`</>hpilo->` **`exit`**

Then test the access to your OS (a preinstalled RHEL 7 Linux distribution). 
Answer Yes to the confirmation query.
If the login is successful, exit from the system:

`#` **`exit`**

Finally test and set your browser:
Open the Firefox browser (if not already done). If you don’t see the following double arrow icon in the top right corner, notify the instructor.

![HttpRequester Setup](/Redfish/httprequester-icon.png)

From Firefox, open a session toward the iLO of your server at http://10.3.222.10X

If needed, click on Advanced and then on Add Exception… then Confirm Security Exception:

![HttpRequester Setup](/Redfish/insecure-app.png)

Log into the iLO. Your server should be in the OFF state. If not, warn the instructor.

![HttpRequester Setup](/Redfish/server-off.png)


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

## Get properties from the server

The goal of this exercise is to understand the different dialogs and syntaxes used between the client (browser) and the RESTful server.
Open the HttpRequester client:

Redfish and the iLO RESTful API implementation requires the authentication of clients (via SSL) before using GET, POST or PATCH methods.
In these exercises, we use only the Basic Authentication mechanism primarily designed for single requests. Full session states are also supported by the iLO REST Interface, and explained in the Managing HPE Servers Using the RESTful API for iLO document present on your Desktop. 
Supply secured URL https://10.3.222.10X/rest/v1/Systems where X is your group number. 
An URL starting with /rest/v1 will communicate with the legacy iLO RESTful API. 
Click on Authentication… and supply the privileged username (demopaq) and password (password): 

Submit this GET request.
In return, you get a response with status 200 OK. If not, tell your instructor. Make sure that the Pretty format box is ticked:


In this case (traditional rack or blade server), the Total number of “Systems” contained in this box is 1. A Moonshot server with multiple cartridges, would typically return a higher number.
The Type (Collection.1.0.0) represents the most important concept in Redfish and the iLO RESTful API. To simplify, we can consider it is the class of an object instance. We will talk again about Types later in this lab.
The link: /rest/v1/Systems/1 can be interpreted a logical view of server 1 contained in the box. It is the entry point for CPU, memory, expansion slots, power management and BIOS version properties.
To view the properties related to item 1 of this System, Submit the following link: https://10.3.222.10X/rest/v1/Systems/1
The exhaustive list of properties is returned, including possible actions like the different Reset possibilities (ResetType):


Further down, you can see Power state:


Change the URL to /redfish/v1/Systems/1 and compare the output with the /rest/v1/Systems/1 using the bottom History pane. You should notice that the output are identical:

To trigger a Redfish compliant request and get the corresponding output, you need to specify an Open Data header.
Click on the Headers tab of your HttpRequester and fill up the Name: and Value: fields as shown below and click on the Add button:



Submit the request. You should notice that the output is different from previous request. For example, the Bios Version appears earlier:


Note: In addition to the Systems link, the data model proposes others like Chassis and Managers. The description of their content is explained in the Managing HPE Servers Using the iLO RESTful API document.
A partial view of the data model is:

Using the browser extension, navigate through the Chassis link by sending the following URIs. Make sure that the OData-Version header is still present:
https://10.3.222.10X/redfish/v1/Chassis
https://10.3.222.10X/redfish/v1/Chassis/1
https://10.3.222.10X/redfish/v1/Chassis/1/Power
You should notice that the Chassis link contains physical properties of the server(s).
Perform a similar navigation in the Managers location. What is the type of content under Managers? Confirm your findings with the data model picture just above.
Send an action
This exercise sends the Power-On action to start the server. This action is possible via the Systems/1 link. Select the POST button and click on the Headers tab. You need to specify the type of payload you will send (application/json). The type of answers you Accept from the iLO is optional here, but it is good practice to specify: application/JSON as well.


Select the Content to send tab and enter the JSON payload of this POST action in the editor. Hit the Submit button. You should be able to cut&paste the following text:
{"Action":"Reset","ResetType":"On"}


You should get a successful answer: 


Verify in the IRC that the server is booting.

You can kill the HttpRequester application. 


## The HPE RESTful Interface tool

Using a Web browser to get and set properties in a server is very useful for learning or troubleshooting. However, browsing the data model becomes quickly complex. Again, RESTful APIs are intended to be used by programs and you may not have the skills or the time to develop your own RESTful executable suitable for managing your systems.
As an intermediate solution between a browser extension and a dedicated RESTful program, HPE proposes a free RESTful Interface tool. This tool hides the complexity of the underlying data model and provides a simple and easy to use mean for managing servers.
This tool can be downloaded for free from hp.com/go/resttool . Installable packages for both Windows (.msi) and Linux (.rpm) are available. However, you don’t need to download it from the Internet. It is already present on your server.
NOTE: All servers (including Gen8) featuring an ilO4 firmware equal or greater than 2.0 can be managed with this tool. However, Gen8 servers have only a limited set modifiable properties. 
The HPE RESTful Interface tool is the perfect replacement for the following five STK separate tools: reboot, conrep, setbootorder, hponcfg and rbsureset.
The following exercises briefly explains the specific terminology as well as the operational modes of the tool: Interactive, scriptable and file-based.
Tool installation
Although we could use hprest from your Windows station to manage the server in an out-of-band manner, we will use it from the server itself, because we want to test both out-of-band and in-band management. Moreover, the pdsh part of this exercise is not possible on Windows.
An hprest.rpm package is present on your server.
Open a PuTTY session to the server (10.3.222.8X) with root / password for credentials and install the hprest.rpm package:
Host# cd /usr/kits
Host# rpm -ivh hprest.rpm
From a general point of view, server resources and their properties belong to a specific “class” or Type. Type names are referenced by a string followed by a version number like in ComputerSystem.1.0.0. 
To view or alter a property in a specific Type using hprest, you must:
Log into the iLO4 of the server
Select the Type containing the property to display or alter.
The complete list of types and associated properties are detailed in the RESTful API Data Model Reference for iLO4 manual located in the HPE Information Library.
Interactive mode
This mode lets you send interactive RESTful commands to get or set resources and property values.
Launch the hprest tool. From the hprest > prompt, log into the iLO4 of your server for an out-of-band session. Issue the help command:
Host# hprest
hprest > login 10.3.222.10X –u demopaq –p password
Discovering...Done
WARNING: Cache is activated session keys are stored in plaintext
hprest >help
In addition to the “atomic” commands (get set…), hprest provides tools performing several set commands at once. Review the Tool list at the bottom of the help message:



Use the bootorder BIOS COMMAND to force the system to stop at UEFI Shell during next reboot. Send the status command to view the two parameters changed by the bootorder tool. Then commit the changes:
hprest > bootorder --onetimeboot=UefiShell 
hprest > status
Current changes found:
ComputerSystem.1.0.0 (Currently selected)
        Boot/BootSourceOverrideTarget=UefiShell
        Boot/BootSourceOverrideEnabled=Once
hprest > commit
The commit commands logs you out. Login again using the in-band manner, and list all the Types (classes of objects) available:
hprest > login
Discovering...Done
WARNING: Cache is activated session keys are stored in plaintext
hprest > types
…
From there, select ComputerSytem.1.0.0 using the tab command completion key and list all the properties
hprest > select comp<tab>
hperst > select ComputerSystem.<tab>
hprest > select ComputerSystem.1.0.0
hprest > ls
…
Modify now the AdminName property, part of type HpBios.1.2.0, with a string containing a white space, all of this in one single command (note the required comas around the property name and its value):
hprest > set "AdminName=Foo Bar" --selector HpBios.1.2.0
Issue the select command and note that the selected type is now HpBios.1.2.0:
hprest > select
Current selection: 'HpBios.1.2.0'
Nothing has yet been changed in the server. Display the status of the changes located in a server cache and commit them to the server.
hprest > status 
Current changes found:
HpBios.1.2.0 (Currently selected)
        AdminName=Foo Bar
hprest > commit
Committing changes…
One or more properties were changed and will not take effect until system is reset.
Logging session out.
hprest > exit
By for Now
Host# 
Script based mode
This mode allows multiple hprest directives bundled in a single shell script. Change directory to /tmp and launch again an in-band session:
Host# cd /tmp
Host# hprest login
List all the Types, select the HpBios.1.2.0 type and save its properties in a file:
Host# hprest types
Host# hprest select HpBios.1.2.0
Host# hprest save --filename /tmp/bios.json
File based mode
This last mode allows the load of an entire configuration file into hprest, which will send it to the managed server. 
In this exercise, we modify the UEFI BIOS settings in order to execute automatically a networked based startup.nsh file during the startup of the UEFI Shell (remember, we previously set the next boot to UefiShell). 
Using the nano or vi text editor, open /tmp/bios.json saved in the previous exercise and perform the following modifications: Assign an IPv4 static configuration to server’s NIC (the first one found and connected) and a network location for the automatic startup script:. 
Host# vi /tmp/bios.json
…
"Dhcpv4": "Disabled",
…
"Ipv4Address": "10.3.222.8X"
"IPv4Gateway": "0.0.0.0"
…
"Ipv4SubnetMask": "255.255.255.0",
…j
"UefiShellStartup": "Enabled",
…
"UefiShellStartupUrl": "http://10.3.222.22/MediaKits/etc/startup.nsh",
…
Save and exit the text editor.
NOTE: the script name startup.nsh is a reserved keyword part the UEFI Shell specification. In other words, only a script called startup.nsh will be launched automatically by the Shell, whether it is located on the Internet or locally in a GPT (i.e. FS0: or FS1:). Think of Autoexec.bat as a reserved script name in the MS-DOS days…
Your hprest session should be still active. Hence, you can load the modified bios.json file:
Host# hprest load --filename /tmp/bios.json 
To validate these modifications, we need to reset the system. Log into the ilO (demopaq / password) GUI, if needed:


From the central pane, click on .NET to launch the Integrated Remote Console (if not already started): 


You may need, again, to allow Firefox to load unsecure content:


Note: On the latest Chrome, the same action has to be performed, but on the right side of the URL!

From the Console, Reset the server and don’t touch anything. Just watch:


Upon restart, the server detects the modifications performed via the iLO RESTful API and notifies the user it will reboot. Don’t touch anything. Just watch. Remember, we modified the Next Boot order to UefiShell, so the system will stop there: 


After the reboot, the UEFI Shell is launched, it fetches the startup.nsh file from the network and executes it: 


Using a browser, you should be able to view the content of this startup.nsh file and understand why it generates errors; this file is used in another lab and does not find what it is looking for…
Exit from the shell and boot Linux:

## Scripting with wget or curl

Wget(1) and curl(1) are command-line, non-interactive network downloaders available on Linux and Windows/Cygwin. They can be used to send https frames and perform actions via the iLO RESTful API. Sometimes, it is quicker, easier and more convenient to use them compared to a web-browser extension or the hprest tool. 
As an example, the following command sends a Reset signal to your iLO. Watch your iLO session after launching the command. 
Re-open a PuTTY session toward your server. You should be able to cut&paste the following command in your PuTTY and replace the X by your group number:
Host# wget --header='OData-Version:4.0' \
      --header='Content-Type:application/json'       \
      --no-check-certificate \
      --auth-no-challenge \
      --http-user=demopaq --http-password=password  \
      --post-data='{"Action":"Reset"}' \
      https://10.3.222.10X/redfish/v1/Managers/1/
The above command uses a basic authentication (--auth-no-challenge) and does not require any certificate from the iLO (--no-check-certificate).


A second example shows how you can send a power Off signal to multiple systems, in parallel using pdsh(1) and wget. 
When the iLO is back again, login as demopaq / password.
From your PuTTY session, issue the following command where [X] represents a list of a single number: yours. To really specify a list of multiple targets, you could use: [1-9] or [1,2-4,9]. BUT DON’T DO THAT today. Otherwise you will kill your neighbor’s server!
 %h is a “placeholder” that will be replaced automatically by pdsh with each numbers in the list:
Host# pdsh -R exec -w 10.3.222.10[X] wget --header='OData-Version:4.0'\
      --header='Content-Type:application/json'       \
      --no-check-certificate \
      --auth-no-challenge \
      --http-user=demopaq --http-password=password  \
      --post-data='{"Action":"Reset","ResetType":"ForceOff"}' \
      https://%h/redfish/v1/Systems/1/
Of course, you are disconnected from PuTTY. From the iLO4 GUI, power On the server. 

Once the server is rebooted, close the iLO Integrated Remote Console (IRC) to stop the UID from blinking:

Open again a PuTTY session toward the Linux server.
The following example uses curl(1) to change the hostname of the iLO.
Host# curl --dump-header - --insecure -u demopaq:password   \
     --request PATCH                                        \
     -H "OData-Version: 4.0 "                    \
     -H "Accept: application/json "                                \
     -H "Content-Type: application/json "                          \
     --data '{"Oem": {
                     "Hp": {
                             "HostName": "ilo-foobar"
                            }
                     }
             }'                                            \
     https://10.3.222.10X/redfish/v1/Managers/1/EthernetInterfaces/1/
Although the modification is made instantly, the above command returns a message asking for a reset of the iLO to be effective. 


Sign-out  from the iLO GUI (Top-Right) and refresh the page. You should see the new iLO name:

## Python SDK


The python language and its multiple web and security related modules provides a perfect eco-system for creating RESTful for iLO programs. The following script is for didactic purposes only, and HPE does not supports it. Use it with care.
Moreover, it requires python 2.7 or later. Before launching this script, and for security reasons, you need to edit it with your favorite editor and perform at least three tasks. Sending low-level configuration commands can be dangerous to running systems and to avoid any problems, the user must understand what he does...
This python script contains several exercises/examples. We will explain how to run the first one and, if you have time, you will be able to run others. 
A version of this script is present in your environment, but, later you can download the latest version of this file from: https://github.com/HewlettPackard/python-proliant-sdk
NOTE: This version is not fully Redfish 1.0 compliant. A future version will be.
Once your Gen9 server is up and running, ssh/PuTTY to it as root (password) and cd /usr/kits. Using nano or the vi editor, edit the script:
Host# cd /usr/kits
Host# vi HpRestfulApiExamplesExperimental.py –c 1889
Supply your iLO info around line 1889:
host = ’10.3.222.10X’
iLO_loginname = ‘demopaq’ 
iLO_password = ‘password’ 
Comment out the sys.exit command around line 1902:
# sys.exit (-1)
Move the if False: directive below exercice1 and remove leading spaces of exercise 1
ex1_change_bios_setting(host, 'AdminName', 'Mr. Rest',... )
if False:
    ex2_reset_server(host, iLO_loginname, iLO_password)
    ex3_enable_secure_boot(host, False, iLO_loginname, iLO_password)
...........
Save the file and exit.
Execute the script. It will modify the AdminName UEFI Bios parameter:
Host# python HpRestfulApiExamplesExperimental.py

Using the REST client Browser, verify that your modification is not yet in the BIOS, but still in the in the pending area of the BIOS:
In BIOS, you should still read “AdminName”: “Foo Bar”:

In the pending area, you should see your modification:


NOTE: The pending area of the BIOS will updated with your modification at next reboot.
Feel free to try other exercises and investigate how they have been implemented in this python script.

## Scripting with PowerShell and the HPREST Cmdlets

HPE provides a suite of PowerShell Cmdlets in the PowerShell Gallery. The y can be used with PS Version 5.0 coming with the Microsoft Windows Management Framework 5.0 (WMF 5) or natively with Windows10 or Windows server 2016. 
Then, a SDK containing numerous examples is present in the cmdlet package or can be downloaded separately from github.com. 
In this exercise, we will install the HPRESTCmdlets and launch one the examples of the SDK example file.
Your station is already equipped with the WMF 5.0 and the HPRESTCmdlets are have been downloaded (but not installed) under the Redfish-RESTful-lab folder on your Desktop. 
Click on the Start tiles icon in the bottom left of the station screen, and search for PowerShell.exe. Right click on it and select Run as administrator:


Issue the following install command and, if needed, type A to accept the installation from this untrusted repository:


Exit from this PowerShell session.
From the Desktop, navigate toward in the Redfish-RESTful-lab folder present on your Desktop and then to HPRESTCmdlets\1.0.0.4
Right click on the HPRESTExamples.ps1 file and choose Edit:

Read the green comments explaining the license terms and providing the exhaustive list of cmdlets contained in the SDK.
NOTE: This version of the HPRESTCmdlets is not fully compliant with Redfish 1.0. However, a future version will be.
Around line 46, supply your iLO IP address (Replace X by your group number):

The first example in this file is a function that can set a parameter in the BIOS of the server. Review the code of the Set-BIOSExamples1 function. 
You can browse the other examples or go directly to example 13 around line 850. This example offers the possibility of changing the state of the UID (Indicator LED). 
Review the code of this function, uncomment the line calling this function (around line 899) and change the last parameter to Lit (Note the uppercase L) instead of Off if not already done:


Hit CTRL-S to save your modification and click on the green triangle icon in the top icon bar: 
Enter the demopaq / password credentials:


Click on the Agree button of the license terms
You should get a successful output like the following:


From the web GUI of the iLO, verify that the UID is ON: 

Feel free to test other examples.

## Conclusion

The iLO RESTful API provides a rich set of means to display and modify HPE ProLiant servers. Just choose the one suiting best your needs: browser extension, hprest, wget/curl or python. For Windows users, PowerShell is an alternative as well.

