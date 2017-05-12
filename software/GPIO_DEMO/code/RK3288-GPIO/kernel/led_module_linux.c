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

static int led_init_gpio(struct led_module_platform_data *pdata)
{
	int ret = 0;
	
	ret = gpio_request(pdata->led_pin, "LED_PIN");
	if(ret < 0){
		log_err("request led_pin failed:%d", ret);
	}
	
	ret = gpio_direction_output(pdata->led_pin, 0);
	if(ret < 0){
		log_err("set led_pin to output failed:%d",ret);
		goto lbl_free1;
	}
	
	return 0;
	
lbl_free1:
	gpio_free(pdata->led_pin);
	
	return -ENODEV;
}

static int led_parse_dt(struct device *dev, struct led_module_platform_data *pdata)
{
	struct device_node *np = dev->of_node;
	enum of_gpio_flags flags;
	
	pdata->led_pin = of_get_named_gpio_flags(np, "led-ctl", 0, &flags);
	if(!gpio_is_valid(pdata->led_pin)){
		log_err("invalid gpio: %d\n", pdata-led_pin);
		return -EINVAL;
	}
	
	log("led_pin = %d", pdata->led_pin);
	return led_init_gpio(pdata);
}

static int led_probe(struct platform_driver *led)
{
	int ret = 0;
	struct led_module_platform_data data;
	
	log("probe start");
	if(led->dev.of_node){
		ret = led_parse_dt(&led->dev,&data);
		if(ret)
			return ret;
	}
	else{
		log_err("Can't find dev.of_node");
		return -1;
	}
	
	ledm = kzalloc(sizeof(*ledm), GFP_KERNEL);
	if(!prtm){
		log_err("failed to allocate memory for ledm");
		return -ENOMEM;
	}
	
	ledm->misc_dev = &ledm_misc;
	
	ret = misc_register(&ledm_misc);
	if(ret){
		log_err("can't register miscdev for led(err=%d)\n", ret);
		goto lbl_init_misc;
	}
	
	ret = led_module_init(ledm);
	if(ret < 0){
		log_err("led module init failed<%d>", ret);
		goto lbl_init_failed;
	}
	
	log("probe finish");
	return 0;
	
lbl_init_failed:
	misc_deregister(ledm->misc_dev);
lbl_init_misc:
	kfree(ledm);
	return ret;	
}

static struct of_device_id led_match_table[] = {
	{ .compatible = "bbear,BBear-led-module", },
	{ },
};

static struct platform_driver led_driver = {
	.driver.name	= "BBear-led-module"
	.driver.owner	= THIS_MODULE,
	.driver.of_match_table = led_match_table,
	
	.probe		= led_probe,
};

static int __init led_init(void)
{
	return platform_device_register(&led_driver);
}

static void __exit led_exit(void)
{
	platform_device_unregister(&led_driver);
}

module_init(led_init);
module_exit(led_exit);

MODULE_AUTHOR("BBear");
MODULE_DESCRIPTION("BBear led module");
MODULE_LICENSE("GPL");

