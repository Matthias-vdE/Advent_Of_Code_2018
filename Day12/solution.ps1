# Solution for https://adventofcode.com/2018/day/12


Function Part1 {
    #Grab the input
    $in = Get-Content .\input.txt

    #Put the rules in an array.
    $rules = 2..($in.Length - 1) | % {
        $in[$_]
    }

    #Grab the initial state and add some padding, this should be enough for Step 1.
    $initialState = ($in[0] -split " ")[2]
    $initialState = ("." * 10) + $initialState + ("." * 20)

    #Create a HashTable with all the rules
    $rulesHash = @{}
    $rules | % {
        $rulesHash.Add(($_ -split " ")[0], ($_ -split " ")[2])
    }

    #Do the thing
    foreach ($k in (1..20)) {
        #Copy the inital state string into an array of characters for easy manipulation
        $tmpArray = [char[]]$initialState
        #Go through the entire array of characters from left to right
        foreach ($i in (2..($tmpArray.Length - 3))) {
            #Grab the "current" string which is the current pot and two pots left and two pots right.
            $current = "" + $initialState[$i - 2] + $initialState[$i - 1] + $initialState[$i] + $initialState[$i + 1] + $initialState[$i + 2]
            #If the current string matches any of the rules, replace the character in the character array.
            foreach ($rule in $rulesHash.Keys) {
                if ($rule -eq $current) {
                    $tmpArray[$i] = $rulesHash[$rule]
                }
            }
        }
        #After looping through the entire character array, copy it back to the initial state string. Repeat 20 times.
        $initialState = $tmpArray -join ""
    }

    #Count the thing
    $sum = 0
    #Convert into an array because I like arrays and it makes counting the indexes easier.
    $countCharArray = [char[]]$initialState
    foreach ($i in 0..($countCharArray.Length - 1)) {
        #If the current index has a #, add it to the sum, but subtract 10 because of the padding.
        if ($countCharArray[$i] -eq "#") {
            $sum += $i - 10
        }
    }
    
    #This should be the answer.
    write-host $sum
}

Function Part2 {
    #I wrote the output of Part1 from generations 1 to 200 to a text file.
    #After 117 we reached a stable point after which it increased by 73 every generation.
    #Then I fiddled around in Excel to get to this formula.
    (50000000000 * 73) + 1776
}

Part1
Part2