# Solution for https://adventofcode.com/2018/day/7


<#
Function Part1 {
    $input = Get-Content .\input.txt

    $letters = 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    $solvedletters = @{}
    $answer = ""

    foreach ($letter in $letters) {
        $solvedletters.Add($letter, $false)
    }

    $inputHash = @{}
    foreach ($line in $input) {
        $lineLetter = $line -split ' '
        $letterToAdd = $lineLetter[7]
        $letterToSolve = $lineLetter[1]
        try {
            $inputHash.Add($letterToAdd, $letterToSolve)
        }
        catch {
            $lettertoSolveArray = $inputHash.$letterToAdd
            $lettertoSolveArray += ",$letterToSolve"
            $inputHash.Remove($letterToAdd)
            $inputHash.Add($letterToAdd, $letterToSolveArray)
        }
    }
    $sortedInput = $inputHash.GetEnumerator() | Sort-Object Key

    $sortedInput
    $firstfoundletter = ''
    foreach ($letters in $sortedInput.Value) {
        $split = $letters -split ','
        foreach ($searchletter in $split) {
            $tmp = $sortedInput.$searchletter  
            if ($null -eq $tmp) {
                $firstfoundletter = $searchletter
            }
        }
    }

    foreach ($letter in $($solvedletters.Keys)) {
        if ($letter -eq $firstfoundletter) {
            $solvedletters[$letter] = $true
        }
    }
    $answer += $firstfoundletter

    for ($k = 0; $k -lt 26; $k++) {
        for ($i = 0; $i -le $sortedInput.Count; $i++) {
            $letter = $sortedInput[$i].Key
            $values = $sortedInput[$i].Value -split ','
            $alreadysolved = $true
            foreach ($value in $values) {
                $issolved = $solvedletters[$value]
                if ($issolved -eq $true) { }
                else {
                    $alreadysolved = $false
                }
            }
            if ($alreadysolved) {
                $answer += $letter
                $solvedletters[$letter] = $true
            }
        }
    }

    write-host "`n$answer"
}
#>

Function Part2 {

}

Function FindFirstLetter {
    param(
        [Parameter(Mandatory)]
        [Hashtable]
        $hashtable
    )
    $letters = 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    foreach ($letter in $letters) {
        if (-not $hashtable.ContainsKey($letter)) {
            return $letter
        }
    }
}

Function FindSecondLetter {
    param(
        [Parameter(Mandatory)]
        [Hashtable]
        $hashtable,
        [Parameter(Mandatory)]
        [String]
        $answer
    )
    $letters = 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    $alreadyfound = [char[]]$answer
    foreach ($letter in $letters) {
        if (-not $hashtable.ContainsKey($letter)) {
            if (-not ($alreadyfound -contains [char]$letter)) {
                return $letter
            }
        }
    }
}

Function ParseInput {
    $input = Get-Content .\input.txt
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
    return $inputHashTable
}

Function NewPart1 {
    $letters = 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    $answer = ""
    $alreadysolved = @{}
    foreach ($letter in $letters) {
        $alreadysolved.Add($letter, $false)
    }

    $inputHashTable = ParseInput
    $inputHashTable
    
    write-host 
    $firstletter = FindFirstLetter $inputHashTable
    $answer += $firstletter
    do {
        $nthletter = FindSecondLetter $inputHashTable $answer
        $answer += $nthletter
    } while(-not [String]::IsNullOrEmpty($nthletter))

    write-host $answer


}

NewPart1