QT -= gui
QT += concurrent

CONFIG += console
CONFIG -= app_bundle

DEFINES += QT_DEPRECATED_WARNINGS

QMAKE_CXXFLAGS += -std=c++17

INCLUDEPATH += $$PWD/vcpkg/include

SRCDIR = "rpc_client_cpp"

SOURCES += \
  $$SRCDIR/rpc_client.cpp \
  $$SRCDIR/helloworld.pb.cc \
  $$SRCDIR/helloworld.grpc.pb.cc \
    rpc_server/hellostream_server.cpp

HEADERS += \
  $$SRCDIR/helloworld.pb.h \
  $$SRCDIR/helloworld.grpc.pb.h \
    rpc_server/hellostream_server.h

macx {
  debug {
    PRE_TARGETDEPS += \
      $$PWD/vcpkg/debug/lib/libgrpc++.a
      $$PWD/vcpkg/debug/lib/libgrpc.a
      $$PWD/vcpkg/debug/lib/libgpr.a
      $$PWD/vcpkg/debug/lib/libcrypto.a
      $$PWD/vcpkg/debug/lib/libssl.a
      $$PWD/vcpkg/debug/lib/libz.a
      $$PWD/vcpkg/debug/lib/libcares.a
      $$PWD/vcpkg/debug/lib/libprotobufd.a

    LIBS += -L$$PWD/vcpkg/debug/lib/ -lgrpc++ -lgrpc -lgpr -lcrypto -lssl -lz -lcares -lprotobufd
  }

  release {
    PRE_TARGETDEPS += \
      $$PWD/vcpkg/lib/libgrpc++.a
      $$PWD/vcpkg/lib/libgrpc.a
      $$PWD/vcpkg/lib/libgpr.a
      $$PWD/vcpkg/lib/libcrypto.a
      $$PWD/vcpkg/lib/libssl.a
      $$PWD/vcpkg/lib/libz.a
      $$PWD/vcpkg/lib/libcares.a
      $$PWD/vcpkg/lib/libprotobufd.a

    LIBS += -L$$PWD/vcpkg/lib/ -lgrpc++ -lgrpc -lgpr -lcrypto -lssl -lz -lcares -lprotobuf
  }
}

