#ifdef CONFIG_OF
#include <linux/of.h>
#include <linux/of_gpio.h>
#endif 
static int firefly_led_probe(struct platform_device *pdev){ 
	int ret =-1; 
	int gpio, flag; 
	struct device_node *led_node = pdev->dev.of_node; 
	gpio = of_get_named_gpio_flags(led_node,"led-power",0,&flag); 
	if(!gpio_is_valid(gpio)){ 
		printk("invalid led-power: %d\n",gpio); 
		return-1; 
		} 
		
	if(gpio_request(gpio,"led_power")){ 
		printk("gpio %d request failed!\n",gpio); 
		return ret; 
		} 
	led_info.power_gpio= gpio; 
	led_info.power_enable_value=(flag == OF_GPIO_ACTIVE_LOW)?0:1; 
	gpio_direction_output(led_info.power_gpio,!(led_info.power_enable_value));
	...on_error: gpio_free(gpio);
}

firefly-led{
	compatible ="firefly,led";
	led-work =<&gpio8 GPIO_A2 GPIO_ACTIVE_LOW>;
	led-power =<&gpio8 GPIO_A1 GPIO_ACTIVE_LOW>;
	status ="okay";
};

#include <linux/gpio.h>
#include <linux/of_gpio.h> 
enum of_gpio_flags { 
OF_GPIO_ACTIVE_LOW =0x1,
}; 

int of_get_named_gpio_flags(struct device_node *np,constchar*propname, int index, enum of_gpio_flags *flags); 
int gpio_is_valid(int gpio); 
int gpio_request(unsigned gpio,constchar*label); 
void gpio_free(unsigned gpio); 
int gpio_direction_input(int gpio);


leds { 
	compatible ="gpio-leds"; 
	power { 
		label ="firefly:blue:power"; 
		linux,default-trigger ="ir-power-click"; 
			  default-state ="on"; 
		gpios =<&gpio8 GPIO_A1 GPIO_ACTIVE_LOW>; 
		}; 
	user{ 
		label ="firefly:yellow:user"; 
		linux,default-trigger ="ir-user-click"; 
			  default-state ="off"; 
		gpios =<&gpio8 GPIO_A2 GPIO_ACTIVE_LOW>; 
		}; 
};