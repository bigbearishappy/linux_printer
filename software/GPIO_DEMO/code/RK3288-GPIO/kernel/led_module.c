#include <linux/string.h>
#include <linux/jiffies.h>
#include <linux/spi/spidev.h>
#include <linux/time.h>
#include <linux/delay.h>
#include <linux/slab.h>
#include <linux/sched.h>
#include <linux/fs.h>
#include <linux/wait.h>
#include <linux/workqueue.h>
#include <linux/interrupt.h>
#include <linux/crypto.h>
#include <linux/err.h>
#include <linux/scatterlist.h>
#include <linux/semaphore.h>
#include <linux/gpio.h>
#include <asm/uaccess.h>
#include <asm/io.h>
#include <asm/fcntl.h>
#include <linux/spi/spi.h>
#include <linux/platform_device.h>
#include <linux/capability.h>
#include <linux/mutex.h>
#include <linux/irq.h>
#include <linux/poll.h>

#include "led_module_linux.h"
#include "led_module.h"

struct led_module_data *ledm;

static void ledm_power_ctl(int status)
{
	if(status){
		gpio_set_value(ledm->led_pin, 1);
		msleep(1000);
	}
	else{
		gpio_set_value(ledm->led_pin, 0);
		msleep(1000);
	}
}

/*
cmd description:
1: led on
2: led off
*/
long led_module_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{	
	if(!ledm->open_flag){
		log("led doesn't open");
		return -EACCES;
	}
	
	if(_IOC_TYPE(cmd) != BBEARLED_MAGIC_NUMBER){
		log("invalid cmd");
		return -EINVAL;
	}
	
	switch(cmd){
		case IOCTL_LEDM_RESET:
			ledm_power_ctl(0);
			ledm_power_ctl(1);
			break;
		case IOCTL_LEDM_TWINKLE:
			ledm_power_ctl(0);
			ledm_power_ctl(1);
			ledm_power_ctl(0);
			ledm_power_ctl(1);
			ledm_power_ctl(0);
			ledm_power_ctl(1);
			break;
		default:
			break;
	}
	return 0;	
}

int led_module_open(struct file *file)
{
	ledm->open_flag++;
	gpio_set_value(ledm->led_pin, 1);
	return 0;
}

void led_module_close(struct file *file)
{
	if(ledm->open_flag > 1)
		ledm->open_flag--;
	gpio_set_value(ledm->led_pin, 0);
	
	ledm->open_flag = 0;
}


