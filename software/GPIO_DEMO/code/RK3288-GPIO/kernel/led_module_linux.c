#include <linux/module.h>
#include <linux/types.h>
#include <linux/gpio.h>
#include <linux/of_gpio.h>
#include <linux/poll.h>

#include <linux/miscdevice.h>
#include <linux/input.h>
#include <linux/clk.h>
#include <linux/delay.h>
#include <asm/io.h>
#include <asm/uaccess.h>
#include <linux/init.h>
#include <linux/of_platform.h>


#include "led_module_linux.h"
#include "led_module.h"

struct led_module_data * ledm = NULL;

static int led_open(struct inode *inode, struct file *file)
{
	int ret = 0;
	
	log("into led open");
	
	log("*file address:0x%x",(int)file);
	log("file->fops:0x%x",(int)(file->f_op));
	
	ret = led_module_open(file);
	log("into led open finish");
	
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
static struct file_operations led_fops = {
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
    printk("=======================================================\n");
    printk("==== Launching LED  driver! (Powered by XIONGJ) ====\n");
    printk("=======================================================\n");
	
	ret = gpio_request(pdata->led_pin, "LED_PIN");
	if(ret < 0){
		log_err("request led_pin failed:%d", ret);
	}
	
	ret = gpio_direction_output(pdata->led_pin, 1);
	if(ret < 0){
		log_err("set led_pin to output failed:%d",ret);
		goto lbl_free1;
	}
	
	gpio_set_value(pdata->led_pin, 1);
	msleep(1000);
	gpio_set_value(pdata->led_pin, 0);
	msleep(1000);
	gpio_set_value(pdata->led_pin, 1);
	msleep(1000);
	
	return 0;
	
lbl_free1:
	gpio_free(pdata->led_pin);
	
	return -ENODEV;
}

static int led_parse_dt(struct device *dev, struct led_module_platform_data *pdata)
{
	struct device_node *np = dev->of_node;
	enum of_gpio_flags flags;

	printk(KERN_INFO "int to led_parse_dt 22222222222222222222222222222222222222222\n");
	pdata->led_pin =   of_get_named_gpio_flags(np, "pax,prt-pwr-gpio", 0, &flags);
	if(!gpio_is_valid(pdata->led_pin)){
		log_err("invalid gpio: %d\n", pdata->led_pin);
		return -EINVAL;
	}
	
	log("led_pin = %d", pdata->led_pin);
	return led_init_gpio(pdata);
}

//static int led_probe(struct platform_driver *led)
static int led_probe(struct spi_device *led)
{
	int ret = 0;
	struct led_module_platform_data data;
	
	log("led probe start");
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
	if(!ledm){
		log_err("failed to allocate memory for ledm");
		return -ENOMEM;
	}
	
	ledm->misc_dev = &ledm_misc;
	ledm->spi_dev= led;
	ledm->led_pin = data.led_pin;
	
	ret = misc_register(&ledm_misc);
	if(ret){
		log_err("can't register miscdev for led(err=%d)\n", ret);
		goto lbl_init_misc;
	}

	
/*	ret = led_module_init(ledm);
	if(ret < 0){
		log_err("led module init failed<%d>", ret);
		goto lbl_init_failed;
	}
*/
	
	log("probe finish");
	return 0;
	
//lbl_init_failed:
//	misc_deregister(ledm->misc_dev);
lbl_init_misc:
	kfree(ledm);
	return ret;	
}

static int led_remove(struct spi_device *led)
{
	misc_deregister(ledm->misc_dev);
	log("into led_remove");
	return 0;
}


static struct of_device_id led_match_table[] = {
//	{ .compatible = "bbear,BBear-led-module", },
	{ .compatible = "pax,printer-module", },

	{ },
};
//MODULE_DEVICE_TABLE(of,led_match_table);

static struct spi_driver BBear_led_driver = {
	//.driver.name	= "BBear-led-module",
	.driver.name	= "printer-module",
	.driver.owner	= THIS_MODULE,
	.driver.of_match_table = led_match_table,
	//.driver.of_match_table = of_match_ptr(led_match_table),
	
	.probe		= led_probe,
	.remove		= led_remove,
};

/*
static int major = 0;
static struct class *demo_class; 
static int __init led_init(void)
{
	int ret;
	int result = 0;
	struct device *demo_device; 

	log("into led_init");
	
	major = register_chrdev(0, "BBear-led-module", &led_fops); 
	if(major < 0){  
        ret = major;  
        goto chrdev_err;  
    } 

	demo_class = class_create(THIS_MODULE,"BBear-led-module");  
	if(IS_ERR(demo_class)){  
	   ret =  PTR_ERR(demo_class);  
	   goto class_err;	
	} 

	demo_device = device_create(demo_class,NULL, MKDEV(major, 0), NULL,"BBear-led-module");  
	if(IS_ERR(demo_device)){  
	  ret = PTR_ERR(demo_device);  
	  goto device_err;	
	} 

	result = platform_driver_register(&BBear_led_driver);
	log("led init res=%d",result);
	if(result){
		log("led_init error");
	}
	return result;

device_err: 
	class_destroy(demo_class);
class_err:	 
	unregister_chrdev(major, "BBear-led-module");
chrdev_err:
	return ret;

}
*/
static int __init led_init(void)
{
	int result = 0;

	log("into led_init");
	
	result = spi_register_driver(&BBear_led_driver);
	log("led init res=%d",result);
	if(result){
		log("led_init error");
	}
	return result;

}

static void __exit led_exit(void)
{
	log("into led_exit");
	spi_unregister_driver(&BBear_led_driver);
}

module_init(led_init);
module_exit(led_exit);

//module_platform_driver(BBear_led_driver);

MODULE_AUTHOR("BBear");
MODULE_DESCRIPTION("BBear led module");
MODULE_LICENSE("GPL");

