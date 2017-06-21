#!/bin/sh
OLDPWD=$PWD
CONFIGHOME="${XDG_CONFIG_HOME:=$HOME/.config}"

echo "$(command dirname -- "${0}")"
# cd "$(command dirname -- "${0}")" || exit 2

# Ask user to remove any physical directories before linking
FLAG=0
for f in ./xdg_config_home/*; do
  echo $f
  echo "$CONFIGHOME/$(basename "$f")"
  if [ -d "$CONFIGHOME/$(basename "$f")" ] && [ ! -L "$CONFIGHOME/$(basename "$f")" ]; then
    if [ $FLAG -eq 0 ]; then
      echo "Please remove:"
    fi
    echo "$CONFIGHOME/$(basename "$f")"
    FLAG=1
  fi
done

if [ $FLAG -ne 0 ]; then
  echo "Then re-run this script to install symlinks."
  cd "$OLDPWD" || exit 2
  exit 1
fi

for f in ./xdg_config_home/*; do
  # Overwrite symlinks without asking for confirmation
  if [ -L "$CONFIGHOME/$(basename "$f")" ]; then
    LNOPTS='-vsfn'
  else
    LNOPTS='-vsin'
  fi
  ln $LNOPTS "$PWD/xdg_config_home/$(basename "$f")" "$CONFIGHOME/$(basename "$f")"
done

# cd "$OLDPWD" || exit 2

