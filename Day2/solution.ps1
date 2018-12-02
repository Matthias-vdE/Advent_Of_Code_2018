# Solution for https://adventofcode.com/2018/day/2

Function Part1 {
    $chararray = @()
    $contentlines = Get-Content .\input.txt
    foreach ($line in $contentlines) {
        $chararray += LetterCounter -Word $line
    }
    $string = [String]$chararray

    $doubles = ($string -split "D").Count - 1
    $triples = ($string -split "T").Count - 1
    $both = ($string -split "B").Count - 1

    $checksum = ($doubles + $both) * ($triples + $both)
    write-host $checksum
}

Function Part2 {
    $contentarray = Get-Content .\input.txt

    [array]::Sort($contentarray)

    for ($i = 0; $i -lt $contentarray.Length - 1; $i++) {
        $chararray1 = $contentarray[$i].ToCharArray()
        $chararray2 = $contentarray[$i + 1].ToCharArray()
        $counter = 0;
        for ($j = 0; $j -lt $chararray1.Length; $j++) {
            if ($chararray1[$j] -ne $chararray2[$j] ) {$counter++}
        }
        if ($counter -eq 1) {
            $same
            for ($j = 0; $j -lt $chararray1.Length; $j++) {
                if ($chararray1[$j] -eq $chararray2[$j] ) {$same += $chararray1[$j]}
            }
            write-host $same
        }
    }
}

Function LetterCounter {
    param(
        [Parameter(Mandatory)]
        [String]
        $Word
    )

    $charArray = [char[]]$Word
    [array]::Sort($charArray)
    $doublefound = $false
    $triplefound = $false

    for ($i = 0; $i -lt $charArray.Length; $i++) {
        if (($charArray[$i] -eq $charArray[$i + 1]) -and ($charArray[$i + 1] -eq $charArray[$i + 2])) {
            $triplefound = $true
            $i++;
        } 
        elseif ($charArray[$i] -eq $charArray[$i + 1]) {
            $doublefound = $true
        } 
    }
    if ($doublefound -and $triplefound) { return "B"}
    if ($triplefound) { return "T" }
    if ($doublefound) { return "D" }
    return "N";
}

Part1
Part2