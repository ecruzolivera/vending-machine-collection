
DEFINES += QPM_INIT\\(E\\)=\"E.addImportPath(QStringLiteral(\\\"qrc:/\\\"));\"
DEFINES += QPM_USE_NS
INCLUDEPATH += $$PWD
QML_IMPORT_PATH += $$PWD


include($$PWD/com/cutehacks/duperagent/com_cutehacks_duperagent.pri)
include($$PWD/com/github/benlau/qsyncable/qsyncable.pri)
include($$PWD/com/github/benlau/quickflux/quickflux.pri)
