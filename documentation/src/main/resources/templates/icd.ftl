:title: ${branding} Interface Control Document (ICD)
:type: documentation
:status: published
:priority: 001
:sectnums:
:sectnumlevels: 5
:toc:
:toclevels: 3

= {title}

== INTRODUCTION

=== Identification of interfacing Systems/Sub-Systems and Interface Types

The primary system in this context is SOA ESB. The secondary systems that will be interfacing with SOA ESB are as follows:

*	DSD (Type II) - A software application that serves as the entry point for raw NITF imagery into the HA system. It catalogs and stores the imagery as well as notifies SOA ESB about the NITF availability.
*	RGS Pulse interface(Type I) - The RGS Pulse interface is used for the delivery of Sensor H&S information.
*	SOCET(Type II) - SOCET is an imagery exploitation tool. It interfaces with SOA ESB over SOAP to retrieve relevant mission and target information about the exploited NITF. It also interfaces with SOA ESB using REST to redact NITF imagery.
*	TMAN CD FTP(Type II) - This interface allows NITFs that are ferried across domain to be transferred back to the SOA ESB using FTP
*	DSD NFS Content Store (Type II) - The SOA ESB will access the DSD NFS Content Store to download mission imagery to support HA workflow.
*	IRISS (Type III) - A software application that is used for situational awareness about HA missions. It interfaces with SOA ESB to publish PNC-SA information about GlobalHawk and U2 platforms.
*	UNICORN(Type III) - A software application that is used for mission planning and workflow coordination. It interfaces with SOA ESB to provide and consume various types of H&S information for the GlobalHawk and U2 platforms.
*	REnDER Interface (Type III) - A software mission application that is used to support the redaction of information in published exploitation products in accordance with approved relesability guidance.
*	SIRIS Interface (Type III) - A software application that is used for situational awareness about HA missions. It interfaces with SOA ESB to retrieve H&S information about GlobalHawk and U2 platforms.
*	OA DCGS Tier II (Isilon) Storage (Type III) - The SOA ESB interfaces with the OA DCGS Isilon storage to manage the storage of secondary exploitation products that have been published by the AF DCGS operators

=== Scope

==== DSD to SOA ESB Type II Interface
DSD will interface with the SOA ESB's sub-component, Message Broker, in order to provide a notification of the availability of a NITF. The Message Broker is listening on a TCP port 5672, to which DSD must send an AMQP (Advanced Message Queuing Protocol) message, containing one of three image life cycle events: available, removed or heartbeat. All messages must be sent to a specific JMS (Java Message Service) topic for image arrival notifications.

DSD also interfaces with SOA ESB to facilitate information delivery to SIRIS (Type II). When new scenes are ingested by DSD it prepares a series of secondary products.   Among these are JPG files for browse presentation.   SIRIS has requested to be notified of these, and for that notification to include sufficient information for SIRIS to access the image scene (e.g. NITF) that originated the JPG. The SOA ESB Message Broker is used to publish these messages, and establishes a topic for publishing them to interested consumers (e.g. SIRIS). The Message Broker is listening on a TCP port 5672, to which DSD must send an AMQP (Advanced Message Queuing Protocol) message.  It is assumed that consumers do not persist these messages, so only notifications of availability are made.   When the source scene is deleted by DSD, the browse JPG is also deleted, but there will not be a notification message on the broker topic.  All messages must be sent to a specific JMS (Java Message Service) topic for image arrival notifications.

==== SOCET to SOA ESB Type II Interface
SOCET uses SOAP to communicate with SOA ESB to retrieve information about the target in a given NITF and about the mission of which the target was an objective.

SOCET uses REST to retrieve redaction and distribution information and guidance about a given NITF that it is producing.

SOCET Screener services is the comms between SOCET and UNICORN for all of the screener functions.

==== IRISS to SOA ESB Type III Interface
IRISS sends SOA ESB Mission Information (PNCSA) about the GlobalHawks. SOA ESB uses that information to make PNCSA available for the entire HA system, specifically UNICORN and SIRIS.

==== SIRIS to SOA ESB Type III Interface
SIRIS consumes PNCSA, Scene Status and Target Status from SOA ESB. It uses the information to display situational awareness for missions.

==== UNICORN to SOA ESB Type III Interface
This interface is used to collect the Scene Status and Target Status information from UNICORN in order to provide that information to SIRIS. This interface relies on connection to the SOA ESB Message broker to create a topic that UNICORN can use to provide the information on for later collection by SIRIS or any other potential system that requires the information.


==== UNICORN to SOA ESB Type III Interface
This interface is used to collect the Scene Status and Target Status information from UNICORN in order to provide that information to SIRIS. This interface relies on connection to the SOA ESB Message broker to create a topic that UNICORN can use to provide the information on for later collection by SIRIS or any other potential system that requires the information.

== APPLICABLE DOCUMENTS

== REQUIREMENTS

=== Type I Interfaces

<#assign count=0>
<#list interfaces as interface>
<#if (interface.status == "published" && interface.section="Type I")>
<#assign count++>
</#if>
</#list>
<#if (count == 0)>
None.
</#if>
<#if (count != 0)>
<#assign ifNum=0>
[%header,cols=5*]
|===
|I/F No. |I/F Title |Data Content |Source Host |Client
<#list interfaces as interface>
<#if (interface.status == "published" && interface.section="Type I")>
<#assign ifNum++>
|${ifNum}
|<<${interface.title} ${interface.section} Interface Description,${interface.title}>>
|<meta property="datacontent"/>
|<meta property="sourcehost"/>
|<meta property="client"/>
</#if>
</#list>
|===
</#if>

<#list interfaces as interface>
<#if (interface.status == "published" && interface.section="Type I")>
include::${interface.file}[leveloffset=+3]
</#if>
</#list>

=== Type II Interfaces

<#assign count=0>
<#list interfaces as interface>
<#if (interface.status == "published" && interface.section="Type II")>
<#assign count++>
</#if>
</#list>
<#if (count == 0)>
None.
</#if>
<#if (count != 0)>
<#assign ifNum=0>
[%header,cols=5*]
|===
|I/F No. |I/F Title |Data Content |Source Host |Client
<#list interfaces as interface>
<#if (interface.status == "published" && interface.section="Type II")>
<#assign ifNum++>
|${ifNum}
|<<${interface.title} ${interface.section} Interface Description,${interface.title}>>
|${interface.datacontent}
|${interface.sourcehost}
|${interface.client}
</#if>
</#list>
|===
</#if>

<#list interfaces as interface>
<#if (interface.status == "published" && interface.section="Type II")>
include::${interface.file}[leveloffset=+3]

</#if>
</#list>

=== Type III Interfaces

<#assign count=0>
<#list interfaces as interface>
<#if (interface.status == "published" && interface.section="Type III")>
<#assign count++>
</#if>
</#list>
<#if (count == 0)>
None.
</#if>
<#if (count != 0)>
<#assign ifNum=0>
[%header,cols=5*]
|===
|I/F No. |I/F Title |Data Content |Source Host |Client
<#list interfaces as interface>
<#if (interface.status == "published" && interface.section="Type III")>
<#assign ifNum++>
|${ifNum}
|<<${interface.title} ${interface.section} Interface Description,${interface.title}>>
|${interface.datacontent}
|${interface.sourcehost}
|${interface.client}
</#if>
</#list>
|===
</#if>

<#list interfaces as interface>
<#if (interface.status == "published" && interface.section="Type III")>
include::${interface.file}[leveloffset=+3]

</#if>
</#list>
