#!/usr/bin/env bash
set -e

WS="$1"

git config --global --replace-all safe.directory "${WS}"
git -C "${WS}" config gpg.format ssh
git -C "${WS}" config user.signingkey ~/.ssh/id_ed25519
git -C "${WS}" config commit.gpgsign true
git -C "${WS}" config user.name "kcofoni"
git -C "${WS}" config user.email "kcofoni@gmail.com"
git -C "${WS}" config gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers

src="${WS}/config/custom_components/netro_watering"
dst="${WS}/homeassistant/components/netro_watering"
ln -sfn "$src" "$dst"

mkdir -p "${WS}/.claude"
rm -rf ~/.claude
ln -sfn "${WS}/.claude" ~/.claude

claude mcp add --transport sse pmwiki http://vmdocker:3010/sse
