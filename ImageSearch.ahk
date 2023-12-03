#NoEnv
#SingleInstance, Force
#Include <Gdip_All>
#Include <Gdip_ImageSearch>
Process, Priority,, High
SetTitleMatchMode, 3
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

Coordmode, Pixel, Screen
Coordmode, Mouse, Screen
gdipToken := Gdip_Startup()

ClickPositionOnClient2(title, posImage){
    Loop , 3
    {
        bmpHaystack := Gdip_BitmapFromHWND(WinExist(title))
        bmpNeedle := Gdip_CreateBitmapFromFile(posImage)
        RET := Gdip_ImageSearch(bmpHaystack,bmpNeedle,MyLIST,0,0,0,0,50,0xFFFFFF,1,0)
        Gdip_DisposeImage(bmpHaystack)
        Gdip_DisposeImage(bmpNeedle)
    }

    return MyLIST

}
ClickPositionOnClient(title, posImage, offsetX, offsetY){
    Loop , 5
    {
        bmpHaystack := Gdip_BitmapFromHWND(WinExist(title))
        oFile:=a_scriptdir "\haystack.png"
        Gdip_SaveBitmapToFile(bmpHaystack, oFile)
        bmpNeedle := Gdip_CreateBitmapFromFile(posImage)
        RET := Gdip_ImageSearch(bmpHaystack,bmpNeedle,MyLIST,0,0,0,0,50,0xFFFFFF,1,0)
        Gdip_DisposeImage(bmpHaystack)
        Gdip_DisposeImage(bmpNeedle)
    }

    Loop, Parse, MyLIST, `n
    {
        StringSplit, Coord, A_LoopField, `,
        posX := Coord1 + offsetX
        posY := Coord2 + offsetY
        SetControlDelay, -1
        ControlClick, x%posX% y%posY%, %tittle%,,,2, Pos
        ; Sleep, 200
    }
}

FindImageOnClient(title, image, haystack)
{
    Loop , 3
    {
        bmpHaystack := Gdip_BitmapFromHWND(WinExist(title))
        oFile:=a_scriptdir "/haystack.png"
        Gdip_SaveBitmapToFile(bmpHaystack, oFile)
        bmpNeedle := Gdip_CreateBitmapFromFile(image)
        RET := Gdip_ImageSearch(bmpHaystack,bmpNeedle,MyLIST,0,0,0,0,50,0xFFFFFF,1,0)
        Gdip_DisposeImage(bmpHaystack)
        Gdip_DisposeImage(bmpNeedle)
    }

    return MyLIST = "" ? 0 : 1
}

; Gdip_Shutdown(gdipToken)

; EXIT_LABEL:
;     Gdip_Shutdown(gdipToken)
; EXITAPP

; ^r::Reload
