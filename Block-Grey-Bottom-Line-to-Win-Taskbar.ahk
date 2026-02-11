#Persistent
#NoEnv
#NoTrayIcon
SetWinDelay, -1

Gui, +AlwaysOnTop -Caption +ToolWindow +E0x20
Gui, Color, 000000 
Gui, Show, Hide x0 y%A_ScreenHeight% w%A_ScreenWidth% h2, BlackBar

SetTimer, DynamicChecker, 300
return

DynamicChecker:
MaskNeeded := false

WinGet, id, List
Loop, %id%
{
    this_id := id%A_Index%
    WinGet, WinState, MinMax, ahk_id %this_id%
    WinGetClass, WinClass, ahk_id %this_id%
    WinGet, Style, Style, ahk_id %this_id%
    
    if (!WinExist("ahk_id" this_id) || WinClass = "Progman" || WinClass = "WorkerW" || WinClass = "Shell_TrayWnd")
        continue

    if (WinState = 1)
    {
        IsFullscreen := !(Style & 0x200000) && !(Style & 0xC00000)
        if (!IsFullscreen)
        {
            MaskNeeded := true
            break 
        }
    }
}

if (MaskNeeded)
{
    yPos := A_ScreenHeight - 2
    Gui, Show, x0 y%yPos% h2 NoActivate, BlackBar
}
else
{
    Gui, Hide
}
return