AM_CXXFLAGS = -fno-rtti -fno-exceptions -D__STDC_FORMAT_MACROS

SUBDIRS = pictureviewer audiodec

AM_CPPFLAGS = \
	-I$(top_builddir) \
	-I$(top_srcdir) \
	-I$(top_srcdir)/src \
	-I$(top_srcdir)/src/zapit/include \
	-I$(top_srcdir)/lib \
	-I$(top_srcdir)/lib/libnet \
	-I$(top_srcdir)/lib/libconfigfile \
	-I$(top_srcdir)/lib/connection \
	-I$(top_srcdir)/lib/libeventserver \
	@FREETYPE_CFLAGS@

noinst_LIBRARIES = libneutrino_driver.a libneutrino_driver_netfile.a

libneutrino_driver_a_SOURCES = \
	abstime.c \
	audiofile.cpp \
	audiometadata.cpp \
	audioplay.cpp \
	fade.cpp \
	fb_window.cpp \
	file.cpp \
	fontrenderer.cpp \
	framebuffer.cpp \
	genpsi.cpp \
	neutrinofonts.cpp \
	radiotext.cpp \
	radiotools.cpp \
	rcinput.cpp \
	record.cpp \
	ringbuffer.c \
	scanepg.cpp \
	screen_max.cpp \
	screenshot.cpp \
	shutdown_count.cpp \
	streamts.cpp \
	volume.cpp

if BOXTYPE_COOL
libneutrino_driver_a_SOURCES += \
	vfd.cpp

if BOXMODEL_APOLLO
AM_CPPFLAGS += -I$(top_srcdir)/lib/libcoolstream2
else
AM_CPPFLAGS += -I$(top_srcdir)/lib/libcoolstream
endif
endif
if BOXTYPE_TRIPLE
libneutrino_driver_a_SOURCES += \
	newclock.cpp \
	lcdd.cpp

AM_CPPFLAGS += \
	-I$(top_srcdir)/lib/libtriple
endif

libneutrino_driver_netfile_a_SOURCES = netfile.cpp

