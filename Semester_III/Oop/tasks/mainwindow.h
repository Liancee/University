#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "Network.h"

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

    bht::Network net;
    void Initialize();
    bool strCmp(const std::string& str1, const std::string& str2);

private:
    Ui::MainWindow *ui;

    void searchStops();
    bool cmpLowerCaseSearchStrings(std::string currSearchString);
    void loadSelectRouteComboBoxContent();
    void setSelectedRoute();
    void setTrips();
    void prepareTableWidget();
    int populateTableWidget();

public slots:
    void onSearchStopsPushButtonClicked();
    void onSearchStopsCheckBoxStateChanged();
    void onSelectRouteComboBoxIndexChanged();
    void onSelectTripComboBoxIndexChanged();

};
#endif // MAINWINDOW_H
