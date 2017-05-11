#ifndef LED_MODULE_LINUX_H
#define LED_MODULE_LINUX_H

#include <linux/miscdevice.h>
#include <linux/completion.h>
#include <linux/hrtimer.h>

struct led_module_data{
	int led_pin;
	int open_flag;
};

#endif
