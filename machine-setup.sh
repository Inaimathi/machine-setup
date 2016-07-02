## Basics
dumpkeys | head -1 > /home/inaimathi/caps2ctrl.map
echo 'keycode 58 = Control' >> /home/inaimathi/caps2ctrl.map

eval `ssh-agent -s`
chmod 400 ~/.ssh/id_rsa
ssh-add
echo "Running root installation steps..."
chmod +x machine-root-setup.sh
su -c ./machine-root-setup.sh

echo "Slaughtering CapsLock..."
setxkbmap -layout us -option ctrl:nocaps

echo "Setting up nix..."
curl https://nixos.org/nix/install | sh
. /home/inaimathi/.nix-profile/etc/profile.d/nix.sh

echo "Setting up basics..."
nix-env -i dmenu rsync htop emacs-24.5 git firefox mplayer feh gnumake screen gimp inkscape youtube-dl rxvt-unicode

echo "Setting up Lisp..."
nix-env -i sbcl
curl -O https://beta.quicklisp.org/quicklisp.lisp
sbcl --load quicklisp.lisp --load setup.lisp --eval '(quit)'

echo "Setting up Haskell..."
nix-env -f "<nixpkgs>" -iA haskellPackages.stack

echo "Setting up OCaml..."
nix-env -i ocaml opam

echo "Setting up Python..."
pip install --user requests cssselect

echo "Setting up Emacs..."
mkdir -p ~/.emacs.d/mine
cp dot-emacs ~/.emacs
cp convenience.el ~/.emacs.d/mine/

echo "Setting up Xmonad..."
mkdir -p ~/.xmonad
cp xmonad.hs ~/.xmonad/

echo "Setting up basic filesystem structure..."
mkdir -p ~/pictures/backgrounds
mkdir -p ~/pictures/screenshots ~/projects ~/downloads ~/books ~/videos ~/bin

echo "Setting up shell-ui..."
cd ~/projects
git clone git@github.com:Inaimathi/shell-ui.git

cp ~/projects/shell-ui/python/* ~/bin/

git config --global user.email "leo.zovic@gmail.com"
git config --global user.name "inaimathi"
