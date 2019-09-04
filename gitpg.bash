#!/bin/bash
read -erp "Your real name: " name
read -erp "Your email address: " email
read -erp "A comment about your key: " comment
cp gpg_batch_info tmp_key_info
echo "Name-Real: $name" >> tmp_key_info
echo "Name-Email: $email" >> tmp_key_info
echo "Name-Comment: $comment" >> tmp_key_info
gpg --gen-key --batch tmp_key_info
rm -f tmp_key_info
git config --global user.signingkey $(gpg --list-keys | grep -E '[0-9A-F]{40}' | sed 's/ //g')
git config --global commit.gpgsign true
gpg --armor --export | xclip -in -selection clipboard
echo "The public key block has been copied into your clipboard, you can paste it into GitHub now."
