#NoEnv
#SingleInstance, Force
#Include %A_ScriptDir%
#Include ImageSearch.ahk
SetWorkingDir, %A_ScriptDir%
LogIn(WinTitle, Username, UserPass){
    Process, Exist, Patcher.exe
    If not ErrorLevel
    {
        Run, C:\Program Files (x86)\BoomHuyenThoai\Boom\Patcher.exe
        WinWait, ahk_exe Patcher.exe
        CoordMode, Mouse, Client
        WinSetTitle, Boom Launcher
        SetControlDelay, -1
        ControlClick, Button1, ahk_exe Patcher.exe,,,, NA
        Sleep 300
        ControlSetText, Edit1, %Username%, ahk_exe Patcher.exe
        ControlSetText, Edit2, %UserPass%, ahk_exe Patcher.exe
        ; ControlClick, Button1, ahk_exe Patcher.exe
        ControlClick, Button1, ahk_exe Patcher.exe,,,, NA
    }

    WinWait, Crazy Arcade
    WinSetTitle, %WinTitle%
    ControlSend,, {Enter}, %WinTitle%
}
CreateRoom(WinTitle, inGame)
{
    if(inGame != 1)
    {
        ClickPositionOnClient(WinTitle, "exit_game.png", 10, 10)
        Sleep, 830
    }

    ClickPositionOnClient(WinTitle, "create_room_1.png", 10, 10)
    ClickPositionOnClient(WinTitle, "create_room_2_2.png", -52, -95)

    ControlClick, x980 y880, %WinTitle%,,,2, Pos
    GuiControlGet, Pass
    ControlSend,, %Pass%, %WinTitle%
    ClickPositionOnClient(WinTitle, "create_room_2_2.png", 10, 10)
    ClickPositionOnClient(WinTitle, "change_color.png", 10, 10)
}
ChangeCharacterColor(title)
{
    ClickPositionOnClient(title, "green_dt8.png", 10, 10)
    ; ClickPositionOnClient(title, "yellow.png", 10, 10)
}

findRoom(title)
{
    if findImageOnClient(title, "room_s02.png")
    {
        return "s02"
    }
    else if findImageOnClient(title, "room_s03.png")
    {
        return "s03"
    }
    else if findImageOnClient(title, "room_s04.png")
    {
        return "s04"
    }
    else if findImageOnClient(title, "room_s05.png")
    {
        return "s05"
    }
    else if findImageOnClient(title, "room_s06.png")
    {
        return "s06"
    }
    else if findImageOnClient(title, "room_s07.png")
    {
        return "s07"
    }
    else if findImageOnClient(title, "room_s08.png")
    {
        return "s08"
    }
    else if findImageOnClient(title, "room_s09.png")
    {
        return "s09"
    }
    else if findImageOnClient(title, "room_s10.png")
    {
        return "s10"
    }
    else if findImageOnClient(title, "room_s11.png")
    {
        return "s11"
    }
    else if findImageOnClient(title, "room_s12.png")
    {
        return "s12"
    }
    else if findImageOnClient(title, "room_s13.png")
    {
        return "s13"
    }
    else if findImageOnClient(title, "room_s14.png")
    {
        return "s14"
    }
    else if findImageOnClient(title, "room_s15.png")
    {
        return "s15"
    }
    else if findImageOnClient(title, "room_s16.png")
    {
        return "s16"
    }
    else if findImageOnClient(title, "room_s17.png")
    {
        return "s17"
    }
    else if findImageOnClient(title, "room_s18.png")
    {
        return "s18"
    }
    else if findImageOnClient(title, "room_s19.png")
    {
        return "s19"
    }
    else if findImageOnClient(title, "room_s20.png")
    {
        return "s20"
    }
    else if findImageOnClient(title, "room_s21.png")
    {
        return "s21"
    }
    else if findImageOnClient(title, "room_s22.png")
    {
        return "s22"
    }
    return "0"

}

JoinRoom(Room, Pass, WinTitle){
    ControlSend,, /join %Room%, %WinTitle%
    ControlSend,, {Enter}, %WinTitle%

    GuiControlGet, Pass
    if pass != ""
    {
        ControlSend,, %Pass%, %WinTitle%
        ControlSend,, {Enter}, %WinTitle%
        Sleep 800
        ControlClick, x1171 y209, %WinTitle%,,,2, Pos
    }
    else{
        Sleep 800
        ControlClick, x1171 y209, %WinTitle%,,,2, Pos
    }
}

GetReady(WindowTitle){
    ControlSend,, {F5}, %WindowTitle%
}
