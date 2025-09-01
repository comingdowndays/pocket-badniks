PCMPointerTable::
; format:
; db bank
; dw pointer to cry

MACRO pcm_def
\1_id::
	dba \1
ENDM

	pcm_def JirachiCry1

MACRO pcm
; All of the pcm data has one trailing byte that is never processed.
	dw .End - .Start - 1
.Start
	\1
.End
ENDM


SECTION "PCM Data 1", ROMX

JirachiCry1::
	;pcm INCBIN "audio/pcm/jiracry1.pcm"
	pcm INCBIN "audio/pcm/snd_splat.pcm"
