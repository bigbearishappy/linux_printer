#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/platform_device.h>
#include <linux/gpio.h>
#include <linux/of.h>
#include <linux/of_gpio.h>
#include <linux/fs.h>
#include <asm/uaccess.h>

#define LED_CNT   4

static int  major;
static struct cdev  led_cdev;   //内核中用cdev描述一个字符设备
static struct class *cls;
static int led1,led2,led3,led4;

static ssize_t led_write(struct file *file, const char __user *user_buf, size_t count, loff_t *ppos)
{
    char buf;
    int minor = iminor(file->f_inode);

    printk("minor is %d\n",minor);
    printk("%s\n",__func__);
    if(count != 1){
        printk("count != 1\n"); 
        return 1;
    }
    if (copy_from_user(&buf, user_buf, count))
        return -EFAULT;

    printk("rcv %d\n",buf);
    if(buf == 0x01)
    {
        switch(minor){
        case 0:
            gpio_set_value(led1, 0);
            break;
        case 1:
            gpio_set_value(led2, 0);
            break;
        case 2:
            gpio_set_value(led3, 0);
            break;
        case 3:
            gpio_set_value(led4, 0);
            break;
        default:
            printk("%s rcv minor error\n",__func__);
        }                       
    }
    else if(buf == 0x0)
    {
        switch(minor){
        case 0:
            gpio_set_value(led1, 1);
            break;
        case 1:
            gpio_set_value(led2, 1);
            break;
        case 2:
            gpio_set_value(led3, 1);
            break;
        case 3:
            gpio_set_value(led4, 1);
            break;
        default:
            printk("%s rcv minor error\n",__func__);
        }       
    }
}
static int led_open(struct inode *inode, struct file *file)
{
    printk("led_open\n");
    return 0;
}

static struct file_operations led_fops = {
    .owner = THIS_MODULE,
    .open  = led_open,
    .write = led_write,
};

static int led_probe(struct platform_device *pdev) {

    struct device *dev = &pdev->dev;
    dev_t devid;
    struct pinctrl *pctrl;
    struct pinctrl_state *pstate;
    pctrl = devm_pinctrl_get(dev);
    if(pctrl == NULL)
    {
        printk("devm_pinctrl_get error\n");
    }
    pstate = pinctrl_lookup_state(pctrl, "led_demo");
    if(pstate == NULL)
    {
        printk("pinctrl_lookup_state error\n");
    }
    pinctrl_select_state(pctrl, pstate);//设置为输出模式 
    printk("enter %s\n",__func__);
    led1 = of_get_named_gpio(dev->of_node, "tiny4412,int_gpio1", 0);;
    led2 = of_get_named_gpio(dev->of_node, "tiny4412,int_gpio2", 0);;
    led3 = of_get_named_gpio(dev->of_node, "tiny4412,int_gpio3", 0);;
    led4 = of_get_named_gpio(dev->of_node, "tiny4412,int_gpio4", 0);;
    if(led1 <= 0)
    {
        printk("%s error\n",__func__);
        return -EINVAL;
    }
    else
    {
        printk("led1 %d\n",led1);
        printk("led2 %d\n",led2);
        printk("led3 %d\n",led3);
        printk("led4 %d\n",led4);
        devm_gpio_request_one(dev, led1, GPIOF_OUT_INIT_HIGH, "LED1");
        devm_gpio_request_one(dev, led2, GPIOF_OUT_INIT_HIGH, "LED2");
        devm_gpio_request_one(dev, led3, GPIOF_OUT_INIT_HIGH, "LED3");
        devm_gpio_request_one(dev, led4, GPIOF_OUT_INIT_HIGH, "LED4");
    }

    if(alloc_chrdev_region(&devid, 0, LED_CNT, "led") < 0)/* (major,0~1) 对应 hello_fops, (major, 2~255)都不对应hello_fops */
    {
        printk("%s ERROR\n",__func__);
        goto error;
    }
    major = MAJOR(devid);                     

    cdev_init(&led_cdev, &led_fops);        //绑定文件操作函数
    cdev_add(&led_cdev, devid, LED_CNT);    //注册到内核

    cls = class_create(THIS_MODULE, "led"); //创建led类,向类中添加设备,mdev会帮我们创建设备节点
    device_create(cls, NULL, MKDEV(major, 0), NULL, "led0"); 
    device_create(cls, NULL, MKDEV(major, 1), NULL, "led1"); 
    device_create(cls, NULL, MKDEV(major, 2), NULL, "led2"); 
    device_create(cls, NULL, MKDEV(major, 3), NULL, "led3"); 

error:
    unregister_chrdev_region(MKDEV(major, 0), LED_CNT);
    return 0;
}

static int led_remove(struct platform_device *pdev) {

    printk("enter %s\n",__func__);
    device_destroy(cls, MKDEV(major, 0));
    device_destroy(cls, MKDEV(major, 1));
    device_destroy(cls, MKDEV(major, 2));
    device_destroy(cls, MKDEV(major, 3));
    class_destroy(cls);

    cdev_del(&led_cdev);
    unregister_chrdev_region(MKDEV(major, 0), LED_CNT);

    printk("%s enter.\n", __func__);
    return 0;
}

static const struct of_device_id led_dt_ids[] = {
    { .compatible = "tiny4412,led_demo", },
    {},
};

MODULE_DEVICE_TABLE(of, led_dt_ids);

static struct platform_driver led_driver = {
    .driver        = {
        .name      = "led_demo",
        .of_match_table    = of_match_ptr(led_dt_ids),
    },
    .probe         = led_probe,
    .remove        = led_remove,
};

static int led_init(void){
    int ret;
    printk("enter %s\n",__func__);
    ret = platform_driver_register(&led_driver);
    if (ret)
        printk(KERN_ERR "led demo: probe failed: %d\n", ret);

    return ret; 
}

static void led_exit(void)
{
    printk("enter %s\n",__func__);
    platform_driver_unregister(&led_driver);
}

module_init(led_init);
module_exit(led_exit);

MODULE_LICENSE("GPL");