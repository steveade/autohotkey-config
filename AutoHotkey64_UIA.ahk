#Requires AutoHotkey v2.0.11+ ; Always have a version requirment

SetCapsLockState "AlwaysOff"
; CapsLock up::double_tap_caps() ; Double tap to use esc
; Enter up::double_tap_enter() ; Double tap to use enter

*Enter::
{
	Send "{Blind}{Ctrl Down}"
    KeyWait "Enter"
    Return
}

*Enter Up::
{
	Send "{Blind}{Ctrl Up}"

	if (A_PriorHotkey = "*Enter" AND A_TimeSincePriorHotkey < 250) {
		Send "{Blind}{Enter}"
    }
    Return

}

*CapsLock::
{
    Return
}

*CapsLock Up::
{
	if (A_PriorHotkey = "*CapsLock" AND A_TimeSincePriorHotkey < 250) {
        Send "{Blind}{Esc}"
        Return
    }
}

; f13ActivationThreshold()
; {
; 	sendEnterOnRelease := false
;     Return
; }

double_tap_caps() {
    static last := 0 ; Last time caps was tapped
        , threshold := 200 ; Speed of a double tap in ms
    if (A_TickCount - last < threshold) ; If time since last press is within double tap threshold
        press_esc() ;   Press Enter
        ,last := 0 ;   Reset last to 0 (prevent triple tap from activating it again)
    else last := A_TickCount ; Else not a double tap, update last tap time
    return
    
    press_esc() {
        Send "{Esc}"
    }
}

double_tap_enter() {
    static last := 0
        , threshold := 200
    if (A_TickCount - last < threshold)
        press_enter()
        , last := 0
    else last := A_TickCount
    return

    press_enter() {
        Send "{Enter}"
    }
}

#HotIf GetKeyState('CapsLock', 'P') ; Following hotkeys are enabled when caps is held
*k::Up
h::Left
j::Down
l::Right

u::Send "{=}"
i::Send "{+}"
o::Send "{{}"
p::Send "{}}"

a::Shift
s::Control
d::Alt

Space::End
,::Home

`;::Delete
`;::Send "{]}"
'::Send "{[}"

m::Send "{~}"
n::
{
    state := GetKeyState('CapsLock', 'T') ; Get current caps toggle state
    SetCapsLockState('Always' (state ? 'Off' : 'On')) ; Set it to the opposite
}
#HotIf ; Always reset #HotIf directive when done