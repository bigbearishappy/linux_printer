#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <osal.h>
#include <printer.h>
#include <sys/time.h>
#include <time.h>
#include <sys/ioctl.h>


int GPIO_test(int cmd){
	int ret = 0x00;
	
	ret  = OsLedOpen();
	if(ret < 0){
		printf("open GPIO failed:%d",ret);
		return -1;
	}
	
	if(cmd){
		OsLedReset();
	}
	else{
		OsLedTwinkle();
	}
	
	OsLedClose();
	return 0;
}

int main(int argc, char *argc[]){
	if(argc < 2){
		printf("enter the cmd");
		return -1;
	}
	else
		GPIO_test(atoi(argv[1]));
	
	printf("GPIO_TEST");
	printf("1 change the GPIO H->L->H");
	printf("0 change the GPIO H->L->H->L->H->H->L");
	
	return 0;
}