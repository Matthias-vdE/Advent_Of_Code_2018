# Solution for https://adventofcode.com/2018/day/8

Function Part1 {
    $datapoints = [int[]]((Get-Content .\input.txt) -split ' ')
    $answer = RecursionSucks 0
    write-host $answer[0]
}

function RecursionSucks {
    param(
        [Parameter(Mandatory)]
        [int]
        $current
    )
    $tmpSum = 0
    $childNodeCount = $datapoints[$current++]
    $metaDataCount = $datapoints[$current++]

    for ($i = 0; $i -lt $childNodeCount; $i++) {
        $recurser = RecursionSucks $current
        $tmpSum += $recurser[0]
        $current = $recurser[1]
    }

    for ($j = 0; $j -lt $metaDataCount; $j++) {
        $tmpSum += $datapoints[$current++]
    }

    $returner = [int[]]@()
    $returner += $tmpSum
    $returner += $current
    return $returner
}

Function Part2 {
    $datapoints = [int[]]((Get-Content .\input.txt) -split ' ')
    $answer = RecursionSucks2 0
    write-host $answer[0]
}

function RecursionSucks2 {
    param(
        [Parameter(Mandatory)]
        [int]
        $current
    )

    $nodeValue = 0
    $ChildValues = @()
    $childNodeCount = $datapoints[$current++]
    $metaDataCount = $datapoints[$current++]

    for ($i = 0; $i -lt $childNodeCount; $i++) {
        $returnVals = RecursionSucks2 $current
        $ChildValues += $returnVals[0]
        $current = $returnVals[1]
    }

    if ($childNodeCount -eq 0) {
        for ($j = 0; $j -lt $metaDataCount; $j++) {
            $NodeValue += $datapoints[$current++]
        }
    }
    else {
        for ($j = 0; $j -lt $metaDataCount; $j++) {
            $childNum = $datapoints[$current] - 1
            if ($null -ne $childvalues[$childNum]) {
                $nodeValue += $childvalues[$childNum]
            }

            $current++
        }
    }

    $returner = [int[]]@()
    $returner += $nodeValue
    $returner += $current
    return $returner
}

Part1
Part2