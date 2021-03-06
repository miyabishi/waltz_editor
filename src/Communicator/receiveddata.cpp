#include <QtDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <waltz_common/command.h>
#include "src/Domain/Commands/commandfactory.h"
#include "src/Model/mainwindowmodel.h"

#include "receiveddata.h"

using namespace waltz::common::Commands;

using namespace waltz::editor::Communicator;
using namespace waltz::editor::Commands;
using namespace waltz::editor::model;

namespace
{
    const QString COMMAND_ID_KEY = "CommandId";
    const QString PARAMETERS_KEY  = "Parameters";
}

ReceivedData::ReceivedData(const QByteArray& aRecieivedData)
    : mCommandId_("")
    , mParameters_()
{
    parseReceivedData(aRecieivedData);
}

ReceivedData::~ReceivedData()
{
}

ReceivedData::ReceivedData(const ReceivedData& aOther)
    : mCommandId_(aOther.mCommandId_)
    , mParameters_(aOther.mParameters_)
{
}

ReceivedData& ReceivedData::operator=(const ReceivedData& aOther)
{
    mCommandId_  = aOther.mCommandId_;
    mParameters_ = aOther.mParameters_;
    return (*this);
}

void ReceivedData::parseReceivedData(const QByteArray &aReceivedData)
{
    QJsonParseError error;
    QJsonDocument jsonDocument(QJsonDocument::fromJson(aReceivedData, &error));
    if (error.error != QJsonParseError::NoError)
    {
        MainWindowModel::getInstance().emitErrorOccurred(error.errorString());
        qWarning() << error.errorString();
        return;
    }
    QJsonObject jsonObject(jsonDocument.object());

    mCommandId_ = CommandId(jsonObject.value(COMMAND_ID_KEY).toString());
    mParameters_ = Parameters(jsonObject.value(PARAMETERS_KEY).toArray());
}

void ReceivedData::executeCommand()
{
    CommandPointer command = CommandFactory::getInstance().createCommand(mCommandId_);
    if (command == 0)
    {
        return;
    }
    command->exec(mParameters_);
}
