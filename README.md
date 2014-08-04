Emergence-Ocean
===============

Emergence-Ocean is an open source project that enables users to automatedly create & configure a Digital Ocean image with the [Jarvus Innovations](http://jarv.us) [Emergence](http://emr.ge/) app stack.  Emergence-Ocean is based on the [packer.io project](http://www.packer.io).

##Prerequisites
* [Clone this repo](https://github.com/ariv3ra/emergence-ocean) to your builder machine and change into the directory
``` shell
    $ git clone git@github.com:ariv3ra/emergence-ocean.git
    $ cd emergence-ocean/
```
* [Install packer](http://www.packer.io/docs/installation.html) to your builder computer
* Must have a [Digital Ocean](https://www.digitalocean.com) Account
* You'll need your Digital Ocean account [client & api keys](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api) See *Steps One & Two* in this tutorial to get your keys

##Configure the Packer Builder Files
* Open the packer-digital-ocean-centOS-6_5-64.json in your fav text editor
* Paste your Digital Ocean Client & API Keys and save the file with your changes

```
Example:
        "client_id": "a457648473373cghw233",            
        "api_key": "78uiueue98eieieeuee",        
```

##Add Your SSH Certs to your Digital Ocean Image
You can upload your personal SSH certificates to the Digital Ocean image
* Copy your `id_rsa.pub` and `id_rsa` SSH Cert files from your `.ssh` folder to the `inc_files` folder in this project

##Create an Emergence image in your Digital Ocean account
At this point you're ready to execute packer & build your new Digital Ocean image.
* Open a Terminal or Console Shell & type the packer build command:
```shell
    $ packer build packer-digital-ocean-centOS-6_5-64.json
```
The packer build process will begin and you can watch the build process progress in the terminal (usually takes 10 minutes). When the build process successfully completes your new Emergence image will be available in your Digital Ocean account and you can create a new Droplet based on this image

##Create a New Emergence Server Droplet
Now that you have created a new Digital Ocean Emergence Server image you can create an new Emergence Server Droplet.
* [Login into your Digital Ocean Account](https://cloud.digitalocean.com/login)
* Click Create button 
* Enter a Hostname
* Select the Server Size
* Select a Region
* Select an Image > Click `My Images` > Select `emergence-centos-6_5-64`

At this point the new Droplet build process will begin & in 60 seconds you should have a new Emergence Server Droplet online.

Access your new Emergence Server dashboard using the new droplet's IP number.  Emergence Management Dashboard uses port 9083 so open web browser and type `http://<your droplet ip number>:9083` you should be prompted for a login.
```shell
    Example:  http://10.67.78.1:9083

    Default Login Credentials
    username: admin
    password: admin
```
You now have a running instance of Emergence on the interwebs! 

##Configuring Emergence Sites
The intention of this project is to enable a super easy method for user to build and deploy Emergence Droplets on Digital Ocean. Once the instance is up and functioning you will have to configure and manage your Emergence instances which is out of this project's scope.

For information on configuring & managing Emergence please review the project docs
[Emergence Docs](http://emr.ge/docs)

##ToDo List
* Create Packer Builders & Provisioners for Ubuntu
* Create Packer Builders & Provisioners for Gentoo
