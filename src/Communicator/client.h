#ifndef CLIENT_H
#define CLIENT_H
#include <QObject>
#include <QtWebSockets/QWebSocket>

namespace waltz
{
    namespace common
    {
        namespace Communicator
        {
            class Message;
        }
    }
    namespace editor
    {
        namespace Communicator
        {
            class Client  : public QObject
            {
                Q_OBJECT

            public:
                Client(const QUrl &aUrl, QObject* aParent = Q_NULLPTR);

                void sendMessage(const waltz::common::Communicator::Message& aMessage);

            signals:
                void closed();

            private slots:
                void onConnected();
                void onMessageReceived(QByteArray aData);

            private:
                QWebSocket mWebSocket_;
                QUrl mUrl_;

            private:
                Client(const Client& aOther);
                Client& operator=(const Client& aOther);
            };
        } // namespace Communicator
    } // namespace editor
} // namespace walt

#endif // CLIENT_H
