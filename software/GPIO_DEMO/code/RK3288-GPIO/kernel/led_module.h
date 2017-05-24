#ifndef LED_MODULE_H
#define LED_MODULE_H

#include <linux/semaphore.h>
#include <linux/ioctl.h>
#include <linux/spi/spi.h>

#define DEBUG_LED
#ifdef DEBUG_LED

#define log(...) do{\
	printk("LED<%d><%s>", __LINE__, __FUNCTION__);\
	printk(__VA_ARGS__);\
	printk("\r\n");\
}while(0)

#define logHex(s, l, ...)do{\
	int i;\
	printk("LED<%d><%s>", __LINE__, __FUNCTION__);\
	printk(__VA_ARGS__);\
	for(i=0; i<l; i++) printk("<%02X>", s[i]);\
	printk("\r\n");\
}while(0)

#else
#define log(...)
#define logHex(s, l, ...)
#endif

#define log_err(...) do{\
	printk(KERN_ERR"LED<%d><%s>", __LINE__, __FUNCTION__);\
	printk(__VA_ARGS__);\
	printk("\r\n");\
}while(0)
	
#define DEV_NAME "BBear-led-module"
#define BBEARLED_MAGIC_NUMBER	246

#define IOCTL_LEDM_RESET			_IO(BBEARLED_MAGIC_NUMBER, 0)
#define IOCTL_LEDM_TWINKLE			_IO(BBEARLED_MAGIC_NUMBER, 1)

long led_module_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
int led_module_open(struct file *file);
void led_module_close(struct file *file);


#endif
