# Solution for https://adventofcode.com/2018/day/11

Function Part1 {
    $grid = New-Object int[][] 300, 300
    $gridSN = [int](Get-Content .\input.txt)
    foreach ($x in (0..299)) {
        foreach ($y in (0..299)) {
            $xCoordinate = $x + 1
            $yCoordinate = $y + 1
            $rackID = $xCoordinate + 10
            $powerLevel = $rackID * $yCoordinate
            $powerLevel += $gridSN
            $powerLevel *= $rackID
            if ($powerLevel -lt 100) {
                $hundreth = 0
            }
            else {
                $string = [String]$powerlevel
                $hundreth = $string.Substring($string.Length - 3, 1)
                $hundreth = [int]$hundreth
            }
            $final = $hundreth - 5
            $grid[$x][$y] = $final
        }
    }

    $largestPower = -1
    $largestX = -1
    $largestY = -1

    foreach ($x in (0..297)) {
        foreach ($y in (0..297)) {
            $sum = $grid[$x][$y] + $grid[$x + 1][$y] + $grid[$x + 2][$y] + $grid[$x][$y + 1] + $grid[$x + 1][$y + 1] + $grid[$x + 2][$y + 1] + $grid[$x][$y + 2] + $grid[$x + 1][$y + 2] + $grid[$x + 2][$y + 2]
            if ($sum -gt $largestPower) {
                $largestPower = $sum
                $largestX = $x + 1
                $largestY = $y + 1
            }
        }
    }

    write-host "$largestX,$largestY"
}

Function Part2 {
    $grid = New-Object int[][] 300, 300
    $gridSN = [int](Get-Content .\input.txt)
    foreach ($x in (0..299)) {
        foreach ($y in (0..299)) {
            $xCoordinate = $x + 1
            $yCoordinate = $y + 1
            $rackID = $xCoordinate + 10
            $powerLevel = $rackID * $yCoordinate
            $powerLevel += $gridSN
            $powerLevel *= $rackID
            if ($powerLevel -lt 100) {
                $hundreth = 0
            }
            else {
                $string = [String]$powerlevel
                $hundreth = $string.Substring($string.Length - 3, 1)
                $hundreth = [int]$hundreth
            }
            $final = $hundreth - 5
            $grid[$x][$y] = $final
        }
    }
    $largestX = -1
    $largestY = -1

    $largestPatch = -1
    $largestPatchSize = -1

    foreach ($x in (0..297)) {
        foreach ($y in (0..297)) {
            #Assume that the largest patch size won't be bigger than 20.
            foreach ($i in (0..20)) {
                $patchSum = CalculatePatch $grid $x $y $i
                if ($patchSum -gt $largestPatch) {
                    $largestX = $x + 1
                    $largestY = $y + 1
                    $largestPatch = $patchSum
                    $largestPatchSize = $i
                    write-host "$largestX,$largestY,$largestPatchSize"
                }
            }
        }
    }

    write-host "$largestX,$largestY,$largestPatchSize"

}

Function CalculatePatch {
    param(
        [Parameter(Mandatory)]
        [int[][]]
        $grid,
        [Parameter(Mandatory)]
        [int]
        $x,
        [Parameter(Mandatory)]
        [int]
        $y,
        [Parameter(Mandatory)]
        [int]
        $size
    )
    $sum = 0
    for ($i = 0; $i -lt $size; $i++) {
        for ($j = 0; $j -lt $size; $j++) {
            $sum += $grid[$x + $i][$y + $j]
        }
    }
    return $sum
}

Part1
Part2