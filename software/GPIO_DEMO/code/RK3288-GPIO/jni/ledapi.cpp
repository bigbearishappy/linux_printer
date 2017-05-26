#include <pthread.h>
#include <sys/file.h>//flock's head
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <android/log.h>
#include <errno.h>
#include <binder/IServiceManager.h>
#include <binder/IBinder.h>
#include <binder/Parcel.h>
#include <binder/ProcessState.h>
#include <binder/IPCThreadState.h>
#include <private/binder/binder_module.h>
#include <string.h>

#include "ledapi.h"
#include "ledlog.h"

using namespace android;
#define TAG "LEDCLI"

extern "C"{
	int led_init(void)
	{
		int ret = 0;
		ret = OsLedOpen();
		if(ret)
			LOGE(TAG, "led open failed");
		else
			LOGE(TAG, "led open success");
		return ret;
	}
	
	void led_close(void)
	{
		OsLedClose();
	}
	
	int led_reset(void)
	{
		LOGE(TAG, "led reset");
		return OsLedReset();
	}
	
	int led_twinkle(void)
	{
		LOGE(TAG, "led twinkle");
		return OsLedTwinkle();
	}
}