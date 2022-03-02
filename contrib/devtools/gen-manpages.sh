#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

AGROCOIND=${AGROCOIND:-$BINDIR/agrocoind}
AGROCOINCLI=${AGROCOINCLI:-$BINDIR/agrocoin-cli}
AGROCOINTX=${AGROCOINTX:-$BINDIR/agrocoin-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/agrocoin-wallet}
AGROCOINQT=${AGROCOINQT:-$BINDIR/qt/agrocoin-qt}

[ ! -x $AGROCOIND ] && echo "$AGROCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a AGROVER <<< "$($AGROCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for agrocoind if --version-string is not set,
# but has different outcomes for agrocoin-qt and agrocoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$AGROCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $AGROCOIND $AGROCOINCLI $AGROCOINTX $WALLET_TOOL $AGROCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${AGROVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${AGROVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
