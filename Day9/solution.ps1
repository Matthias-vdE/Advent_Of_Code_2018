# Solution for https://adventofcode.com/2018/day/9

Function Part1 {
    $input = Get-Content .\input.txt
    $split = $input -split ' '

    $Playfield = New-Object -TypeName System.Collections.ArrayList
    $numberofplayers = $split[0]
    $lastmarble = ([int]$split[6] * 100)

    #Playerscoretable
    $playerScoreTable = @{}
    for ($i = 0; $i -lt $numberofplayers; $i++) {
        $playerScoreTable.Add($i, 0)
    }

    #add the first marble to the play field
    $Playfield.Add(0)

    #keep playing until we're out of marbles
    $currentPosition = 0
    $currentplayer = 0

    for ($i = 1; $i -lt $lastmarble; $i++) {
        write-host $i

        #Edge case
        if ($i % 23 -eq 0) {
            $playerScoreTable[$currentplayer] += $i
            $marbletoremove = ($currentPosition - 7)

            #Figure out what should happen if underflow
            if ($marbletoremove -lt 0) {
                $marbletoremove = $Playfield.Count - [System.Math]::Abs($marbletoremove)
                $marbletoremovevalue = $Playfield[$marbletoremove]
                $playerScoreTable[$currentplayer] += $marbletoremovevalue
                $Playfield.RemoveAt($marbletoremove)
                $currentPosition = $marbletoremove
                if ($currentPosition -gt $Playfield.Count) {
                    $currentPosition = 0
                }

            }
            else {
                $marbletoremovevalue = $Playfield[$marbletoremove]
                $playerScoreTable[$currentplayer] += $marbletoremovevalue
                $Playfield.RemoveAt($marbletoremove)
                $currentPosition = $marbletoremove
            }
        }
        else {
            #Figure out where to place the marble.
            $positionToPlaceMarble = $currentPosition + 2
            if ($positionToPlaceMarble -gt $Playfield.Count) {
                $positionToPlaceMarble = 1
                $Playfield.Insert($positionToPlaceMarble, $i)
            }
            else {
                $Playfield.Insert($positionToPlaceMarble, $i)
            }
            $currentPosition = $positionToPlaceMarble
        }

        $currentplayer += 1
        if ($currentplayer -ge $numberofplayers) {
            $currentplayer = 0
        }

    }

    $playerScoreTable.GetEnumerator() | Sort-Object Value -Descending
} 

Function Part2 {
    # The same. Just do * 100.
}

Part1