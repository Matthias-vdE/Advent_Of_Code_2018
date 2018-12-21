# Solution for https://adventofcode.com/2018/day/13

Function Part1 {
    #Create and define a map, which is a char[][] array to hold the input map.
    $mapLength = 0
    $mapHeight = 0
    $in = Get-Content .\input.txt
    $mapMeasure = $in | Measure-Object -Maximum
    $mapLength = ($mapMeasure.Maximum).Length
    $mapHeight = $in.Count
    $map = New-Object char[][] $mapHeight, $mapLength
    $carts = @{}

    #Fill the map based on the input.
    $cartnumber = 0
    foreach ($i in 0..($mapHeight-1)) {
        $charArray = $in[$i].ToCharArray()
        foreach ($j in 0..($mapLength-1)) {
            $map[$i][$j] = $charArray[$j]
            if (($charArray[$j] -eq '^') -or ($charArray[$j] -eq '>') -or ($charArray[$j] -eq 'v') -or ($charArray[$j] -eq '<')) {
                $coordinate = new-object System.Management.Automation.Host.Coordinates
                $coordinate.X = $i
                $coordinate.Y = $j
                $carts.Add($cartnumber, $coordinate)
                $cartnumber++
            }
        }
    }

    # If >, Y++
    # If ^, X--
    # If <, Y--
    # If v, X++
    $ticks = 0
    
    foreach ($cart in $carts.Keys) {
        $cartcoordinate = $carts[$cart]
        $cartobject = $map[$cartcoordinate.X][$cartcoordinate.Y]
        switch($cartobject) {
            '^' { }
            '>' { }
            'v' { }
            '<' { }
        }
    }
}
 
Function PrintMap {
    param (   
        [Parameter(Mandatory)]
        [char[][]]
        $map
    )
    foreach ($a in $map) {
        foreach ($b in $a) {
            write-host $b -NoNewline
        }
        write-host ""
    }
}

Part1