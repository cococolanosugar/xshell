# script_tools
## 1. xx

A bash script make it convenient to login to remote linux servers.

Especially if you are using **Iterm2** and it can't remember the password distressed you.

### use age:

#### first
create a text file name server_config in the same dir,
and put your server info in it with format like this:
```
Tag    Ip    Port   Name    Password
```
in my case:
```
vag	192.168.33.10	22	vagrant	vagrant
```
#### second
you can go to you server like this:
```
xx vag
```
