<!-- vimvars: b:markdown_embedded_syntax={'sh':'bash'} -->
# Apple Script

## Audio output

Don’t think of it in terms of preferences; there’s no centralized system preference framework for this sort of thing. I believe what you need to do is use Core Audio to set the kAudioHardwarePropertyDefaultOutputDevice and  kAudioHardwarePropertyDefaultSystemOutputDevice properties of the AudioSystemObject (using AudioHardwareSetProperty())


Script for choosing audio output device:
```
tell application "System Preferences" to activate
tell application "System Events"
  get properties
  tell process "System Preferences"
    click menu item "Sound" of menu "View" of menu bar 1
    delay 2
    set theRows to every row of table 1 of scroll area 1 of
      tab group 1 of window "sound"
    set theOutputs to {} as list
    repeat with aRow in theRows
      copy (value of text field 1 of aRow as text) to the end of theOutputs
    end repeat
    tell application "Finder"
      activate
      set desiredOutput to display dialog
        "Choose Sound Output: " buttons theOutputs default button "SoundSticks"
    end tell
    repeat with aRow in theRows
      if (value of text field 1 of aRow as text) is equal to
        (button returned of desiredOutput as text) then
        set selected of aRow to true
        exit repeat
      end if
    end repeat
  end tell
end tell
tell application "System Preferences" to quit
```

## Errors

	execution error: System Events got an error: L’accès pour les périphériques d’aide est désactivé. 
Go to `Finder->Applications->AppleScript->"Utilitaire AppleScript"->"Accès Universel"->"Activer l'accès pour les périphériques d'aide"`

## Exploring

To get all children of an object:
```
get entire contents of ...
```

## Getting monitors info

```
tell application "System Events"
get display name of every desktop
end tell
```

From command line:
```sh
osascript -e 'tell application "System Events" to get display name of every desktop'
```

## Running

command:
```sh
osascript
```

## Setting wallpaper

Set desktop to specific picture:
```
tell application "System Events"
tell current desktop
set picture rotation to 0 -- (0=off, 1=interval, 2=login, 3=sleep)                                                                                                           
set picture to file ":Users:pierrick:Pictures:crestock-50599-2560x1600.jpg"
end tell
end tell
```

## Sleep

Put computer to sleep:
```sh
osascript -e 'tell application "System Events" to sleep'
```
