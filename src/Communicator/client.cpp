#include <QDebug>
#include <QByteArray>
#include "client.h"
#include "message.h"
#include "receiveddata.h"

using namespace waltz::editor::Communicator;

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
    ReceivedData data(aData);
    data.executeCommand();
}

void Client::sendMessage(const Message& aMessage)
{
    mWebSocket_.sendBinaryMessage(aMessage.toByteArray());
}
