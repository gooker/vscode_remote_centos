### 一.Software Install
#### Windows Install
1. Install VScode version 1.37  https://code.visualstudio.com/
2. Install git https://git-scm.com/download/win

#### Linux software
1. ripgrep-0.10.0-1.el7.x86_64.rpm,for find refer;
2. coreutils,for tr command err,yum install coreutils;
3. gdb/develop;

### 二.Extensions Install

#### 1. windows vscode
Remote - SSH|Visual Studio Code Remote - SSH|Required

#### 2. Linux vscode (vmware centos)
cd /root/ && tar zxvf centos.vscode.1.37.tar.gz


### 三.Configure Modify

#### launch.json

``` 
# Menu -> Debug ->Open configuration 
# change xxxxxx
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(gdb) Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/xxxxxx",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}
```

#### task.json


``` 
# Menu -> Terminal -> Configure Tasks..
{
    "tasks": [
        {
            "label": "make",
            "command": "make",
            "type": "shell"
        }
    ],
    "version": "2.0.0"
}
```


### 四.Add Workspace
1. Copy old workspace file .vscode to new place;
2. Vscode Menu -> File -> Open Workspace,select workspace file.
3. restart vscode.


#### Remote linux use gdb-serve

```
#auto start
yum install gdb-gdbserver
gdbserver 192.168.1.234:9999 ./xxxxxx

```



