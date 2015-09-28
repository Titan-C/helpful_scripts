#!/usr/bin/env bash
# Short script to keep statistics of my key presses

xinput test-xi2 --root | perl -lne '
  BEGIN{$"=",";
    open X, "-|", "xmodmap -pke";
    for (<X>) {$k{$1}=$2 if /^keycode\s+(\d+) = (\w+)/}
    open X, "-|", "xmodmap -pm"; <X>;<X>;
    for (<X>) {if (/^(\w+)\s+(\w*)/){($k=$2)=~s/_[LR]$//;$m[$i++]=$k||$1}}
  }
  if (/^EVENT type.*\((.*)\)/) {$e = $1}
  elsif (/detail: (\d+)/) {$d=$1}
  elsif (/modifiers:.*effective: (.*)/) {
    $m=$1;
    if ($e =~ /^KeyPress/){
      my @mods;
      for (0..$#m) {push @mods, $m[$_] if (hex($m) & (1<<$_))}
      open(my $fh, ">>", "keylog") or die "nofile";
      print $fh "$e $d [$k{$d}] $m [@mods]"
    }
  }'&
