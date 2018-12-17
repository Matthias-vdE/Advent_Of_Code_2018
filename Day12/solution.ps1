# Solution for https://adventofcode.com/2018/day/12

Function Part1 {
    $input = Get-Content .\input.txt
    $initialstate = ($input[0] -split ' ')[2]
    
    $rulesArray = New-Object System.Collections.ArrayList
    $rulesHash = @{}
    foreach ($i in (2..($input.Length - 1))) {
        $rulesArray.Add($input[$i]) | Out-Null
    }
    foreach ($rule in $rulesArray) {
        $split = $rule -split ' '
        $rulesHash.Add($split[0], $split[2]) | Out-Null
    }

    $initialstate = '..' + $initialstate + '..........'
    write-host $initialstate

    $tmpCharArray = [char[]]$initialstate

    for ($i=2; $i -lt $tmpCharArray.Length - 1; $i++) {
        $current = $tmpCharArray[$i-2] + $tmpCharArray[$i-1] + $tmpCharArray[$i] + $tmpCharArray[$i+1] + $tmpCharArray[$i+2]
        foreach ($rule in $rulesHash.Keys) {
            if ($current -eq $rule) {
                $tmpCharArray[$i] = [char]$rulesHash[$rule]
            }
        }
    }

    $genState = -join $tmpCharArray
    write-host $genState
}

Function Part2 {

}

Part1