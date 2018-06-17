QT += qml quick websockets widgets xml

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
    src/Domain/LibraryComponent/libraryname.cpp \
    src/Domain/ScoreComponent/noteid.cpp \
    src/Domain/Commands/activeplaybuttoncommand.cpp \
    src/Domain/ScoreComponent/noterect.cpp \
    src/Domain/ScoreComponent/noterectposition.cpp \
    src/Domain/ScoreComponent/noterectwidth.cpp \
    src/Domain/ScoreComponent/vibratoamplitude.cpp \
    src/Domain/ScoreComponent/pitchchangingpoint.cpp \
    src/Domain/ScoreComponent/pitchcurve.cpp \
    src/Domain/ScoreComponent/point.cpp \
    src/Domain/ScoreComponent/noterectheight.cpp \
    src/Domain/ScoreComponent/vibratolength.cpp \
    src/Domain/ScoreComponent/noteinformation.cpp \
    src/Domain/ScoreComponent/pitchchangingpointtime.cpp \
    src/Domain/ScoreComponent/pitchchangingpointfrequency.cpp \
    src/Domain/ScoreComponent/abstractnoteparameter.cpp \
    src/Domain/ScoreComponent/notevolume.cpp \
    src/Domain/ScoreComponent/noteparameterlist.cpp \
    src/Domain/Commands/startseekbarcommand.cpp \
    src/Domain/Commands/resetseekbarcommand.cpp \
    src/Domain/ScoreComponent/vibratowavelength.cpp \
    src/Domain/ExternalFile/waltzsongfile.cpp \
    src/Domain/ScoreComponent/playbackstartingtime.cpp \
    src/Domain/Commands/pauseseekbarcommand.cpp \
    src/Model/mathutility.cpp \
    src/Domain/History/historydata.cpp \
    src/Domain/History/historydatarepository.cpp \
    src/Domain/LibraryComponent/libraryfilepath.cpp \
    src/Domain/VocalEngine/engine.cpp \
    src/Model/editorclipboard.cpp \
    src/Domain/LibraryComponent/correspondencealias.cpp \
    src/Domain/LibraryComponent/correspondencealiaslist.cpp \
    src/Settings/editorsettings.cpp \
    src/Domain/Commands/engineisready.cpp

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
    src/Domain/LibraryComponent/libraryname.h \
    src/Domain/ScoreComponent/noteid.h \
    src/Domain/Commands/activeplaybuttoncommand.h \
    src/Domain/ScoreComponent/noterect.h \
    src/Domain/ScoreComponent/noterectposition.h \
    src/Domain/ScoreComponent/noterectwidth.h \
    src/Domain/ScoreComponent/vibratoamplitude.h \
    src/Domain/ScoreComponent/pitchchangingpoint.h \
    src/Domain/ScoreComponent/pitchcurve.h \
    src/Domain/ScoreComponent/point.h \
    src/Domain/ScoreComponent/noterectheight.h \
    src/Domain/ScoreComponent/vibratolength.h \
    src/Domain/ScoreComponent/noteinformation.h \
    src/Domain/ScoreComponent/pitchchangingpointtime.h \
    src/Domain/ScoreComponent/pitchchangingpointfrequency.h \
    src/Domain/ScoreComponent/abstractnoteparameter.h \
    src/Domain/ScoreComponent/notevolume.h \
    src/Domain/ScoreComponent/noteparameterlist.h \
    src/Domain/Commands/startseekbarcommand.h \
    src/Domain/Commands/resetseekbarcommand.h \
    src/Domain/ScoreComponent/vibratowavelength.h \
    src/Domain/ExternalFile/waltzsongfile.h \
    src/Domain/ScoreComponent/playbackstartingtime.h \
    src/Domain/Commands/pauseseekbarcommand.h \
    src/Model/mathutility.h \
    src/Domain/History/historydata.h \
    src/Domain/History/historydatarepository.h \
    src/Domain/LibraryComponent/libraryfilepath.h \
    src/Domain/VocalEngine/engine.h \
    src/Model/editorclipboard.h \
    src/Domain/LibraryComponent/correspondencealias.h \
    src/Domain/LibraryComponent/correspondencealiaslist.h \
    src/Settings/editorsettings.h \
    src/Domain/Commands/engineisready.h

DISTFILES += \
    image/redo.png \
    image/undo.png \
    src/View/i18n/qml_ja.ts \
    src/View/i18n/qml_ja_JP.qm \
    src/View/i18n/qml_ja_JP.ts

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../WaltzCommonLibrary/release/ -lWaltzCommonLibrary
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../WaltzCommonLibrary/debug/ -lWaltzCommonLibrary
else:unix: LIBS += -L$$PWD/../WaltzCommonLibrary/ -lWaltzCommonLibrary

INCLUDEPATH += $$PWD/../WaltzCommonLibrary/include
DEPENDPATH += $$PWD/../WaltzCommonLibrary/include
