  [Cmdletbinding()]
  Param([Parameter()]
    [string]$after,
    [Parameter()]
    [string]$before,
    [Parameter()]
    [switch]$fuller
  )
  function n($str){ return [String]::IsNullOrEmpty($str); }

  $tb = !(n $before);
  $ta = !(n $after);
  if($fuller){
    if($tb -and $ta){ "Searching for commits between $after and $before"; git whatchanged --before $before --after $after --format=fuller; return; }
    if($tb){ "Searching for commits before $before"; git whatchanged --before $before --format=fuller; return; }
    if($ta){ "Searching for commits after $after"; git whatchanged --after $after --format=fuller; return; }
  }
  elseif($true){
    if($tb -and $ta){ "Searching for commits between $after and $before"; git whatchanged --before $before --after $after; return; }
    if($tb){ "Searching for commits before $before"; git whatchanged --before $before; return; }
    if($ta){ "Searching for commits after $after"; git whatchanged --after $after; return; }
    "No valid params";
  }
