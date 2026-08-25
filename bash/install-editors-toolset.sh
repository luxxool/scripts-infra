#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -eq 0 ]; then
  sudo() { "$@"; }
fi


echo "Installing Nice Editor (Ne) "
sudo apt install ne

echo "installing Emacs "
sudo apt install emacs

echo "Installing Micros"
sudo apt install micro

# ekho "Installing Helix "
# cd ~
# sudo apt install git cargo
# git clone https://github.com/helix-editor/helix
# cd helix
# cargo install --path helix-term
# ln -s $PWD/runtime ~/.config/helix/runtime
# export PATH=$PATH:/home/team/.cargo/bin


echo "Installing Micros"
sudo apt install micro

echo "##HH||             #|               #|      #HH|              #|         #|  #|           H| "
echo "  #|    #H|   #H|  #|   #HH|  #H|  ##HH|     #|  ##H|   #HH| ##HH| ##|   #|  #|   #H|     H| "
echo "  #|   ## H| ## H| #|  ##H|  ##HH|  #|       #|  ## H| ##H|   #|     H|  #|  #|  ##HH|  #HH| "
echo "  #|   ## H| ## H| #|     H| ##     #|       #|  ## H|    H|  #|   ##H|  #|  #|  ##    ## H| " 
echo "  #|    #H|   #H|  #H| ##H|   #HH|  #H|     #HH| ## H| ##H|   #H|  ##HH| #H| #H|  #HH|  #HH| "
                                                                                             