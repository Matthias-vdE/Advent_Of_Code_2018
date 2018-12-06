# Solution for https://adventofcode.com/2018/day/6

Function Part1 {
    $sampleinput = @()
    $sampleinput = Get-Content .\input.txt

    $coordinates = @{}
    $mapSizeX = 0
    $mapSizeY = 0
    $counter = 0

    foreach ($coordinate in $sampleinput) {
        $cor = ($coordinate -replace ' ', '').Trim() -split ','
        $corobject = New-Object System.Management.Automation.Host.Coordinates ($cor[0], $cor[1])
        $coordinates.Add($counter, $corobject)
        $counter++
        if ($corobject.X -gt $mapSizeX) {
            $mapSizeX = $corobject.X
        }
        if ($corobject.Y -gt $mapSizeY) {
            $mapSizeY = $corobject.Y
        }
    }

    $map = New-Object 'object[,]' ([int]($mapSizeX + 1)), ([int]($mapSizeY + 1))
    $regions = @{}

    for ($x = 0; $x -le $mapSizeX; $x++) {
        for ($y = 0; $y -le $mapSizeY; $y++) {
            $bestdistance = 999999
            $bestnumber = -1

            for ($i = 0; $i -lt $counter; $i++) {
                $currentcor = $coordinates.$i
                $distance = [int]([System.Math]::Abs($x - $currentcor.X) + [System.Math]::Abs($y - $currentcor.Y))
                if ($distance -lt $bestdistance) {
                    $bestdistance = $distance
                    $bestnumber = $i
                }
                elseif ($distance -eq $bestdistance) {
                    $bestnumber = -1
                }
            }
            $map[$x, $y] = $bestnumber
            $total = $regions.$bestnumber
            if ($null -eq $total) {
                $total = 1
            }
            else {
                $total++
            }
            $regions.Remove($bestnumber)
            $regions.Add($bestnumber, $total)
        }
    }

    for ($x = 0; $x -le $mapSizeX; $x++) {
        $edge = $map[$x, 0]
        $regions.Remove($edge)
        $edge = $map[$x, $mapSizeY]
        $regions.Remove($edge)
    }

    for ($y = 0; $y -le $mapSizeY; $y++) {
        $edge = $map[0, $y]
        $regions.Remove($edge)
        $edge = $map[$mapSizeX, $y]
        $regions.Remove($edge)
    }

    $biggest = -1
    foreach ($value in $regions.Values) {
        if ($value -gt $biggest) {
            $biggest = $value
        }
    }
    write-host $biggest
}

Function Part2 {
    $sampleinput = @()
    $sampleinput = Get-Content .\input.txt

    $coordinates = @{}
    $mapSizeX = 0
    $mapSizeY = 0
    $counter = 0

    foreach ($coordinate in $sampleinput) {
        $cor = ($coordinate -replace ' ', '').Trim() -split ','
        $corobject = New-Object System.Management.Automation.Host.Coordinates ($cor[0], $cor[1])
        $coordinates.Add($counter, $corobject)
        $counter++
        if ($corobject.X -gt $mapSizeX) {
            $mapSizeX = $corobject.X
        }
        if ($corobject.Y -gt $mapSizeY) {
            $mapSizeY = $corobject.Y
        }
    }
    $map = New-Object 'object[,]' ([int]($mapSizeX + 1)), ([int]($mapSizeY + 1))
    $regions = @{}

    for ($x = 0; $x -le $mapSizeX; $x++) {
        for ($y = 0; $y -le $mapSizeY; $y++) {
            $bestdistance = 999999
            $bestnumber = -1

            for ($i = 0; $i -lt $counter; $i++) {
                $currentcor = $coordinates.$i
                $distance = [int]([System.Math]::Abs($x - $currentcor.X) + [System.Math]::Abs($y - $currentcor.Y))
                if ($distance -lt $bestdistance) {
                    $bestdistance = $distance
                    $bestnumber = $i
                }
                elseif ( $distance -eq $bestdistance) {
                    $bestnumber = -1
                }
            }
            $map[$x, $y] = $bestnumber
            $total = $regions.$bestnumber
            if ($null -eq $total) {
                $total = 1
            }
            else {
                $total++
            }
            $regions.Remove($bestnumber)
            $regions.Add($bestnumber, $total)
        }
    }

    for ($x = 0; $x -le $mapSizeX; $x++) {
        $edge = $map[$x, 0]
        $regions.Remove($edge)
        $edge = $map[$x, $mapSizeY]
        $regions.Remove($edge)
    }

    for ($y = 0; $y -le $mapSizeY; $y++) {
        $edge = $map[0, $y]
        $regions.Remove($edge)
        $edge = $map[$mapSizeX, $y]
        $regions.Remove($edge)
    }

    $regionsize = 0
    for ($x = 0; $x -le $mapSizeX; $x++) {
        for ($y = 0; $y -le $mapSizeY; $y++) {
            $size = 0
            for ($i = 0; $i -lt $counter; $i++) {
                $currentcor = $coordinates.$i
                $distance = [int]([System.Math]::Abs($x - $currentcor.X) + [System.Math]::Abs($y - $currentcor.Y))
                $size += $distance
            }
            if ($size -lt 10000) {
                $regionsize++
            }
        }
    }

    write-host $regionsize
}

Part1
Part2