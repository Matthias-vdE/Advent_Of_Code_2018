# Solution for https://adventofcode.com/2018/day/4
Function Part1 {
    $input = Get-Content .\input.txt | Sort-Object
    $TableOfGuards = @{}
    $CurrentDate
    $CurrentGuard
    $SleepMinutes
    foreach ($line in $input) {
        $splitter = $line.Replace('[', '').Replace(']', '').Replace(':', ' ').Replace('#', '').Split(' ')
        if (($splitter[0] -ne $CurrentDate) -or ([int]$splitter[1] -eq 23)) {
            $CurrentDate = $splitter[0]
            if ($splitter[4] -ne "asleep") {
                [int]$CurrentGuard = $splitter[4]
            }
            if ($null -eq $TableOfGuards[$CurrentGuard]) {
                $TableOfGuards[$CurrentGuard] = New-Object int[] 60
            }
        }
        if ($splitter[3] -eq "falls") {
            [int]$SleepMinutes = $splitter[2]
        }
        elseif ($splitter[3] -eq "wakes") {
            for ($i = $SleepMinutes; $i -lt [int]$splitter[2]; $i++) {
                $TableOfGuards[$CurrentGuard][$i]++
            }
        }
    }

    $tmpBestGuard
    $tmpBestGuardTime
    $tmpBestMinute
    foreach ($guard in $TableOfGuards.Keys) {
        $sum = 0
        $TableOfGuards[$guard] | ForEach-Object {$sum += $_}
        if ($sum -gt $tmpBestGuardTime) {
            $tmpBestGuard = $guard
            $tmpBestGuardTime = $sum
            $max = ($TableOfGuards[$guard] | Measure-Object -Max).Maximum
            $tmpBestMinute = [array]::IndexOf($TableOfGuards[$guard], [int]$max)
        }
    }
    $answer = [int]$tmpBestGuard * [int]$tmpBestMinute
    write-host $answer
}

Function Part2 {
    $input = Get-Content .\input.txt | Sort-Object
    $TableOfGuards = @{}
    $CurrentDate
    $CurrentGuard
    $SleepMinutes
    foreach ($line in $input) {
        $splitter = $line.Replace('[', '').Replace(']', '').Replace(':', ' ').Replace('#', '').Split(' ')
        if (($splitter[0] -ne $CurrentDate) -or ([int]$splitter[1] -eq 23)) {
            $CurrentDate = $splitter[0]
            if ($splitter[4] -ne "asleep") {
                [int]$CurrentGuard = $splitter[4]
            }
            if ($null -eq $TableOfGuards[$CurrentGuard]) {
                $TableOfGuards[$CurrentGuard] = New-Object int[] 60
            }
        }
        if ($splitter[3] -eq "falls") {
            [int]$SleepMinutes = $splitter[2]
        }
        elseif ($splitter[3] -eq "wakes") {
            for ($i = $SleepMinutes; $i -lt [int]$splitter[2]; $i++) {
                $TableOfGuards[$CurrentGuard][$i]++
            }
        }
    } 

    $tmpBestGuard
    $tmpBestGuardTime
    $tmpBestMinutes
    foreach ($guard in $TableOfGuards.Keys) {
        $max = ($TableOfGuards[$guard] | Measure-Object -Max).Maximum
        if ($max -gt $tmpBestMinutes) {
            [int]$tmpBestGuardTime = [array]::IndexOf($TableOfGuards[$guard], [int]$max)
            $tmpBestGuard = $guard
            $tmpBestMinutes = $max
        }
    }
    $answer = [int]$tmpBestGuard * [int]$tmpBestGuardTime
    write-host $answer
}

Part1
Part2