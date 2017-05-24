#ifndef LED_H
#define LED_H

#define DEBUG
#ifdef DEBUG

#include <cutils/log.h>
// 引入log头文件
#include <android/log.h>
#include <sys/ioctl.h>

// log标签
#define  TAG    "com_pax_paxprint"
// 定义info信息
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO,TAG,__VA_ARGS__)
// 定义debug信息
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, TAG, __VA_ARGS__)
// 定义error信息
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR,TAG,__VA_ARGS__)


#if 0
#define log(...) do{\	
	printf("PRT-LIB<%d><%s>", __LINE__, __FUNCTION__);\
	printf(__VA_ARGS__);\
	printf("\r\n");\
	LOGE("PRT-LIB<%d><%s>", __LINE__, __FUNCTION__); \
	LOGE(...)(__VA_ARGS__);\
	LOGE("\r\n");\
}while(0)

#define logHex(s, l, ...)do{\
	int i;\                                                                                                              
	LOGE("PRT-LIB<%d><%s>", __LINE__, __FUNCTION__);\
	LOGE(__VA_ARGS__);\
	for(i=0; i<l; i++) LOGE("<%02X>", s[i]);\
		LOGE("\r\n");\
}while(0)
#else
#define log(...) 
#define logHex(s, l, ...)
#endif



#else
#define log(...)
#define logHex(s, l, ...)
#endif 


#define BBEARLED_MAGIC_NUMBER  246
#define IOCTL_LEDM_RESET			_IO(BBEARLED_MAGIC_NUMBER, 0)
#define IOCTL_LEDM_TWINKLE			_IO(BBEARLED_MAGIC_NUMBER, 1)

int OsLedOpen(void);
void OsLedClose(void);
int OsLedReset(void);
int OsLedTwinkle(void);

#endif


