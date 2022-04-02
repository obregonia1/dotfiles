#!/bin/bash

for f in .??*
do
  [ "$f" = ".git" ] && continue

  ln -snfv "$PWD/$f" "$HOME"/"$f"
done

