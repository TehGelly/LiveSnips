/*
	Settings example
	v0.0.1
*/
state("notepad"){} // attach to notepad.exe for testing purposes

/*
    startup{} runs when the script gets loaded
*/
startup{
	//define your custom settings in this here startup box
	//for the love of god, do NOT define them in init{}

	//settings.Add has four variable, three of which are optional
	//the id, which is required
	settings.Add("Only using the ID here.");
	
	//the default value, which is a boolean describing checked/unchecked
	settings.Add("I'm unchecked by default.",false);
	
	//the description, which is the tooltip you get when you hover over it
	settings.Add("hiddenID",true,"I'm the description!");
	
	//the parent ID, which can be used to make nesting settings
	settings.Add("hiddenID2",true,"I'm only toggleable when my parent is true","hiddenID");
	
	//you can also set the parent id by making it default in the settings object
	settings.CurrentDefaultParent = "hiddenID";
	settings.Add("hiddenID3",true,"Guess who my parent is?");
	
	//do this to change it back to top-level settings
	settings.CurrentDefaultParent = null;
	
	//you can't define tooltips in initialization, but you can change them, like so
	settings.Add("Hover over me!");
	settings.SetToolTip("Hover over me!","Ta-da!");
	
	//this can be used manually, to make a list of settings, like above
	//you can also make lists of splits and initialize with loops
	settings.Add("root",true,"I'm the root of a settings tree!");
	for(int i = 0; i < 3; i++){
		settings.Add("branch" + i,
					 true,
					 "I'm branch number " + i + "!",
					 "root");
		for(int j = 0; j < 3; j++){
			settings.Add("leaf" + (3*i+j),
						  false,
						  "I'm leaf number " + (3*i+j) + "!",
						  "branch" + i);
		}
	}
	
	//this automation can also be used for user-specific things
	//be careful with this cuz this could be a tad invasive
	settings.Add("User List");
	settings.CurrentDefaultParent = "User List";
	vars.dirList = new List<string>();
	string tempPath = "C:\\Users";
	string[] subdirec = Directory.GetDirectories(tempPath);
	foreach(string subdir in subdirec){
		settings.Add(subdir.Substring(9),false);
		vars.dirList.Add(subdir.Substring(9));
	}
	settings.CurrentDefaultParent = null;
	//i've used this for save/log file directory shenanigans
}

/*
    reset{} only runs when the timer's started or paused (will be skipped if update{}'s returning false)
    return true => triggers a reset
*/
reset {
	//this is here so i can make fun of reset{}
	return false;
}

/*
    split{} only runs when the timer's running (and skipped if reset{} returns true)
    return true => triggers a split
*/
split {
	
}
/*
    start{} only runs when the timer's paused
    return true => starts the timer
*/
start {
	//there are some basic settings you can use, although it's pretty rare
	//settings.StartEnabled, settings.SplitEnabled, and settings.ResetEnabled
	//you can do things like this:
	if(settings.ResetEnabled){
		print("Who uses resets?");
	}
	//by default, the start/split/reset blocks use those variables
	//using SplitEnabled in split{} is a waste of time, for example
	//you can't use this functionality in startup{}
	//the one place where it might be useful
	//because we're all slowly doomed and why bother, idk
	
	//to check for a certain setting, 
	//settings["ID"] will return the state of the "ID" setting
	if(settings["hiddenID"]){
		print("The hidden id setting is toggled.");
	}
	
	//if you have a list that you want to go through automagically,
	//keep the list seperate, as you can't iterate through the settings
	foreach(string dir in vars.dirList){
		if(settings[dir]){
			print("You picked " + dir);
		}
	}
	
	//or, if you made your split names predictable, you can use the same sort of for loop
	for(int i = 0; i < 9; i++){
		if(settings["leaf"+i]){
			print("Yay, you have leaf " + i + " selected!");
		}
	}
}