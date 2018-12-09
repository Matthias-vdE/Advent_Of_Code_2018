# Solution for https://adventofcode.com/2018/day/7

Function ParseInput {
    #Nothing special going on here. This simply reads the input, creates a HashTable, and then turns it into a Dictionary to make sure the Keys are sorted alphabetically.
    #Every letter that does not have a requirements get $null as the key Value.
    $input = Get-Content .\input.txt
    $letters = 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    $inputHashTable = @{}
    foreach ($line in $input) {
        $lineLetter = $line -split ' '
        $letterToAdd = $lineLetter[7]
        $letterToSolve = $lineLetter[1]

        try {
            $inputHashTable.Add($letterToAdd, $letterToSolve)
        }
        catch {
            $lettertoSolveArray = $null
            $lettertoSolveArray = @()
            $lettertoSolveArray += $inputHashTable.$letterToAdd
            $lettertoSolveArray += $letterToSolve
            [array]::Sort($lettertoSolveArray)
            $inputHashTable.Remove($lettertoAdd)
            $inputHashTable.Add($letterToAdd, $letterToSolveArray)
        }
    }
    foreach ($letter in $letters) {
        if (-not $inputHashTable.ContainsKey($letter)) {
            $inputHashTable.Add($letter, $null)
        }
    }

    $dictionary = [ordered]@{}
    $keys = $inputHashTable.keys | Sort-Object

    foreach ($key in $keys) {
        $dictionary.add($key, $inputHashTable[$key])
    }

    return $dictionary
}

Function Part1 {
    #Parse the input. This variable holds the Dictionary "map".
    $inputHashTable = ParseInput
    $inputHashTable
    
    $answer = ""
    $originallength = $inputHashTable.Count
    $count = $originallength


    # Keep looping until we have processed everything
    while ($answer.Length -lt $originallength) {

        for ($i = 0; $i -lt $count; $i++) {
            #Create an array from the Keys. I found this to be the easiest way to get all Key values at Index i
            $keyArray = new-object String[] $count
            ($inputHashTable.Keys).CopyTo($keyArray, 0)

            #Get the Key and Value for Index i
            $key = $keyArray[$i]
            $value = $inputHashTable[$i]

            #If the Value contains multiple letters, we can skip it for now.
            if ($value.Length -gt 1) {

            }
            else {
                #If the Value of the current Key equals $null, it has no dependancies and we can add it to the final answer.
                if ($null -eq $value) {
                    $answer += $key
                    #The key is no longer needed, and thus can be removed from the Dictionary.
                    $inputHashTable.Remove($key)
                    #Decrease the count by one to prevent overflow errors in the next loop.
                    $count--
                    #Go over each letters in the keyArray
                    foreach ($letter in $keyArray) {
                        #Grab the value for that specific key
                        $value = $inputHashTable[$letter]
                        #If it's an array we need to remove the key letter, because that dependency is satistied now.
                        if ($value.length -gt 1) {
                            $newarray = @()
                            foreach ($tmp in $value) {
                                if ($tmp -ne $key) {
                                    $newarray += $tmp
                                }
                            }
                            $inputHashTable[$letter] = $newarray
                        }
                        #If it's not an array, but a single letter, and if it equals the key we just removed, set it to $null because the dependency is satisfied.
                        else {
                            if ($value -eq $key) {
                                $inputHashTable[$letter] = $null
                            }
                        }
                    }
                    #Reset the counter for the for loop.
                    $i = -1
                }
            }
        }
    }
    write-host $answer
}

Function Part2 {
    $workers = @{}
    for ($i=0; $i -lt 5; $i++) {
        $workers.Add($i, "Available")
    }

    $allWorkItems = @{}
    $tickTock = 0
    $input = Get-Content .\input.txt

    $letters = 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    foreach ($letter in $letters) {
        $tmp = [PSCustomObject]@{
            Name = $letter
            Started = $false
            Done = $false
            DoneAt = -1
            Requirement = [System.Collections.Generic.List[object]]::new()
            Duration = 60 + [char]$letter-64
        }
        $allWorkItems[$letter] = $tmp
    }

    foreach ($line in $input) {
        $split = $line -split ' '
        $first = $split[1]
        $second = $split[7]
        $allWorkItems[$second].Requirement.Add($allWorkItems[$first])
    }

    $worktodo = [system.collections.generic.list[object]]::new()

    while($allWorkItems.Values.Where{-not $_.Done}.Count -gt 0) {

        $busyWorkers = $workers.Keys.Where{$workers[$_] -ne 'Available'}

        foreach ($worker in $busyWorkers) {
            $workitem = $workers[$worker]
            if ($tickTock -gt $workitem.DoneAt) {
                $workitem.Done = $true
                $workers[$worker] = 'Available'
            }
        }

        $tmpavailabletodo = [System.Collections.Generic.list[object]]::new()

        foreach ($item in $($allWorkItems.Values)) {
            if ($item.Requirement.Where{$_.Done -eq $false}.Count -gt 0) {

            } else {
                if (-not $item.Started -and -not $item.Done) {
                    $tmpavailabletodo.add($item)
                }
            }
        }

        [array]$tmpavailabletodosortedcopy = $tmpavailabletodo | sort -property Name
        $availableworkers = $workers.Keys.Where{$workers[$_] -eq 'Available'}
        foreach ($availableworker in $availableworkers) {
            if ($tmpavailabletodosortedcopy.Count -gt 0) {
                $workitem = $tmpavailabletodosortedcopy[0]
                $workitem.Started = $true
                $workitem.DoneAt = $tickTock + $workitem.Duration - 1
                $tmpavailabletodosortedcopy = $tmpavailabletodosortedcopy[1..($tmpavailabletodosortedcopy.Count)]
                $workers[$availableworker] = $workitem
                $worktodo.Add($workitem.Name)
            }
        }

        $tickTock++
    }
    $answer = $tickTock - 1
    write-host $answer
}

Part1
Part2