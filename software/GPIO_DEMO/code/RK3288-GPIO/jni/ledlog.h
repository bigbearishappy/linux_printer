#ifndef LED_LOG_H
#define LED_LOG_H

#include <jni.h>
#include <assert.h>
#include <android/log.h>

static const char *TAG="com_util_ledctl";
#define LOGI(fmt, args...) __android_log_print(ANDROID_LOG_INFO,  TAG, "[%s %d]"fmt, __func__, __LINE__, ##args)
#define LOGD(fmt, args...) __android_log_print(ANDROID_LOG_DEBUG, TAG, "[%s %d]"fmt, __func__, __LINE__, ##args)
#define LOGE(fmt, args...) __android_log_print(ANDROID_LOG_ERROR, TAG, "[%s %d]"fmt, __func__, __LINE__, ##args)

#endif
