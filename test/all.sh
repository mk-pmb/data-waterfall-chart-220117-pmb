#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function test_all () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m -- "$BASH_SOURCE"/..)"
  cd -- "$SELFPATH" || return $?

  local ASC= BFN=
  local ERR_CNT=0
  for ASC in examples/*.asc; do
    BFN="${ASC%.asc}"
    test_one_transform boxdrawify "$BFN".{asc,bxd} || return $?
    test_one_transform asciify    "$BFN".{bxd,asc} || return $?
  done
  echo '+OK All tests passed.'
}


function test_one_transform () {
  local TRANS="$1"; shift
  local ORIG="$1"; shift
  local WANT="$1"; shift
  local CHK="$BFN".tmp
  ../"$TRANS".sed -- "$ORIG" >"$CHK" || return $?
  if diff --brief --unified=5 -- "$WANT" "$CHK" >"$BFN".diff; then
    rm -- "$CHK" "$BFN".diff
    echo "+OK $ORIG"
    return 0
  fi
  echo "-ERR $WANT.diff" >&2
  return 3
}










test_all "$@"; exit $?
