# Solution for https://adventofcode.com/2018/day/1

Function Part1 {
    $counter = 0;
    $array = Get-Content .\input.txt
    for ($i = 0; $i -lt $array.Length; $i++) {
        $counter += $array[$i]
    } 
    write-host $counter
}

Function Part2 {
    $counter = 0;
    $array = Get-Content .\input.txt
    $setofvalues = New-Object System.Collections.Generic.HashSet[int]
    while ($true) {
        for ($i = 0; $i -lt $array.Length; $i++) {
            $counter += $array[$i]
            if (-not($setofvalues.Add($counter))){
                write-host $counter
                exit
            }

        } 
    }
}

Part1
Part2