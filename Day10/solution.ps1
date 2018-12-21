# Solution for https://adventofcode.com/2018/day/10

Function Part1 {
    $input = Get-Content .\input.txt
    
    $x  = New-Object System.Collections.ArrayList
    $y  = New-Object System.Collections.ArrayList
    $dx = New-Object System.Collections.ArrayList
    $dy = New-Object System.Collections.ArrayList
    
    foreach($lines in $input) {
        $matched =  ([regex]"-?\d+").Matches($lines) 
        $x.Add([int]$matched[0].Value)  | Out-Null
        $y.Add([int]$matched[1].Value)  | Out-Null
        $dx.Add([int]$matched[2].Value) | Out-Null
        $dy.Add([int]$matched[3].Value) | Out-Null
    }
    
    $width = $x | Measure-Object -Minimum -Maximum | ForEach-Object {$_.Maximum - $_.Minimum}
    $height = $y | Measure-Object -Minimum -Maximum | ForEach-Object {$_.Maximum - $_.Minimum}
    
    $oldWidth = 0
    $oldHeight = 0
    $numseconds = 0
    do {
        $oldWidth = $width
        $oldHeight = $height
    
        foreach($i in (0..$($x.Count - 1))) {
            $x[$i] += $dx[$i]
            $y[$i] += $dy[$i]
        }
        $width = $x | Measure-Object -Minimum -Maximum | ForEach-Object {$_.Maximum - $_.Minimum}
        $height = $y | Measure-Object -Minimum -Maximum | ForEach-Object {$_.Maximum - $_.Minimum}
        $numseconds++
    } while ($oldWidth -gt $width -and $oldHeight -gt $height)
    
    
    #Go Back by one
    foreach($i in (0..$($x.Count - 1))) {
        $x[$i] -= $dx[$i]
        $y[$i] -= $dy[$i]
    
    }
    $numseconds--
    
    $xmeasures = $x | Measure-Object -Minimum -Maximum
    $ymeasures  = $y | Measure-Object -Minimum -Maximum
    
    if($xmeasures.Minimum -lt 0) {
        $a = $xmeasures.Minimum
        foreach($i in (0..$($x.Count - 1))) {
            $x[$i] -= $a
        }
    }
    
    if($ymeasures.Minimum -lt 0) {
        $a = $ymeasures.Minimum
        foreach($i in (0..$($y.Count - 1))) {
            $y[$i] -= $a
        }
    }
    
    $xmeasures = $x | Measure-Object -Minimum -Maximum
    $ymeasures  = $y | Measure-Object -Minimum -Maximum
    
    
    $display = New-Object 'string[][]' $($ymeasures.Maximum + 2), $($xmeasures.Maximum + 2)
    
    foreach($i in (0..$($x.Count - 1))) {
        $j = $y[$i]
        $k = $x[$i]
        $display[$j][$k] = '#'
    }
    
    foreach($a in $display) {
        foreach($b in $a) {
            if($null -ne $b) {
                Write-host " " -NoNewline -BackgroundColor Red
            } else {
                Write-host " " -NoNewline
            }
        }
        Write-Host " "
    }
    
    Write-Host "Seconds: $numseconds"
}

Part1
# Part 2 is the same as part one, number of seconds already included.