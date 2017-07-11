QT += qml quick websockets widgets

CONFIG += c++11

SOURCES += main.cpp \
    src/Model/mainwindowmodel.cpp \
    src/Model/editareainformation.cpp \
    src/Communicator/client.cpp \
    src/Domain/Commands/commandfactory.cpp \
    src/Domain/Commands/updatelibraryinformationcommand.cpp \
    src/Domain/LibraryComponent/libraryinformation.cpp \
    src/Domain/LibraryComponent/description.cpp \
    src/Domain/LibraryComponent/characterimage.cpp \
    src/Communicator/receiveddata.cpp \
    src/Domain/ScoreComponent/beat.cpp \
    src/Domain/ScoreComponent/note.cpp \
    src/Domain/ScoreComponent/notelength.cpp \
    src/Domain/ScoreComponent/notelist.cpp \
    src/Domain/ScoreComponent/notestarttime.cpp \
    src/Domain/ScoreComponent/pitch.cpp \
    src/Domain/ScoreComponent/score.cpp \
    src/Domain/ScoreComponent/syllable.cpp \
    src/Domain/ScoreComponent/tempo.cpp \
    src/Domain/LibraryComponent/libraryname.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/Model/mainwindowmodel.h \
    src/Model/editareainformation.h \
    src/Communicator/client.h \
    src/Domain/Commands/commandfactory.h \
    src/Domain/Commands/updatelibraryinformationcommand.h \
    src/Domain/LibraryComponent/libraryinformation.h \
    src/Domain/LibraryComponent/description.h \
    src/Domain/LibraryComponent/characterimage.h \
    src/Communicator/receiveddata.h \
    src/Domain/ScoreComponent/beat.h \
    src/Domain/ScoreComponent/domaindef.h \
    src/Domain/ScoreComponent/note.h \
    src/Domain/ScoreComponent/notelength.h \
    src/Domain/ScoreComponent/notelist.h \
    src/Domain/ScoreComponent/notestarttime.h \
    src/Domain/ScoreComponent/pitch.h \
    src/Domain/ScoreComponent/score.h \
    src/Domain/ScoreComponent/syllable.h \
    src/Domain/ScoreComponent/tempo.h \
    src/Domain/LibraryComponent/libraryname.h

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../WaltzCommonLibrary/release/ -lWaltzCommonLibrary
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../WaltzCommonLibrary/debug/ -lWaltzCommonLibrary
else:unix: LIBS += -L$$PWD/../WaltzCommonLibrary/ -lWaltzCommonLibrary

INCLUDEPATH += $$PWD/../WaltzCommonLibrary/include
DEPENDPATH += $$PWD/../WaltzCommonLibrary/include