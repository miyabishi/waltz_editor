#include <QDebug>
#include <QByteArray>
#include <waltz_common/message.h>

#include "client.h"
#include "receiveddata.h"

using namespace waltz::editor::Communicator;
using namespace waltz::common::Communicator;

Client::Client(const QUrl &aUrl, QObject* aParent)
    : QObject(aParent)
    , mUrl_(aUrl)
{
    connect(&mWebSocket_, SIGNAL(connected()), this, SLOT(onConnected()));
    connect(&mWebSocket_, SIGNAL(disconnected()), this, SIGNAL(closed()));
    mWebSocket_.open(mUrl_);
}

void Client::onConnected()
{
    connect(&mWebSocket_, SIGNAL(binaryMessageReceived(QByteArray)),
            this, SLOT(onMessageReceived(QByteArray)));
}

void Client::onMessageReceived(QByteArray aData)
{
    qDebug() << "message received" << aData;
    ReceivedData data(aData);
    data.executeCommand();
}

void Client::sendMessage(const Message& aMessage)
{
    mWebSocket_.sendBinaryMessage(aMessage.toByteArray());
}
