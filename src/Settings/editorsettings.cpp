#include <QDir>
#include <QDebug>
#include <QDomDocument>
#include <QFileInfo>
#include "editorsettings.h"

using namespace waltz::editor::Settings;

namespace
{
    const QString EDITOR_SETTINGS_PATH     = "./config/EditorSettings.xml";
    const QString ELEMENT_NAME_ROOT        = "EditorSettings";
    const QString ELEMENT_NAME_CLIENT_PORT = "ClientPort";
    const QString ELEMENT_NAME_ENGINE_PATH = "EnginePath";
}

EditorSettings* EditorSettings::mInstance_ = 0;

EditorSettings& EditorSettings::getInstance()
{
    if (mInstance_ == 0)
    {
        static EditorSettings instance;
        mInstance_ = &instance;
    }
    return *mInstance_;
}

EditorSettings::EditorSettings()
{
    load();
}

void EditorSettings::load()
{
    QFile settingFile(EDITOR_SETTINGS_PATH);
    QDomDocument doc;
    QString errorStr;

    int errorLine;
    int errorColumn;

    if (! settingFile.open(QIODevice::ReadOnly))
    {
        qWarning() << "can't open setting file."
                   << settingFile.errorString();
        return;
    }
    if (! doc.setContent(&settingFile,
                         true,
                         &errorStr,
                         &errorLine,
                         &errorColumn))
    {

        qWarning() << "error"
                   << errorStr
                   << "Line"<< errorLine
                   << "column" << errorColumn;
        return;
    }

    QDomElement root = doc.documentElement();
    if (root.tagName() != ELEMENT_NAME_ROOT)
    {
        qWarning() << "Editor settings is wrong format.";
        return;
    }

    QDomNode node = root.firstChild();

    while (!node.isNull())
    {
        if (node.toElement().tagName() == ELEMENT_NAME_CLIENT_PORT)
        {
            mClientPort_ = node.firstChild().toText().data();
        }
        else if (node.toElement().tagName() == ELEMENT_NAME_ENGINE_PATH)
        {
            mEnginePath_ = node.firstChild().toText().data();
        }
        node = node.nextSibling();
    }
}

QString EditorSettings::clientPort() const
{
    return mClientPort_;
}

QString EditorSettings::enginePath() const
{
    QFileInfo info(QDir::cleanPath(mEnginePath_));
    return info.absoluteFilePath();
}
