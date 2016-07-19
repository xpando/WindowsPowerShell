  [Parameter(Position=0)]
    [string]$after,
    [Parameter(Position=1)]
    [string]$before,
    [Parameter(Position=2)]
    [switch]$fuller
  )
      function n($str){ return [String]::IsNullOrEmpty($str); }

    $tb = !(n $before);
    $ta = !(n $after);
    if($fuller){
      if($tb -and $ta){ "Searching for commits between $before and $after"; git whatchanged --before $before --after --format=fuller $after; return; }
      if($tb){ "Searching for commits before $before"; git whatchanged --before $before --format=fuller; return; }
      if($ta){ "Searching for commits after $after"; git whatchanged --after $after --format=fuller; return; }
    }
    else{
      if($tb -and $ta){ "Searching for commits between $before and $after"; git whatchanged --before $before --after $after; return; }
      if($tb){ "Searching for commits before $before"; git whatchanged --before $before; return; }
      if($ta){ "Searching for commits after $after"; git whatchanged --after $after; return; }
      "No valid params";
    }
