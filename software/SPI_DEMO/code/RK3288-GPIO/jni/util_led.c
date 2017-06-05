#include <stdio.h>
#include <unistd.h>
#include <string.h> 
#include <osal.h>
//#include "printer.h"
//#include "print_inter.h"
#include <jni.h>
#include <assert.h>
#include <android/log.h>
#include<cutils/log.h>
#include "paxapiclient.h"

JNIEXPORT jbyte JNICALL Java_com_util_LedOpen(JNIEnv *env, jobject obj)
{
	return led_init();
}

JNIEXPORT jbyte JNICALL Java_com_util_LedClose(JNIEnv *env, jobject obj)
{
	return led_close();
}

JNIEXPORT jbyte JNICALL Java_com_util_LedReset(JNIEnv *env, jobject obj)
{
	return led_reset();
}

JNIEXPORT jbyte JNICALL Java_com_util_LedTwinkle(JNIEnv *env, jobject obj)
{
	return led_twinkle();
}