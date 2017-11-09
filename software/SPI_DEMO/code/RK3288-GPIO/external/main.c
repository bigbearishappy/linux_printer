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
	
	switch(cmd){
		case 0:
		OsLedReset();
		break;
		case 1:
		OsLedTwinkle();
		break;
		default:
		break;
	}
	
	OsLedClose();
	return 0;
}

int main(int argc, char *argv[]){
	if(argc < 2){
		printf("enter the cmd");
		return -1;
	}
	else
		GPIO_test(atoi(argv[1]));
	
	printf("GPIO_TEST\n");
	printf("0 change the GPIO H->L->H\n");
	printf("1 change the GPIO H->L->H->L->H->H->L\n");
	
	return 0;
}