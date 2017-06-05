LOCAL_PATH:= $(call my-dir)
TEMP_PATH := $(call my-dir)

#libraries
include $(CLEAR_VARS)
LOCAL_SRC_FILES :=  device/msr/magcard.c
LOCAL_SRC_FILES +=  device/picc/emvClApi.c
LOCAL_SRC_FILES +=  device/picc/paxcl.c
LOCAL_SRC_FILES +=  device/picc/picc_api.c
LOCAL_SRC_FILES +=  device/rf/iso14443_3a.c
LOCAL_SRC_FILES +=  device/rf/iso14443_3b.c
LOCAL_SRC_FILES +=  device/rf/iso14443_4.c
LOCAL_SRC_FILES +=  device/rf/iso14443_hal.c
LOCAL_SRC_FILES +=  device/rf/mifare.c
LOCAL_SRC_FILES += device/printer/printer.c

LOCAL_SRC_FILES += device/printer_powerctl/led.c

LOCAL_SRC_FILES += device/barcode/ttyPosApi.c
LOCAL_SRC_FILES += device/barcode/ZM100api.c
LOCAL_SRC_FILES += device/authinfo/authinfo_api.c
LOCAL_SRC_FILES +=  device/verifyimage/verifyimage.c
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include  \
		    $(LOCAL_PATH)/device/authinfo  \
                    $(LOCAL_PATH)/device/verifyimage  \
                    $(LOCAL_PATH)/lib/libencrypt/include
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_SHARED_LIBRARIES := libcutils \
		liblog \
		libutils  \
                libencrypt
LOCAL_MODULE := libpaxdevice
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES :=  lib/libsample/sample.c
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_MODULE := libpaxsamle
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include \
						 $(LOCAL_PATH)/lib/libpaxapisvr \
						 $(LOCAL_PATH)/lib/libpaxapiclient \
					$(LOCAL_PATH)/lib/libSpSys    \
					$(LOCAL_PATH)/lib/libpaxlog \
					$(LOCAL_PATH)/device/authinfo    \
					$(LOCAL_PATH)/lib/libencrypt/include  \
					$(LOCAL_PATH)/device/verifyimage  
LOCAL_SRC_FILES :=  lib/libspdev/spdev.c
LOCAL_SRC_FILES +=  lib/libspdev/ttyPosApi.c
LOCAL_SRC_FILES +=  lib/libspdev/cycle_buffer.c
LOCAL_SRC_FILES +=  lib/libspdev/spdevcomm.c
LOCAL_SRC_FILES +=  lib/libspdev/spdevapi.c
LOCAL_SRC_FILES +=  lib/libspdev/filetomonitor.c
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_SHARED_LIBRARIES := libcutils \
		libSpSys   \
		libencrypt \
		libpaxdevice \
		liblog \
		libutils \
		libpaxlog
		
