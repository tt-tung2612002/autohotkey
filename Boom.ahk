#Include %A_ScriptDir%
#Include GetMonitorIndex.ahk
#Include <Gdip_All>
#Include <Gdip_ImageSearch>
#Include BoomUtils.ahk

#NoEnv
#MaxThreadsPerHotkey 1
#singleinstance force
#persistent

Gui, +hwndhGui
Process, Priority,, High
SendMode, Input
CoordMode, Mouse, Client
SetWorkingDir, %A_ScriptDir%
DetectHiddenWindows On

gui, +LastFound
gui, font, S14, Consolas
gui, add, Checkbox, vJoinRoom h25, Join Room: ; Save this control's position and start a new section.
gui, add, Checkbox, vHasPassword h25, Password:
Gui, add, CheckBox, vMainAccount, Main Account
Gui, add, CheckBox, vSecondAccount, Second Account
Gui, add, CheckBox, vChangeWaterBall, Change Water Ball
gui, add, edit, vRoom ys w100 h25
gui, add, edit, vPass w100 h25
; gui, add, Button, , Update

gui, show, , Controller
CurrentMonitorIndex:=GetCurrentMonitorIndex()
Gui, Show, Hide
GUI_Hwnd := WinExist()
GetClientSize(GUI_Hwnd,GUI_Width,GUI_Height)
DetectHiddenWindows Off
GUI_X:=CoordXCenterScreen(GUI_Width,CurrentMonitorIndex)
GUI_Y:=CoordYCenterScreen(GUI_Height,CurrentMonitorIndex)
Gui, Show, % "x" GUI_X+700 " y" GUI_Y, Controller

global inGame := 0
global inRoom := 0

Loop
{
    DetectHiddenWindows Off
    GuiControlGet, MainAccount
    GuiControlGet, SecondAccount
    GuiControlGet, ChangeWaterBall
    GuiControlGet, JoinRoom

    if MainAccount
    {
        if not SecondAccount
        {
            Process, Exist, CA.exe
            If not ErrorLevel
            {
                Process, Exist, Patcher.exe
                If not ErrorLevel
                {
                    LogIn("Boom", "tung261", "tung261")
                    inGame := 0
                    inRoom := 0
                }
            }
        }
        else
        {
            WinGetTitle, BoomTitle, Boom
            If (BoomTitle != "Boom")
            {
                Process, Exist, Patcher.exe
                If not ErrorLevel
                {
                    LogIn("Boom", "tung261", "tung261")
                    inGame := 0
                    inRoom := 0
                }
            }
        }

    }
    if MainAccount && SecondAccount
    {
        WinGetTitle, BoomTittle, Boom2
        If (BoomTittle != "Boom2")
        {
            Process, Exist, Patcher.exe
            If not ErrorLevel
                LogIn("Boom2", "tttung261", "Tung2612002.")
        }

    }

    if MainAccount && JoinRoom
    {
        WinWait, Boom
        Sleep, 2000
        GuiControlGet, Room
        GuiControlGet, Pass
        if (Room = "")
        {
            CreateRoom("Boom", inGame)
            inRoom := 1
            ; Sleep, 500
            Sleep, 800
            GetReady("Boom")
            inRoom := 1
        }
        else {
            JoinRoom(Room, Pass, "Boom")
            inRoom := 1
            Sleep, 800
            inGame := 1
        }
        ; GuiControlGet, Pass
        ; JoinRoom(Room, Pass, "Boom")
    }

    if ChangeWaterBall && not inRoom && not inGame
    {
        CreateRoom("Boom2", inGame)
        Sleep 850
        ChangeCharacterColor("Boom2")
        ; WinWait, Boom
        ; Sleep, 200
        GuiControlGet, Room
        GuiControlGet, Pass
        JoinRoom(FindRoom("Boom2"), Pass, "Boom")
        Sleep 1600
        inRoom := 1
        GetReady("Boom2")
        inGame := 1
        WinActivate, Boom
        Sleep 1000
    }
}

^g:: Gui, % WinExist("ahk_id" . hGui) ? "Hide" : "Show"
Return

#IfWinActive Boom
    z::1
#IfWinActive
Return

#IfWinActive Boom2
    z::1
#IfWinActive
Return

!q::
    ; Run, taskkill /im CA.exe /f
    WinGet, boomID, PID, Boom
    Run, taskkill /pid %boomID% /f
return

; ^z:: ; Control+Alt+Z hotkey.
;     MouseGetPos, MouseX, MouseY
;     PixelGetColor, color, %MouseX%, %MouseY%
;     MsgBox The color at the current cursor position is %color%.
; return
; reload on ctrl-r
^r::Reload
^q::ExitApp
