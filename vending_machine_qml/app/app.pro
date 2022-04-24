TEMPLATE = app

# The application version
VERSION = 0.1.0

# Define the preprocessor macro to get the application version in our application.
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

QT += qml quick
CONFIG += c++20

SOURCES += main.cpp
RESOURCES += qml/qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += $$PWD
QML_IMPORT_PATH += $$PWD/qml

ROOT_DIR = $$relative_path($$PWD/..)

include($${ROOT_DIR}/vendor/vendor.pri)
include($$PWD/cpp/cpp.pri)

write_file(qmlimport.path, QML_IMPORT_PATH)