LOCAL_MODULE := libpaxspdev
include $(BUILD_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include \
					$(LOCAL_PATH)/lib/libucutils/include
						 
LOCAL_SRC_FILES +=  lib/libpaxadapter/cssl.c \
					lib/libpaxadapter/portadapter.c

LOCAL_EXPORT_C_INCLUDE := $(LOCAL_PATH)
LOCAL_SHARED_LIBRARIES := libcutils \
		libutils \
		libpaxspdev\
		libucutils

LOCAL_MODULE := libpaxadapter
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include \
						$(LOCAL_PATH)/lib/libpaxlog \
						 $(LOCAL_PATH)/lib/libpaxapisvr \
						 $(LOCAL_PATH)/lib/libSpSys/include \
						 $(LOCAL_PATH)/lib/libiconv/include \
						 $(LOCAL_PATH)/lib/libpaxapiclient \

						 

LOCAL_SRC_FILES :=  lib/libSpSys/src/file.c
LOCAL_SRC_FILES +=  lib/libSpSys/src/spSys.c
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_SHARED_LIBRARIES := libcutils \
		libutils \
		libiconv \
		libpaxprint \
		libpaxlog
LOCAL_MODULE := libSpSys
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include \
                      $(LOCAL_PATH)/lib/libcfg/include 
LOCAL_SRC_FILES :=  lib/libcfg/src/cfg.c
LOCAL_SRC_FILES +=  lib/libcfg/src/xml.c
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_SHARED_LIBRARIES := libcutils \
		libutils 
LOCAL_MODULE := libpaxcfg
include $(BUILD_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_C_INCLUDES += external/openssl/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libencrypt/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libSpSys/include
LOCAL_C_INCLUDES +=	$(LOCAL_PATH)/lib/libpaxapiclient 

LOCAL_SRC_FILES :=  lib/libencrypt/src/CRC.c
LOCAL_SRC_FILES +=  lib/libencrypt/src/des.c
LOCAL_SRC_FILES +=  lib/libencrypt/src/HASH.c
LOCAL_SRC_FILES +=  lib/libencrypt/src/sha256.c
LOCAL_SRC_FILES +=  lib/libencrypt/src/sha1.c
LOCAL_SRC_FILES +=  lib/libencrypt/src/rsa.c
LOCAL_SRC_FILES +=  lib/libencrypt/src/nn.c
LOCAL_SRC_FILES +=  lib/libencrypt/src/r_keygen.c
LOCAL_SRC_FILES +=  lib/libencrypt/src/prime.c
LOCAL_SRC_FILES +=  lib/libencrypt/src/r_random.c
LOCAL_SRC_FILES +=  lib/libencrypt/src/md5c.c
LOCAL_SRC_FILES +=  lib/libencrypt/src/aes.c

LOCAL_SHARED_LIBRARIES := libcutils \
		libutils \
		libcrypto \
		libSpSys 
LOCAL_MODULE:= libencrypt
include $(BUILD_SHARED_LIBRARY)

#executables
include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include
LOCAL_SRC_FILES :=  bin/msrtest/main.c
LOCAL_SHARED_LIBRARIES := libpaxdevice
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_LDLIBS := -llog 
LOCAL_MODULE := msrtest
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include
LOCAL_SRC_FILES :=  bin/picctest/main.c
LOCAL_SHARED_LIBRARIES := libpaxdevice
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_MODULE := picctest
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include
LOCAL_SRC_FILES :=  bin/picctest/monitormain.c
LOCAL_SHARED_LIBRARIES := libpaxdevice
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_MODULE := picctest_monitor
include $(BUILD_EXECUTABLE)


include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include

LOCAL_SRC_FILES :=  bin/printer_powerctl/main.c

LOCAL_SHARED_LIBRARIES := libpaxdevice
LOCAL_LDLIBS := -llog 
LOCAL_MODULE := printer_powerctl_test
include $(BUILD_EXECUTABLE)


include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include
LOCAL_SRC_FILES :=  bin/printer/main.c
LOCAL_SRC_FILES +=  bin/printer/sell.c
LOCAL_SHARED_LIBRARIES := libpaxdevice
LOCAL_LDLIBS := -llog 
LOCAL_MODULE := printer_test
include $(BUILD_EXECUTABLE)
 

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include \
                        $(LOCAL_PATH)/lib/libpaxapiclient \
						$(LOCAL_PATH)/device/include \
						$(LOCAL_PATH)/lib/libencrypt/include \
						$(LOCAL_PATH)/lib/libSpSys/include \
						$(LOCAL_PATH)/lib/libcfg/include \
						$(LOCAL_PATH)/lib/libiconv/include 

LOCAL_SRC_FILES :=  bin/test/test.c
LOCAL_SHARED_LIBRARIES := libpaxspdev libpaxapi libencrypt libSpSys libcutils libpaxcfg libiconv libpaxprint 
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include 
LOCAL_MODULE := test
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

# compile in ARM mode, since the glyph loader/renderer is a hotspot
# when loading complex pages in the browser
#
LOCAL_ARM_MODE := arm
LOCAL_SRC_FILES:= \
lib/freetype/src/base/ftsystem.c \
lib/freetype/src/base/ftinit.c \
lib/freetype/src/base/ftdebug.c \
lib/freetype/src/base/ftbase.c \
lib/freetype/src/base/ftbbox.c \
lib/freetype/src/base/ftglyph.c \
lib/freetype/src/base/ftbdf.c \
lib/freetype/src/base/ftbitmap.c \
lib/freetype/src/base/ftcid.c \
lib/freetype/src/base/ftfstype.c \
lib/freetype/src/base/ftgasp.c  \
lib/freetype/src/base/ftgxval.c \
lib/freetype/src/base/ftlcdfil.c \
lib/freetype/src/base/ftmm.c  \
lib/freetype/src/base/ftotval.c \
lib/freetype/src/base/ftpatent.c \
lib/freetype/src/base/ftpfr.c  \
lib/freetype/src/base/ftstroke.c   \
lib/freetype/src/base/ftsynth.c \
lib/freetype/src/base/fttype1.c \
lib/freetype/src/base/ftwinfnt.c \
lib/freetype/src/base/ftxf86.c \
lib/freetype/src/bdf/bdf.c \
lib/freetype/src/cid/type1cid.c \
lib/freetype/src/cff/cff.c \
lib/freetype/src/pcf/pcf.c \
lib/freetype/src/pfr/pfr.c \
lib/freetype/src/sfnt/sfnt.c \
lib/freetype/src/truetype/truetype.c \
lib/freetype/src/type1/type1.c \
lib/freetype/src/type42/type42.c \
lib/freetype/src/winfonts/winfnt.c \
lib/freetype/src/raster/raster.c \
lib/freetype/src/smooth/smooth.c \
lib/freetype/src/autofit/autofit.c \
lib/freetype/src/cache/ftcache.c \
lib/freetype/src/gzip/ftgzip.c \
lib/freetype/src/lzw/ftlzw.c \
lib/freetype/src/bzip2/ftbzip2.c \
lib/freetype/src/gxvalid/gxvalid.c \
lib/freetype/src/otvalid/otvalid.c \
lib/freetype/src/psaux/psaux.c \
lib/freetype/src/pshinter/pshinter.c \
lib/freetype/src/psnames/psnames.c 

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/lib/freetype/builds \
	$(LOCAL_PATH)/lib/freetype/include

#LOCAL_CFLAGS += -W -Wall
LOCAL_CFLAGS += -fPIC -DPIC
LOCAL_CFLAGS += "-DDARWIN_NO_CARBON"
LOCAL_CFLAGS += "-DFT2_BUILD_LIBRARY"


# the following is for testing only, and should not be used in final builds
# of the product
#LOCAL_CFLAGS += "-DTT_CONFIG_OPTION_BYTECODE_INTERPRETER"
LOCAL_CFLAGS += -O2
LOCAL_MODULE:= libft2
include $(BUILD_STATIC_LIBRARY)



include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/lib/libpaxprint/include \
										$(LOCAL_PATH)/device/include \
										$(LOCAL_PATH)/lib/freetype/builds \
										$(LOCAL_PATH)/lib/freetype/include \
										$(LOCAL_PATH)/lib/freetype/freetype										
LOCAL_STATIC_LIBRARIES := libft2			
LOCAL_SHARED_LIBRARIES := \
        libcutils \
        libutils \
        libdl \
        libz \
        libpng
        
LOCAL_SRC_FILES :=  lib/libpaxprint/src/print_inter.c \
									  lib/libpaxprint/src/print.c       \
									  lib/libpaxprint/src/freetype_extra.c
									  
LOCAL_MODULE := libpaxprint
include $(BUILD_SHARED_LIBRARY)






#include $(CLEAR_VARS)
#LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include  \
#								    jni/com_pax_paxprint.h
#LOCAL_SRC_FILES:=	jni/com_pax_paxprint.c  
#LOCAL_SHARED_LIBRARIES := libutils  libpaxdevice
#LOCAL_LDLIBS := -llog 
#LOCAL_MODULE := libpaxprint
#include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include
LOCAL_SRC_FILES :=  bin/ttytest/ttyPosApi.c
LOCAL_MODULE := ttytest
include $(BUILD_EXECUTABLE)



include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include
LOCAL_SRC_FILES :=  bin/spi_cs_test/main.c
LOCAL_SHARED_LIBRARIES := libpaxdevice
LOCAL_MODULE := spi_cs_test
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include 
LOCAL_SRC_FILES :=  lib/libpaxlog/paxlog.c
LOCAL_SHARED_LIBRARIES := libutils libcutils
LOCAL_LDLIBS := -llog 
LOCAL_MODULE := libpaxlog
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include \
					$(LOCAL_PATH)/lib/libpaxapiclient \
                   $(LOCAL_PATH)/lib/libpaxlog 
                   
LOCAL_SRC_FILES :=  lib/libpaxev/paxevent.cpp
LOCAL_SHARED_LIBRARIES := libutils libbinder libpaxlog
LOCAL_LDLIBS := -llog 
LOCAL_MODULE := libpaxev
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/lib/libpaxapiclient \
						$(LOCAL_PATH)/device/include  \
						$(LOCAL_PATH)/lib/libpaxlog \
				$(LOCAL_PATH)/device/authinfo   \
				$(LOCAL_PATH)/lib/libspdev
LOCAL_SHARED_LIBRARIES := \
        libcutils \
        libbinder \
        libutils \
        libdl \
        libpaxspdev \
		libencrypt \
		libpaxlog \
		libpaxev \
		libpaxadapter \
		libpaxdevice
        
LOCAL_SRC_FILES :=  lib/libpaxapisvr/paxservice.cpp 
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_MODULE := paxservice
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/lib/libpaxapiclient \
						$(LOCAL_PATH)/device/include \
						$(LOCAL_PATH)/lib/libpaxlog \
						$(LOCAL_PATH)/lib/libencrypt/include \
						$(LOCAL_PATH)/lib/libSpSys/include \
						$(LOCAL_PATH)/lib/libcfg/include   \
						$(LOCAL_PATH)/lib/libauthdownload  \
						$(LOCAL_PATH)/device/authinfo 
						
LOCAL_SHARED_LIBRARIES := \
        libcutils \
        libbinder \
        libutils \
        libdl \
        libpaxdevice \
        libpaxprint \
		libencrypt \
		libSpSys  \
		libpaxlog \
		libpaxcfg  \
		libpaxev \
		libauthdownload
LOCAL_SRC_FILES :=  lib/libpaxapiclient/paxapiclient.cpp
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_MODULE := libpaxapi
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include  \
						$(LOCAL_PATH)/lib/libpaxlog \
					$(LOCAL_PATH)/lib/libpaxapiclient \
					jni/pax_util_OsPaxApi.h   \
					$(LOCAL_PATH)/lib/libbpadownload
LOCAL_SRC_FILES:=	jni/pax_util_OsPaxApi.c 
LOCAL_SHARED_LIBRARIES := libutils libnativehelper libpaxlog  
LOCAL_LDLIBS := -llog 
LOCAL_MODULE := libpaxapijni
include $(BUILD_SHARED_LIBRARY)


include $(CLEAR_VARS)

LOCAL_C_INCLUDES += $(LOCAL_PATH)/jni/include \
                    $(LOCAL_PATH)/device/include \
                    $(LOCAL_PATH)/lib/libpaxapiclient \

LOCAL_SRC_FILES :=  jni/pax_util_MonPrinter.c
LOCAL_SHARED_LIBRARIES := libpaxdevice  \
													libpaxprint \
													libpaxapi
LOCAL_LDLIBS := -llog 
LOCAL_MODULE := libmonprnjni
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES += $(LOCAL_PATH)/jni/include \
                    $(LOCAL_PATH)/device/include \
                    $(LOCAL_PATH)/lib/libpaxapiclient \
                    $(LOCAL_PATH)/lib/libpaxlog \

LOCAL_SRC_FILES :=  jni/Version.c jni/BpaSerialComm.c jni/cmd_pcload.c
LOCAL_SHARED_LIBRARIES := libpaxdevice  libpaxapi libpaxlog
LOCAL_LDLIBS := -llog 
LOCAL_MODULE := libversion
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES += \
	$(JNI_H_INCLUDE) 
LOCAL_SRC_FILES := jni/pax_util_ApComNative.c\
	lib/libspdev/ttyPosApi.c 
LOCAL_SHARED_LIBRARIES := libcutils \
		libutils \
		libnativehelper 
# the assembler is only for the ARM version, don't break the Linux sim
LOCAL_CFLAGS += -O3 -fstrict-aliasing -fprefetch-loop-arrays
LOCAL_MODULE:= libspdevjni
LOCAL_PRELINK_MODULE := false 
include $(BUILD_SHARED_LIBRARY)


include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/lib/libpaxapiclient
LOCAL_SHARED_LIBRARIES := \
        libcutils \
        libbinder \
        liblog \
        libutils \
        libpaxapi \
        libpaxdevice
LOCAL_SRC_FILES :=  bin/paxapitest/paxnative.c bin/paxapitest/paxevent.cpp
#LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_MODULE := paxnative
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libpaxapiclient \
	$(LOCAL_PATH)/lib/librki \
	$(JNI_H_INCLUDE) 

LOCAL_SHARED_LIBRARIES := libpaxapi \
	libcutils \
	liblog \
	libutils \
	libencrypt
	
LOCAL_SRC_FILES := 	lib/librki/common.c \
	lib/librki/common1.c \
	lib/librki/crypt_api.c \
	lib/librki/dbdprint.c \
	lib/librki/ped.c \
	lib/librki/PedAsyKeyStorage.c \
	lib/librki/PedCrc16.c \
	lib/librki/PedCrc32.c \
	lib/librki/PedDrv.c \
	lib/librki/PedKeySave.c \
	lib/librki/PedKeyStorage.c \
	lib/librki/PedRkiApi.c \
	lib/librki/PedRkiLib.c \
	lib/librki/PedTimer.c \
	lib/librki/puk.c \
	lib/librki/sha2.c


# the assembler is only for the ARM version, don't break the Linux sim


LOCAL_MODULE:= librki
LOCAL_PRELINK_MODULE := false 

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libpaxapiclient \
	$(LOCAL_PATH)/lib/librki \
	$(JNI_H_INCLUDE) 

LOCAL_SHARED_LIBRARIES := libpaxapi \
	libcutils \
	liblog \
	libutils \
	libencrypt
	
LOCAL_SRC_FILES := 	lib/librki/common.c \
	lib/librki/common1.c \
	lib/librki/crypt_api.c \
	lib/librki/dbdprint.c \
	lib/librki/ped.c \
	lib/librki/PedAsyKeyStorage.c \
	lib/librki/PedCrc16.c \
	lib/librki/PedCrc32.c \
	lib/librki/PedDrv.c \
	lib/librki/PedKeySave.c \
	lib/librki/PedKeyStorage.c \
	lib/librki/PedRkiApi.c \
	lib/librki/PedRkiLib.c \
	lib/librki/PedTimer.c \
	lib/librki/PedRkiTestRsaKey.c \
	lib/librki/PedRkiTest.c \
	lib/librki/puk.c \
	lib/librki/sha2.c 
LOCAL_MODULE_TAGS := eng 
LOCAL_CFLAGS += -DPED_RKI_TEST_KEY
LOCAL_MODULE:= rki_test
LOCAL_PRELINK_MODULE := false 

include $(BUILD_EXECUTABLE)


include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/device/include
LOCAL_SRC_FILES :=  bin/posprintupdate/main.c
LOCAL_MODULE := posprintupdate
LOCAL_SHARED_LIBRARIES := libpaxdevice
LOCAL_LDLIBS := -llog 
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libpaxapiclient \
	$(LOCAL_PATH)/lib/libpaxlog \
	$(LOCAL_PATH)/lib/librki \
	$(LOCAL_PATH)/lib/libpaxkeyinject \
	$(JNI_H_INCLUDE) 

LOCAL_SHARED_LIBRARIES := libpaxapi \
	librki \
	libcutils \
	liblog \
	libutils \
	libpaxlog
	
LOCAL_SRC_FILES := 	lib/libpaxkeyinject/MPosFile.c \
	lib/libpaxkeyinject/MposMain.c \
	lib/libpaxkeyinject/MposMsgClient.c \
	lib/libpaxkeyinject/MPosProcCmd.c \
	lib/libpaxkeyinject/MPosProcTag.c \
	lib/libpaxkeyinject/MpossofTimer.c \
	lib/libpaxkeyinject/com_pax_keyinject_KeyInjectTools.c
	
# the assembler is only for the ARM version, don't break the Linux sim

LOCAL_CFLAGS +=

LOCAL_MODULE:= libpaxkeyinject
LOCAL_PRELINK_MODULE := false 

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libpaxapiclient \
	$(LOCAL_PATH)/lib/libpaxlog \
	$(LOCAL_PATH)/lib/librki \
	$(LOCAL_PATH)/lib/libpaxkeyinject \
	$(JNI_H_INCLUDE) 

LOCAL_SHARED_LIBRARIES := libpaxapi \
	librki \
	libcutils \
	liblog \
	libutils \
	libpaxlog
	
LOCAL_SRC_FILES := 	lib/libpaxkeyinject/MPosFile.c \
	lib/libpaxkeyinject/MposMain.c \
	lib/libpaxkeyinject/MposMsgClient.c \
	lib/libpaxkeyinject/MPosProcCmd.c \
	lib/libpaxkeyinject/MPosProcTag.c \
	lib/libpaxkeyinject/MpossofTimer.c \
	lib/libpaxkeyinject/com_pax_keyinject_KeyInjectTools.c
	
# the assembler is only for the ARM version, don't break the Linux sim

LOCAL_CFLAGS += -DNO_JNI
LOCAL_MODULE_TAGS := eng 
LOCAL_MODULE:= libpaxkeyinject_ex
LOCAL_PRELINK_MODULE := false 

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libpaxapiclient \
	$(LOCAL_PATH)/lib/libpaxkeyinject \
	$(LOCAL_PATH)/lib/librki \
	$(JNI_H_INCLUDE) 

LOCAL_SHARED_LIBRARIES := libpaxapi \
	librki \
	libpaxkeyinject_ex \
	libcutils \
	liblog \
	libutils \
	libencrypt
	
LOCAL_SRC_FILES := 	bin/keyinject_test/main.c
LOCAL_MODULE_TAGS := eng 
LOCAL_MODULE:= keyinject_test
LOCAL_PRELINK_MODULE := false 

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libpaxapiclient \
	$(LOCAL_PATH)/lib/libpaxkeyinject \
	$(LOCAL_PATH)/lib/librki \
	$(JNI_H_INCLUDE) 

LOCAL_SHARED_LIBRARIES := libpaxapi \
	librki \
	libpaxkeyinject_ex \
	libcutils \
	liblog \
	libutils \
	libencrypt
	
LOCAL_SRC_FILES := 	bin/rkierase/PedErasemain.c
LOCAL_MODULE_TAGS := eng 
LOCAL_MODULE:= rkierase
LOCAL_PRELINK_MODULE := false 

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += \
	$(JNI_H_INCLUDE) 
	
LOCAL_SRC_FILES := lib/librkijni/com_paxsz_rki_rkidev.c \

LOCAL_SHARED_LIBRARIES := libcutils \
		libutils \
		libnativehelper \
		librki

# the assembler is only for the ARM version, don't break the Linux sim

LOCAL_CFLAGS += -O3 -fstrict-aliasing -fprefetch-loop-arrays

LOCAL_MODULE:= librkijni
LOCAL_PRELINK_MODULE := false 

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libpaxapiclient \
	$(LOCAL_PATH)/lib/librki \
	$(LOCAL_PATH)/lib/libpeddownload \
	$(JNI_H_INCLUDE) 

LOCAL_SHARED_LIBRARIES := libpaxapi \
	librki \
	libcutils \
	liblog \
	libutils \
	libencrypt
	
LOCAL_SRC_FILES := 	lib/libpeddownload/PedApi.c \
	lib/libpeddownload/peddownload.c \

# the assembler is only for the ARM version, don't break the Linux sim

LOCAL_MODULE:= libpeddownload
LOCAL_PRELINK_MODULE := false 
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libpaxapiclient \
	$(LOCAL_PATH)/lib/librki \
	$(LOCAL_PATH)/lib/libpeddownload \
	$(JNI_H_INCLUDE) 

LOCAL_SHARED_LIBRARIES := libpaxapi \
	libpeddownload \
	librki \
	libcutils \
	liblog \
	libutils \
	libencrypt
	
LOCAL_SRC_FILES := 	bin/peddownload/main.c \
	

# the assembler is only for the ARM version, don't break the Linux sim

LOCAL_MODULE:= peddownload
LOCAL_PRELINK_MODULE := false 
include $(BUILD_EXECUTABLE)


include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += $(LOCAL_PATH)/device/include \
	$(LOCAL_PATH)/lib/libauthdownload  \
	$(LOCAL_PATH)/lib/libspdev  \
	$(LOCAL_PATH)/lib/libpaxapisvr  \
	$(LOCAL_PATH)/lib/libpaxlog \
	$(LOCAL_PATH)/lib/libcfg/include 
	
LOCAL_SHARED_LIBRARIES := libpaxspdev \
	libpaxadapter \
	libcutils \
	liblog \
	libutils \
	libpaxlog \
	libpaxcfg
	
LOCAL_SRC_FILES := 	lib/libauthdownload/authdownload.c 
	

# the assembler is only for the ARM version, don't break the Linux sim

LOCAL_MODULE:= libauthdownload
LOCAL_PRELINK_MODULE := false 
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_C_INCLUDES += $(LOCAL_PATH)/device/include \
	$(LOCAL_PATH)/lib/libauthdownload \
	$(LOCAL_PATH)/lib/libspdev  

LOCAL_SHARED_LIBRARIES := libauthdownload \
	libcutils \
	liblog \
	libutils 
	
LOCAL_SRC_FILES := 	bin/authdownload/main.c
LOCAL_MODULE_TAGS := eng 
LOCAL_MODULE:= authdownload
LOCAL_PRELINK_MODULE := false 

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_C_INCLUDES += $(LOCAL_PATH)/device/include \
	$(LOCAL_PATH)/device/authinfo/ \
	$(LOCAL_PATH)/lib/libpaxapiclient  \
	$(LOCAL_PATH)/lib/libbpadownload  \
	$(LOCAL_PATH)/lib/libspdev  \
	$(LOCAL_PATH)/lib/libpaxapisvr  \
	$(LOCAL_PATH)/lib/libpaxlog 

LOCAL_SHARED_LIBRARIES := libpaxspdev \
	libpaxapi \
	libcutils \
	liblog \
	libutils \
	libpaxlog \
	libpaxdevice \
	libpaxcfg
	
LOCAL_SRC_FILES := 	lib/libbpadownload/bpadownload.c 
	

# the assembler is only for the ARM version, don't break the Linux sim

LOCAL_MODULE:= libbpadownload
LOCAL_PRELINK_MODULE := false 
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_C_INCLUDES += $(LOCAL_PATH)/device/include \
	$(LOCAL_PATH)/lib/libbpadownload \
	$(LOCAL_PATH)/lib/libspdev  

LOCAL_SHARED_LIBRARIES := libbpadownload \
	libcutils \
	liblog \
	libutils 
	
LOCAL_SRC_FILES := 	bin/bpadownload/main.c
LOCAL_MODULE_TAGS := eng 
LOCAL_MODULE:= bpadownload
LOCAL_PRELINK_MODULE := false 

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_C_INCLUDES += $(LOCAL_PATH)/device/include \
        $(LOCAL_PATH)/lib/libauthdownload \
        $(LOCAL_PATH)/lib/libspdev  \
        $(LOCAL_PATH)/lib/libpaxapiclient  \
        $(LOCAL_PATH)/device/picc


LOCAL_SHARED_LIBRARIES := libauthdownload \
        libcutils \
        liblog \
        libutils \
        libpaxdevice

LOCAL_SRC_FILES :=      bin/setupcfg/main.c
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE:= setupcfg
LOCAL_PRELINK_MODULE := false

include $(BUILD_EXECUTABLE)


include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_C_INCLUDES += $(LOCAL_PATH)/device/include \
	$(LOCAL_PATH)/lib/libpaxapiclient  

LOCAL_SHARED_LIBRARIES := libpaxapi \
	libcutils \
	liblog \
	libutils 
	
LOCAL_SRC_FILES := 	bin/filetomonitor/main.c
LOCAL_MODULE_TAGS := eng 
LOCAL_MODULE:= filetomonitor
LOCAL_PRELINK_MODULE := false 

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libencrypt/include

LOCAL_SHARED_LIBRARIES := libencrypt \
	libcutils \
	liblog \
	libutils 
	
LOCAL_SRC_FILES := 	bin/hashtest/main.c
LOCAL_MODULE_TAGS := eng 
LOCAL_MODULE:= hashtest
LOCAL_PRELINK_MODULE := false 

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_C_INCLUDES += $(LOCAL_PATH)/lib/libpaxapiclient \
		$(LOCAL_PATH)/device/include 
		
LOCAL_SHARED_LIBRARIES := libpaxapi \
	libcutils \
	liblog \
	libutils 
	
LOCAL_SRC_FILES := 	bin/puktest/main.c
LOCAL_MODULE_TAGS := eng 
LOCAL_MODULE:= puktest
LOCAL_PRELINK_MODULE := false 

include $(BUILD_EXECUTABLE)


include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_C_INCLUDES += $(LOCAL_PATH)/device/include \
		$(LOCAL_PATH)/lib/libpaxapiclient  

LOCAL_SHARED_LIBRARIES := libpaxapi \
	libcutils \
	liblog \
	libutils 
	
LOCAL_SRC_FILES := 	bin/printer_ndk_test/main.c \
		bin/printer_ndk_test/printer.c
LOCAL_MODULE_TAGS := eng 
LOCAL_MODULE:= printerndk
LOCAL_PRELINK_MODULE := false 

include $(BUILD_EXECUTABLE)

include $(call all-makefiles-under,$(LOCAL_PATH))
