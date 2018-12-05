# Solution for https://adventofcode.com/2018/day/5

Function Part1 {
    $input = (Get-Content .\input.txt -Raw).Trim()
    $input = [System.Collections.ArrayList][char[]]$input
    $output = Recurse $input
    write-host $output
}

Function Recurse {
    param(
        [Parameter(Mandatory)]
        [System.Collections.ArrayList]
        $chararray
    )
    $done = $false
    while(-not $done) {
        for ($i=0; $i -le $chararray.Count; $i++) {
            if (($chararray[$i] -eq $chararray[$i+1]) -and (($chararray[$i] -cmatch '[a-z]' -and $chararray[$i+1] -cmatch '[A-Z]') -or ($chararray[$i] -cmatch '[A-Z]' -and $chararray[$i+1] -cmatch '[a-z]'))) {
                $chararray.RemoveAt($i+1)
                $chararray.RemoveAt($i)
                $i=-1
              }
        }
        $done = $true
    }
    return [int]$chararray.Count
}

Function Part2 {
    $input = (Get-Content .\input.txt -Raw).Trim()
    $letters = 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'
    foreach ($letter in $letters) {
        $trimmed = [System.Collections.ArrayList][char[]]($input.Replace($letter, '').Replace($letter.ToUpper(), ''))
        $reacted = Recurse $trimmed
        write-host "Removing all $letter : $reacted"
    }
}

Part1
Part2