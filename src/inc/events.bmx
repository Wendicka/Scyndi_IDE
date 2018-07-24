Global EID 
Global ESrc:TGadget 

Function S_WaitEvent()
	WaitEvent
	EID=EventID()
	ESrc=tgadget(EventSource())
End Function