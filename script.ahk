#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Source for multi-line input box: http://stackoverflow.com/questions/25722818/autohotkey-inputbox-with-multiline-input
MultiLineInputBox(Text:="", Defualt:="", Caption:="Multi Line Input Box"){
    static
    ButtonOK:=ButtonCancel:= false
    if !MultiLineInputBoxGui{
        Gui, MultiLineInputBox: add, Text, r1 w600  , % Text
        Gui, MultiLineInputBox: add, Edit, r10 w600 vMultiLineInputBox, % Defualt
        Gui, MultiLineInputBox: add, Button, w60 gMultiLineInputBoxOK , &OK
        ; Gui, MultiLineInputBox: add, Button, w60 x+10 gMultiLineInputBoxCancel, &Cancel
        MultiLineInputBoxGui := true
    }
    GuiControl,MultiLineInputBox:, MultiLineInputBox, % Defualt
    Gui, MultiLineInputBox: Show,, % Caption
    SendMessage, 0xB1, 0, -1, Edit1, A
    while !(ButtonOK||ButtonCancel)
        continue

    if ButtonCancel        

	return

    Gui, MultiLineInputBox: Submit, NoHide
    Gui, MultiLineInputBox: Cancel
    return MultiLineInputBox
    ;----------------------
    MultiLineInputBoxOK:
    ButtonOK:= true
    return
    ;---------------------- 
    MultiLineInputBoxGuiEscape:
    MultiLineInputBoxCancel:
    ButtonCancel:= true
    Gui, MultiLineInputBox: Cancel
    return
}

HISTORY_NOTES := MultiLineInputBox("Please enter your History notes as raw text.", "", "History Notes Input")

; MsgBox, %HISTORY_NOTES%

; InputBox, HISTORY_NOTES, History Notes Input, Please enter your History notes as raw text.

HISTORY_NOTES_FIXED := RegExReplace(HISTORY_NOTES, "(_)+", "_", TOTAL_BLANKS_COUNT)
clipboard = %HISTORY_NOTES_FIXED%
MsgBox, New notes have been copied to the clipboard. There are %TOTAL_BLANKS_COUNT% blank(s) in total in your notes. Good luck!
ExitApp
