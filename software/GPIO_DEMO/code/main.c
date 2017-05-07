#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <osal.h>
#include <GPIO_demo.h>
#include <sys/time.h>
#include <time.h>

int GPIO_test(int cmd){
	int ret = 0x00;
	
	ret  = GPIO_open();
	if(ret < 0){
		printf("open GPIO failed:%d",ret);
		return -1;
	}
	
	if(cmd){
		//change all the GPIO to high
	}
	else{
		//change all the GPIO to low
	}
	
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
	printf("1 change the GPIO to high");
	printf("0 change the GPIO to low");
	
	return 0;
}