#ifndef SENDER_HPP
#define SENDER_HPP

#include <QUrl>
#include <QObject>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include <QHttpMultiPart>
#include <QHttpPart>
#include <QFile>

class Sender : public QObject {
    Q_OBJECT

public:
    Q_INVOKABLE void sendImage(QString);
    Q_INVOKABLE void setUrl(QString);
    Q_INVOKABLE void sendPost(QString);
signals:
    void onAnswer(QString value);
public slots:
    void getReplyFinished();
    void readyReadReply();
private:
    QUrl apiUrl;
    QString answer;
    QNetworkReply *reply;
    QNetworkAccessManager manager;
};

#endif // SENDER_HPP
