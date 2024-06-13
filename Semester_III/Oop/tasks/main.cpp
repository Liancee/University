#include "mainwindow.h"

#include <QApplication>

//#define MAX_PATH 260

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;

    w.Initialize(); // load data in general and for ui

    w.show();
    return a.exec();
}
