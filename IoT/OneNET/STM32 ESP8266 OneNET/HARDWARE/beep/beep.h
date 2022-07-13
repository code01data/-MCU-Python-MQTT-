#ifndef _BEEP_H_
#define _BEEP_H_







typedef struct
{

	_Bool Beep_Status;

} BEEP_INFO;

#define BEEP_ON		0
#define BEEP_OFF	1

extern BEEP_INFO beepInfo;




void Beep_Init(void);

void Beep_Set(_Bool status);


#endif
