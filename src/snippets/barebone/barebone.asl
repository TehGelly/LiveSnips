/*
    [[GAME]]
    Version: 0.0.1
    Author: [[AUTHOR]]
    Compatible Versions:
        Standalone (PC) || W10 (functional) || W7 (untested, might not work)
    
    [[DESCRIPTION]]

    [[CREDITS]]
*/
state("[[GAME]]") {}
/*
    startup{} runs when the script gets loaded
*/
startup {}
/*
    shutdown{} runs when the script gets unloaded (disabling autosplitter, closing LiveSplit, changing splits)
*/
shutdown {}
/*
    init{} runs if the given process has been found (can occur multiple times during a session; if you reopen the game as an example)
*/
init {}
/*
    exit{} runs when the attached process exits/dies
*/
exit {}
/*
    update{} always runs
    return false => prevents isLoading{}, gameTime{}, reset{}
*/
update {}
/*
    isLoading{} only runs when the timer's active (will be skipped if update{}'s returning false)
    return true => pauses the GameTime-Timer till the next tick
*/
isLoading {}
/*
    gameTime{} only runs when the timer's active (will be skipped if update{}'s returning false)
    return TimeSpan object => sets the GameTime-Timer to the passed time 
*/
gameTime {}
/*
    reset{} only runs when the timer's started or paused (will be skipped if update{}'s returning false)
    return true => triggers a reset
*/
reset {}
/*
    split{} only runs when the timer's running (and skipped if reset{} returns true)
    return true => triggers a split
*/
split {}
/*
    start{} only runs when the timer's paused
    return true => starts the timer
*/
start {}