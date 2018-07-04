#include <string>
#include <memory>
#include <chrono>

#include <QtConcurrentRun>
#include <QThread>
#include <QDebug>
#include <QTimer>

#include "helloworld.grpc.pb.h"
#include "helloworld_server.h"

using grpc::ServerBuilder;

void RunServer(std::shared_ptr<Server> server_)
{
  qDebug() << "RunServer() -> Thread ID: " << QThread::currentThreadId();

  server_->Wait();
}

namespace {
  std::shared_ptr<Server> buildAndStartService(GreeterServiceImpl & service_)
  {
    auto server_address("0.0.0.0:50060");

    return ServerBuilder()
        .AddListeningPort(server_address, grpc::InsecureServerCredentials())
        .RegisterService(&service_)
        .BuildAndStart();
  }
}

HelloworldServer::HelloworldServer(QObject *parent)
  : QObject(parent)
  , server(buildAndStartService(this->service))
{
  QtConcurrent::run(RunServer, this->server);

  // Testing shutdown 5 seconds later
  QTimer::singleShot(std::chrono::seconds(5), this, [=]() {
    qDebug() << "Shuting down!";
    this->server->Shutdown();

    emit shutdown();
  });
}
