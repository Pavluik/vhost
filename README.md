OYiVirtualHost
====================

**OYiVirtualHost** is a bash script for configuration your local projects.

## Global command

```
chmod +x vhost.sh
sudo cp vhost.sh /usr/bin/vhost
```

## Usage

Create project:
```
sudo vhost projectName add
```

Create project and database:
```
sudo vhost projectName add projectDatabase
```


Delete project:
```
sudo vhost projectName del
```

Delete project and database:
```
sudo vhost projectName del projectDatabase
```