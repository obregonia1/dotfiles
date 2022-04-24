#!/bin/bash

for f in .??*
do
  [ "$f" = ".git" ] && continue
  target="$HOME/$f"
  if [ -e "$target" ]; then
    echo "$f already exists... Skipping."
  else
    ln -snfv "$PWD/$f" "$HOME"/"$f"
  fi
done

