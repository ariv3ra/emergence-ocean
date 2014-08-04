emergence-ocean
===============

Emergence-Ocean is an open source project that enables users to automatedly create & configure a Digital Ocean image with the [Jarvus Innovations](http://jarv.us) [Emergence](http://emr.ge/) app stack.  Emergence-Ocean is based on the [packer.io project](http://www.packer.io).

##Prerequisites
* [Install packer](http://www.packer.io/docs/installation.html) to your Linx or Mac machine
* Must have a [Digtial Ocean](https://www.digitalocean.com) Account
* You'll need your Digital Ocean account [client & api keys](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api) See *Steps One & Two*


##Configure the Packer Builder Files
* Open the packer-digital-ocean-centOS-6_5-64.json in your feav text editor
* Paste your Digital Ocean Client & API Keys
```
    "client_id": "[YOUR CLIENT ID]",            
    "api_key": "[YOUR API KEY]",
```