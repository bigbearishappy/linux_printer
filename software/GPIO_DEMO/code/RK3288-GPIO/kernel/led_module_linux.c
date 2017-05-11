#include <linux/module.h>
#include <linux/types.h>
#include <linux/gpio.h>
#include <linux/of_gpio.h>
#include <linux/poll.h>

#include "led_module_linux.h"
#include "led_module.h"

static int led_open(struct inode *inode, struct file *file)
{
	int ret = 0;
	
	log("into led open");
	ret = led_module_open(file);
	
	if(ret == 0)
		try_module_get(THIS_MODULE);
	
	return ret;
}

static int led_release(struct inode *inode, struct file *file)
{
	log("into led release");
	
	led_module_close(file);
	module_put(THIS_MODULE);
	return 0;
}

static long led_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
	log("into led ioctl");
	
	return led_module_ioctl(file, cmd, arg);
}

/*user operation*/
static struct file_operation led_fops = {
	.owner 			= THIS_MODULE,
	.unlocked_ioctl = led_ioctl,
	.open			= led_open,
	.release		= led_release,
};

static struct miscdevice ledm_misc = {
	.minor = MISC_DYNAMIC_MINOR,
	.name  = DEV_NAME,
	.fops  = &led_fops,
};


static struct of_device_id led_match_table[] = {
	{ .compatible = "bbear,BBear-led-module", },
	{ },
};

static struct platform_driver led_driver = {
	.driver.name	= "BBear-led-module"
	.driver.owner	= THIS_MODULE,
	
	.probe		= led_probe,
	.remove		= led_remove,
	.suspend	= led_suspend,
	.resume		= led_resume,
};


