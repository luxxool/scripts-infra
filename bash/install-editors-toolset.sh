
echo "Installing Nice Editor (Ne) "
sudo apt install ne

echo "installing Emacs "
sudo apt install emacs

echo "Installing Micros"
sudo apt install micro

echo "Installing Helix "
cd  ~é
sudo apt install git cargo
git clone https://github.com/helix-editor/helix
cd helix
cargo install --path helix-term
ln -s $PWD/runtime ~/.config/helix/runtime
export PATH=$PATH:/home/team/.cargo/bin


echo "Installing Micros"
sudo apt install micro

