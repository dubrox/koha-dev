#!/bin/bash

sudo chmod 666 /var/run/docker.sock

if [ ! $KTD_HOME ]
then
    source ~/.koha_bashrc
    cat ~/.koha_bashrc >> ~/.bashrc
fi

ktd up