AM_CPPFLAGS = -fno-rtti -fno-exceptions -D__STDC_FORMAT_MACROS

AM_CPPFLAGS += \
	-I$(top_builddir) \
	-I$(top_srcdir) \
	-I$(top_srcdir)/src \
	-I$(top_srcdir)/src/zapit/include \
	-I$(top_srcdir)/lib \
	-I$(top_srcdir)/lib/libconfigfile \
	-I$(top_srcdir)/lib/connection \
	-I$(top_srcdir)/lib/libeventserver \
	-I$(top_srcdir)/lib/xmltree

if BOXTYPE_COOL
if BOXMODEL_APOLLO
AM_CPPFLAGS += -I$(top_srcdir)/lib/libcoolstream2
else
AM_CPPFLAGS += -I$(top_srcdir)/lib/libcoolstream
endif
endif
if BOXTYPE_TRIPLE
AM_CPPFLAGS += -I$(top_srcdir)/lib/libtriple
endif

noinst_LIBRARIES = libzapit.a

libzapit_a_SOURCES = \
	bouquets.cpp \
	capmt.cpp \
	channel.cpp \
	fastscan.cpp \
	femanager.cpp \
	frontend.cpp \
	getservices.cpp \
	pat.cpp \
	scanbat.cpp \
	scan.cpp \
	scannit.cpp \
	scanpmt.cpp \
	scansdt.cpp \
	transponder.cpp \
	zapit.cpp

bin_PROGRAMS = pzapit
sbin_PROGRAMS = udpstreampes

pzapit_SOURCES = \
	pzapit.cpp

pzapit_LDADD = \
	$(top_builddir)/src/zapit/lib/libzapitclient.a \
	$(top_builddir)/lib/connection/libtuxbox-connection.a

udpstreampes_SOURCES = \
	udpstreampes.cpp

udpstreampes_LDADD = \
	$(top_builddir)/src/zapit/lib/libzapitclient.a \
	$(top_builddir)/lib/connection/libtuxbox-connection.a \
	-lpthread
