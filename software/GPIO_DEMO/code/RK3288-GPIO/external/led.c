#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <cutils/log.h>
#include <linux/ioctl.h>
#include <osal.h>
#include "printer.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>


#include <sys/time.h>
#include <time.h>

#define LED_MODULE "/dev/bbear-led-module"

static int gPrnFd = -1;

int OsLedOpen(void)
{
	int fd;
	
	if(gPrnFd > 0){
		LOGE("Already opened")
		return RET_OK;
	}
	
	if(access(LED_MODULE,F_OK) < 0){
		LOGE("can't find led module");
		return ERR_DEV_NOT_EXIST;
	}
	
	fd = open(LED_MODULE, O_RDWR);
	if(fd < 0){
		LOGE("led module open error");
		return ERR_DEV_NOT_OPEN;
	}
	
	gPrnFd = fd;
	
	LOGE("led open finish");
	return RET_OK;
}

void OsLedClose(void)
{
	if(gPrnFd < 0)
		return ;
	
	close(gPrnFd);
	gPrnFd = -1;
}

int OsLedReset(void)
{
	ioctl(gPrnFd, IOCTL_LEDM_RESET);
	return 0;
}

int OsLedTwinkle(void)
{
	ioctl(gPrnFd, IOCTL_LEDM_TWINKLE);
	return 0;
}
