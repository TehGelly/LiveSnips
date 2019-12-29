/*
    Checksum (hashing) example
    v0.0.1
*/
state("notepad") {} // attach to Notepad.exe for testing purposes
/*
    startup{} runs when the script gets loaded
*/
startup {
    print("[LSS - Checksum] » startup{} - script loaded");   
}
/*
    init{} runs if the given process has been found (can occur multiple times during a session; if you reopen the game as an example)
*/
init {
    print("[LSS - Checksum] » init{} - starting checksum calculation");

    /*
        Setting a custom module or using the standard/main module
    */
    // ProcessModuleWow64Safe module = modules.First();
    ProcessModuleWow64Safe module = modules.Single(x => String.Equals(x.ModuleName, "notepad.exe", StringComparison.OrdinalIgnoreCase));

    // initialising the cryptography factory (we're using SHA512 in this case. MD5 would work aswell but SHA's considered the better option for checksums
    byte[] exe512HashBytes = new byte[0];
	using (var sha = System.Security.Cryptography.SHA512.Create())
	{
		using (var s = File.Open(module.FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
		{
			exe512HashBytes = sha.ComputeHash(s); 
		} 
	}
    string exeHash = exe512HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b); // execute the exe512HashBytes function and storing the hash in the hexadecimal (uppercased) variant

    print("[LSS - Checksum] » init{} - read SHA512-Hash: " + exeHash); // printing our SHA512 checksum
    
    /*
        You might want to compare the generated hash to a list of known ones to decide on what flags (in this case versions) your splitting logic should react to 
    */
    switch(exeHash) {
        case "5C13FDB1E973D146F6BC33083A023D18BB54D075D7FDEDF38020021852D3B03FACE242C2593E872E4E34B5B8204938D19BDE0E41C86A567CBCC46FEC9C2105FB":
            vars.version = "NOTEPAD[18362.535]";
            break;
        default:
            vars.version = "NOTEPAD[UNKNOWN VERSION]";
            break;
    }
    print("[LSS - Checksum] » init{} - detected version: " + vars.version);
}

/*
    ==============
    EXAMPLE OUTPUT
    ==============

    [0000] [ASL/00000000] Connected to game: notepad (using default state descriptor) 
    [0000] LiveSplit.exe Information: 0 : 
    [0000] [ASL/00000000] Initializing 
    [0000] LiveSplit.exe Information: 0 : 
    [0000] [LSS - Checksum] » init{} - starting checksum calculation 
    [0000] LiveSplit.exe Information: 0 : 
    [0000] [LSS - Checksum] » init{} - read SHA512-Hash: 5C13FDB1E973D146F6BC33083A023D18BB54D075D7FDEDF38020021852D3B03FACE242C2593E872E4E34B5B8204938D19BDE0E41C86A567CBCC46FEC9C2105FB 
    [0000] LiveSplit.exe Information: 0 : 
    [0000] [LSS - Checksum] » init{} - detected version: NOTEPAD[18362.535] 
    [0000] LiveSplit.exe Information: 0 : 
    [0000] [ASL/00000000] Init completed, running main methods
*/