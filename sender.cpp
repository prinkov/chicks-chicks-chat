#include <sender.hpp>
#include <QDebug>

void Sender::setUrl(QString url) {
    apiUrl = url;
}

void Sender::sendImage(QString pathImage) {
    QNetworkRequest request(apiUrl);
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);
    QHttpPart imagePart;

    imagePart.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("image/jpeg"));

    imagePart.setHeader(
                QNetworkRequest::ContentDispositionHeader,
                QVariant("form-data; name=\"file\"; filename=\"" + QFile(pathImage).fileName().toHtmlEscaped() + "\"")
                );

    pathImage = QUrl(pathImage).toLocalFile();
    QFile *file = new QFile(pathImage);
    file->open(QIODevice::ReadOnly);
    imagePart.setBodyDevice(file);
    multiPart->append(imagePart);
    reply = manager.post(request, multiPart);
    connect(reply, SIGNAL(readyRead()), this, SLOT(readyReadReply()));
    connect(reply, SIGNAL(finished()), this, SLOT(getReplyFinished()));
}

void Sender::getReplyFinished() {
    reply->deleteLater();
}

void Sender::sendPost(QString arg) {
    QUrl url;
    url = "http://autom/api/gateway/";
    QNetworkRequest request(url);
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);
    QHttpPart method;
    method.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"method\""));
    method.setBody("start");
    QHttpPart xml;
    xml.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"xml\""));
    xml.setBody(arg.toUtf8());
    multiPart->append(method);
    multiPart->append(xml);
    reply = manager.post(request, multiPart);
    connect(reply, SIGNAL(readyRead()), this, SLOT(readyReadReply()));
    connect(reply, SIGNAL(finished()), this, SLOT(getReplyFinished()));
}


void Sender::readyReadReply() {
    answer = QString::fromUtf8(reply->readAll());
    emit onAnswer(answer);
}
