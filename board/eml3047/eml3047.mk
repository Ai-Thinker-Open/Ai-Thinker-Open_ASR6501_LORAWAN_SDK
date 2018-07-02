NAME := board_eml3047

JTAG := jlink_swd

$(NAME)_TYPE := kernel
MODULE               := 1062
HOST_ARCH            := Cortex-M0
HOST_MCU_FAMILY      := stm32l0xx.stm32l071kb
SUPPORT_BINS         := no

$(NAME)_SOURCES := board.c                 \
				   src/debug.c             \
				   src/hw_gpio.c           \
				   src/hw_spi.c            \
				   src/hw_rtc.c            \
				   src/eml3047_hw.c        \
				   src/eml3047_it.c        \
				   src/vcom.c              \
				   src/lorawan_port.c

$(NAME)_COMPONENTS += modules.fs.kv

linklora ?= 0
ifeq ($(linklora), 0)
$(NAME)_SOURCES += src/lora.c
endif

#$(NAME)_LINK_FILES := src/eml3047_it.o

GLOBAL_INCLUDES +=  .            \
				    inc     \

$(NAME)_INCLUDES := \
../../platform/mcu/stm32l0xx/Drivers/STM32L0xx_HAL_Driver/Inc \
../../platform/mcu/stm32l0xx/Drivers/STM32L0xx_HAL_Driver/Inc/Legacy \
../../platform/mcu/stm32l0xx/Drivers/CMSIS/Device/ST/STM32L0xx/Include \
../../platform/mcu/stm32l0xx/Drivers/CMSIS/Include

$(NAME)_DEFINES := \
USE_HAL_DRIVER \
STM32L071xx

GLOBAL_DEFINES += STDIO_UART=0 CONFIG_NO_TCPIP
GLOBAL_DEFINES += RHINO_CONFIG_TICK_TASK=0 RHINO_CONFIG_WORKQUEUE=0

CONFIG_SYSINFO_PRODUCT_MODEL := ALI_AOS_EML3047
CONFIG_SYSINFO_DEVICE_NAME := EML3047

GLOBAL_CFLAGS += -DSYSINFO_OS_VERSION=\"$(CONFIG_SYSINFO_OS_VERSION)\"
GLOBAL_CFLAGS += -DSYSINFO_PRODUCT_MODEL=\"$(CONFIG_SYSINFO_PRODUCT_MODEL)\"
GLOBAL_CFLAGS += -DSYSINFO_DEVICE_NAME=\"$(CONFIG_SYSINFO_DEVICE_NAME)\"

GLOBAL_LDFLAGS  += -L $(SOURCE_ROOT)/board/eml3047

# Global defines
# HSE_VALUE = STM32 crystal frequency = 26MHz (needed to make UART work correctly)
GLOBAL_DEFINES += $$(if $$(NO_CRLF_STDIO_REPLACEMENT),,CRLF_STDIO_REPLACEMENT)
GLOBAL_CFLAGS  += -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft

WIFI_FIRMWARE_SECTOR_START    := 2      #0x2000
FILESYSTEM_IMAGE_SECTOR_START := 256    #0x100000

# Extra build target in mico_standard_targets.mk, include bootloader, and copy output file to eclipse debug file (copy_output_for_eclipse)
EXTRA_TARGET_MAKEFILES +=  $(MAKEFILES_PATH)/aos_standard_targets.mk
#EXTRA_TARGET_MAKEFILES +=  $(SOURCE_ROOT)/platform/mcu/$(HOST_MCU_FAMILY)/gen_crc_bin.mk
