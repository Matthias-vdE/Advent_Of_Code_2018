# Solution for https://adventofcode.com/2018/day/3

Function Part1 {
    $fabric = New-Object 'object[,]' 1000, 1000
    $clashcounter = 0
    for ($i = 0; $i -lt 1000; $i++) {
        for ($j = 0; $j -lt 1000; $j++) {
            $fabric[$i, $j] = '.'
        }
    }
    $input = Get-Content .\input.txt
    foreach ($line in $input) {
        $tofill = InputParser $line
        foreach ($filler in $tofill) {
            $split = $filler -split ","
            $x = [int]($split[0])
            $y = [int]($split[1])
            if ($fabric[$x, $y] -eq '.') {
                $fabric[$x, $y] = '#'
            }
            elseif ($fabric[$x, $y] -eq '#') {
                $fabric[$x, $y] = 'X'
                $clashcounter++
            }
        }
    }
    write-host $clashcounter
}

Function InputParser {
    param(
        [Parameter(Mandatory)]
        [String]
        $inputstring
    )
    $split1 = $inputstring -split '@'
    $id = $split1[0].Trim()
    $split2 = $split1[1] -split ":"
    $pos = $split2[0].Trim()
    $sqr = $split2[1].Trim()

    $leftedge = [int]$($pos -split ',')[0]
    $topedge = [int]$($pos -split ',')[1]

    $width = [int]($sqr -split 'x')[0]
    $height = [int]($sqr -split 'x')[1]

    $tofill = @()
    $counter = 0
    for ($i = $leftedge; $i -lt ($leftedge + $width); $i++) {
        for ($j = $topedge; $j -lt ($topedge + $height); $j++) {
            $tofill += "$i,$j"
            $counter++;
        }
    }
    return $tofill
}

Function Part2 {

}

Part1