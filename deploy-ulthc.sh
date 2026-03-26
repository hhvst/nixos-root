#!/usr/bin/env bash
set -euo pipefail

HOST=${1:?usage: deploy.sh <hostname> <target-ip>}
TARGET=${2:?usage: deploy.sh <hostname> <target-ip>}

STAGING=$(mktemp -d)
trap "rm -rf $STAGING" EXIT

SSH_DIR="$STAGING/extra-files/persist/etc/ssh"
mkdir -p "$SSH_DIR"

# Generate host key if it doesn't exist in ~/.ssh yet
KEY=~/.ssh/${HOST}_host_ed25519
if [ ! -f "$KEY" ]; then
  echo "Generating host key for $HOST..."
  ssh-keygen -t ed25519 -N "" -C "root@${HOST}" -f "$KEY"
  echo ""
  echo ">>> Add this age pubkey to .sops.yaml for $HOST:"
  cat "${KEY}.pub" | ssh-to-age
  echo ""
  echo "Then re-encrypt secrets: sops updatekeys secrets/*.yaml"
  echo "Commit .sops.yaml and re-encrypted secrets before continuing."
  read -p "Press enter when done..."
fi

cp "$KEY"     "$SSH_DIR/ssh_host_ed25519_key"
cp "${KEY}.pub" "$SSH_DIR/ssh_host_ed25519_key.pub"
chmod 600 "$SSH_DIR/ssh_host_ed25519_key"

echo "Deploying $HOST to $TARGET..."
nixos-anywhere \
  --flake ".#$HOST" \
  --extra-files "$STAGING/extra-files" \
  --disk-encryption-keys /tmp/secret.key <(read -rsp "ZFS passphrase: " p && echo -n "$p") \
  root@"$TARGET"