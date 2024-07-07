#include "mainwindow.h"
#include "./ui_mainwindow.h"
#include <QStringListModel>
#include <QScreen>
#include <QMessageBox>
#include <array>

#include <iostream>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    //this->setFixedSize(475, 392);
    this->setStyleSheet("background-color: #772790;");

    /*QPalette pal = this->palette();
    QColor customMagenta(160, 32, 240);
    pal.setColor(QPalette::Window, customMagenta);
    this->setPalette(pal);*/
    /*QPalette pal2 = ui->searchStopsListWidget->palette();
    pal2.setColor(QPalette::Window, Qt::white);
    ui->searchStopsListWidget->setPalette(pal2);*/
    //ui->searchStopsListWidget->setStyleSheet("background-color: white;");
    /*ui->searchStopsListWidget->setStyleSheet("background-color: #f0f0f0; "
                                             "border: 1px solid #808080; "
                                             "QScrollBar:vertical { "
                                             "    border: 1px solid #404040; "
                                             "    background: #c0c0c0; "
                                             "} "
                                             "QScrollBar::handle:vertical { "
                                             "    background: #808080; "
                                             "} ");*/

    //net = bht::Network("./GTFS");

    /* here is still some change needed according to the search functionallity changes cuz maybe we dont even want to trigger a
     * search for when the checkbox state changed but if we do, we maybe need a spam protection and if there is no nice way of
     * doing that then using the Network vector properties interchangably on the corresponding checkboxstate is at least some
     * kind of relief*/
    QObject::connect(ui->searchStopsPushButton, &QPushButton::clicked, this, &MainWindow::onSearchStopsPushButtonClicked);
    QObject::connect(ui->searchStopsAccessibleCheckBox, &QCheckBox::checkStateChanged, this, &MainWindow::onSearchStopsCheckBoxStateChanged);
    QObject::connect(ui->searchStopsLineEdit, &QLineEdit::editingFinished, this, &MainWindow::onSearchStopsPushButtonClicked);
    QObject::connect(ui->selectRouteComboBox, &QComboBox::currentIndexChanged, this, &MainWindow::onSelectRouteComboBoxIndexChanged);
    QObject::connect(ui->selectTripComboBox, &QComboBox::currentIndexChanged, this, &MainWindow::onSelectTripComboBoxIndexChanged);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::Initialize()
{
    // load our data
    //w.net = bht::Network("E:/Education/bht/University/Semester_III/Oop/tasks/GTFSShort");
    //net = bht::Network("E:/Education/bht/University/Semester_III/Oop/tasks/GTFS");
    net = bht::Network("E:/Education/bht/University/Semester_III/Oop/tasks/GTFSMain");

    // initialize content for window controls
    //searchStops(); // first load of stops for the ListWidget
    loadSelectRouteComboBoxContent(); // loading the selectable routes into our comboBox
    prepareTableWidget();
    ui->selectRouteComboBox->setStyleSheet("selection-background-color: #58B687; background-color: #9F92A3;");
    ui->selectTripComboBox->setStyleSheet("selection-background-color: #58B687; background-color: #9F92A3;");
    ui->searchStopsLineEdit->setStyleSheet("QLineEdit { color: black; background-color: white;} QLineEdit[echoMode=\"0\"]::placeholder { color: black; }");
    ui->searchStopsLineEdit->setEnabled(false);

    ui->searchStopsAccessibleCheckBox->setEnabled(false);
    ui->searchStopsAccessibleCheckBox->setStyleSheet("color: black;");

    ui->searchStopsPushButton->setEnabled(false);
    ui->searchStopsPushButton->setStyleSheet("color: black; background-color: #58B687;");


    // lambda function to find the stop name
    auto findStopName = [&](const std::string& stopId) -> std::string
    {
        for (const auto& item : net.stops)
            if (item.second.id == stopId)
                return { item.second.name };
        return { "" };
    };

    net.createAdjacencylist();
    //std::vector<bht::StopTime> test = net.getTravelPlan("de:12067:900310004:3:53", "de:11000:900183001:1:51");
    //std::vector<bht::StopTime> test = net.getTravelPlan("de:11000:900052201:1:51", "de:11000:900092201:1:50"); // works is on the same trip
    //std::vector<bht::StopTime> test = net.getTravelPlan("de:11000:900052201:1:51", "de:11000:900053301:2:52");
    //std::vector<bht::StopTime> test = net.getTravelPlan("de:12067:900310004:3:53", "de:11000:900013102::3");
    //std::vector<bht::StopTime> test = net.getTravelPlan("de:11000:900120003:2:53", "de:11000:900193002:1:51");
    std::vector<bht::StopTime> test = net.getTravelPlan("de:12067:900310004:3:53", "de:11000:900013102::3");

    if (!test.empty())
        for (const auto& entry : test)
            ui->plainTextEdit->appendPlainText(QString::fromStdString(findStopName(entry.stopId) + " " + entry.stopId));
    else
        ui->plainTextEdit->setPlainText(QString::fromStdString("No path could be found!"));


    bht::NetworkScheduledTrip trip = net.getScheduledTrip("230419244");

    for (const bht::StopTime& stop : trip) {
        std::cout << "Stop " << stop.stopSequence << ": " << net.stops[stop.stopId].name << std::endl;
    }
}

void MainWindow::prepareTableWidget()
{
    ui->searchStopsTableWidget->setColumnCount(4);

    QStringList tableHeaders;
    tableHeaders << "No." << "Stop name" << "Arrival" << "Departure";
    ui->searchStopsTableWidget->setHorizontalHeaderLabels(tableHeaders);

    // hide vertical header aka the line counter
    ui->searchStopsTableWidget->verticalHeader()->setVisible(false);

    // disable editing
    ui->searchStopsTableWidget->setEditTriggers(QAbstractItemView::NoEditTriggers); //#AD66C3

    // set background of the selected items
    ui->searchStopsTableWidget->setStyleSheet("QTableView { selection-background-color: #9F92A3; background-color: #58B687; } QHeaderView::section { background-color: #772790;");

    // selection mode and behavior
    ui->searchStopsTableWidget->setSelectionBehavior(QAbstractItemView::SelectRows);
    ui->searchStopsTableWidget->setSelectionMode(QAbstractItemView::SingleSelection);

    // streches columns equally to fit size of grid
    //ui->searchStopsTableWidget->horizontalHeader()->setSectionResizeMode(QHeaderView::Stretch);
}

void MainWindow::onSearchStopsPushButtonClicked()
{
    // #####################################[ NEW SEARCH FUNCTION FOR THE IMPLEMENTATION OF THE TABLE] ##################################################################
    populateTableWidget();

    // #######################################################[ OLD SEARCH FUNCTION FOR THE LISTVIEW ]##################################################################
    // cmp for spam protection
    /*if (cmpLowerCaseSearchStrings(ui->searchStopsLineEdit->text().toStdString()))
        searchStops();*/
}

void MainWindow::onSearchStopsCheckBoxStateChanged()
{
    // #####################################[ NEW SEARCH FUNCTION FOR THE IMPLEMENTATION OF THE TABLE] ##################################################################
    populateTableWidget();

    // #######################################################[ OLD SEARCH FUNCTION FOR THE LISTVIEW ]##################################################################
    /*if (cmpLowerCaseSearchStrings(ui->searchStopsLineEdit->text().toStdString())) // if true we already searched and only have to load
    {

       for (const auto& item : net.searchedStops)
            {
                if (!ui->searchStopsAccessibleCheckBox->isChecked() || item.wheelchairBoarding == bht::WheelchairAccessibility_Available)
                {
                    ui->searchStopsListWidget->addItem(QString::fromStdString(item.name + ", " + item.description + " (" + item.id + ")"));
                }
            }


        ui->searchStopsListWidget->clear();
        if (ui->searchStopsAccessibleCheckBox->isChecked()) // if true load the results from net.searchedStops vector and filter for accessibility
        {
            for (const auto& item : net.searchedStops)
            {
                if (item.wheelchairBoarding == bht::WheelchairAccessibility_Available)
                {
                    ui->searchStopsListWidget->addItem(QString::fromStdString(item.name + ", " + item.description + " (" + item.id + ")"));
                }
            }
        }
        else // load the results from net.searchedStops vector
        {
            for (const auto& item : net.searchedStops)
            {
                ui->searchStopsListWidget->addItem(QString::fromStdString(item.name + ", " + item.description + " (" + item.id + ")"));
            }
        }
        ui->searchStopsResultCountLabel->setText(QString::fromStdString("Results: " + std::to_string(net.searchedStops.size())));
    }
    else // we need to search for the new searchString again
    {
        searchStops();
    }*/
}

void MainWindow::searchStops()
{
    return;
    /*std::vector<bht::Stop> searchResult = net.search(ui->searchStopsLineEdit->text().toStdString(), ui->searchStopsAccessibleCheckBox->isChecked());

    net.searchedStops = searchResult; // set the searchResult as prop on net, so filtering is easier for accessibility

    ui->searchStopsListWidget->clear();
    for (const auto& item : searchResult)
    {
        ui->searchStopsListWidget->addItem(QString::fromStdString(item.name + ", " + item.description + " (" + item.id + ")"));
    }

    ui->searchStopsResultCountLabel->setText(QString::fromStdString("Results: " + std::to_string(searchResult.size())));*/
}

bool MainWindow::cmpLowerCaseSearchStrings(std::string currSearchString)
{
    std::transform(currSearchString.begin(), currSearchString.end(), currSearchString.begin(), ::tolower);
    return net.oldSearchString != currSearchString;
}

void MainWindow::loadSelectRouteComboBoxContent()
{
    for (const auto& item : net.routes) // everything without a name is skipped
    {
        if (!item.second.shortName.empty())
        {
            std::string str = item.second.shortName;
            if (!item.second.longName.empty())
                str += " (" + item.second.longName + ")";

            ui->selectRouteComboBox->addItem(QString::fromStdString(str));
        }
    }
}

void MainWindow::onSelectRouteComboBoxIndexChanged()
{
    ui->searchStopsLineEdit->clear();

    setSelectedRoute();
    setTrips();
}

void MainWindow::setSelectedRoute()
{
    // imagine we had a vector instead of a map and could use the index directly LOL (ง ͠° ͟ل͜ ͡°)ง
    int index = ui->selectRouteComboBox->currentIndex();

    size_t count = 0;
    for (auto iterator = net.routes.begin(); iterator != net.routes.end(); ++iterator)
    {
        if (!iterator->second.shortName.empty()) // since we only added items containing a short name, we can only consider items having it for iteration
        {
            if (count == index) // if true we found the selected item
                net.selectedRoute = { iterator->first, iterator->second };
            ++count;
        }
    }
}

void MainWindow::setTrips()
{
    // this is very important since changing the values will trigger the onIndexChanged event for the second ComboBox
    ui->selectTripComboBox->blockSignals(true);

    net.tripsOfSelectedRoute.clear();
    ui->selectTripComboBox->clear();

    std::string routeId = net.selectedRoute.second.id;
    for (const auto& item : net.trips)
        if (!item.routeId.compare(routeId))
            net.tripsOfSelectedRoute.push_back(item);

    for (const auto& item : net.tripsOfSelectedRoute)
    {
        std::string str = "";
        if (!item.shortName.empty() && !item.headsign.empty())
            str = item.shortName +  " - " + item.headsign;
        else if (item.shortName.empty())
            str = item.headsign;
        else if (item.headsign.empty()) // cant use just else otherwise no skip would be possible (ಥ﹏ಥ)
            str = item.shortName;

        if (!str.empty())
            ui->selectTripComboBox->addItem(QString::fromStdString(str));
    }

    // activate the signal again for when the user triggers it
    ui->selectTripComboBox->blockSignals(false);
}

void MainWindow::onSelectTripComboBoxIndexChanged()
{
    ui->searchStopsLineEdit->clear();

    int index = ui->selectTripComboBox->currentIndex();

    // following statement cant really be true
    //if (index >= net.trips.size())
    if (index >= net.tripsOfSelectedRoute.size())
    {
        // index is out of bounds
        QMessageBox msgBox;
        msgBox.setIcon(QMessageBox::Critical);
        msgBox.setText("Index is out of bounds!");
        msgBox.setInformativeText("Index of selectTripComboBox is >= net.trips.size() and therefore could not be accessed.");
        msgBox.setWindowTitle("Out of bounds exception");
        msgBox.setStandardButtons(QMessageBox::Ok);

        msgBox.exec();

        return;
    }
    net.selectedTrip = net.tripsOfSelectedRoute.at(index);
    //net.selectedTrip = net.trips.at(index);

    net.stopTimesOfSelectedTrip.clear();
    std::string tripId = net.selectedTrip.id;
    for (const auto& item : net.stopTimes)
        if (!item.tripId.compare(tripId))
            net.stopTimesOfSelectedTrip.push_back(item);

    if (!ui->searchStopsLineEdit->isEnabled()) ui->searchStopsLineEdit->setEnabled(true);
    if (!ui->searchStopsAccessibleCheckBox->isEnabled()) ui->searchStopsAccessibleCheckBox->setEnabled(true);
    if (!ui->searchStopsPushButton->isEnabled()) ui->searchStopsPushButton->setEnabled(true);

    populateTableWidget();
}

int MainWindow::populateTableWidget()
{
    // lambda function to find the stop name
    auto findStopNameAndAccessibility = [&](const std::string& stopId) -> std::pair<std::string, bht::WheelchairAccessibility>
    {
        for (const auto& item : net.stops)
            if (item.second.id == stopId)
                return { item.second.name, item.second.wheelchairBoarding };
        return { "", bht::WheelchairAccessibility_NoInformation };
    };

    std::vector<std::array<QString, 4>> tableItems;

    int row = 0, colCnt = ui->searchStopsTableWidget->columnCount();
    for (auto& item : net.stopTimesOfSelectedTrip)
    {
        std::string searchString = ui->searchStopsLineEdit->text().toStdString();
        std::pair stopInfo = findStopNameAndAccessibility(net.stopTimesOfSelectedTrip.at(row).stopId);
        bht::WheelchairAccessibility accessible = stopInfo.second;
        std::string stopSequence = std::to_string(net.stopTimesOfSelectedTrip.at(row).stopSequence);
        std::string stopName = stopInfo.first;
        std::string arrivalTime = std::to_string(net.stopTimesOfSelectedTrip.at(row).arrivalTime.hour) + ":" + std::to_string(net.stopTimesOfSelectedTrip.at(row).arrivalTime.minute) + ":" + std::to_string(net.stopTimesOfSelectedTrip.at(row).arrivalTime.second);
        std::string departureTime = std::to_string(net.stopTimesOfSelectedTrip.at(row).departureTime.hour) + ":" + std::to_string(net.stopTimesOfSelectedTrip.at(row).departureTime.minute) + ":" + std::to_string(net.stopTimesOfSelectedTrip.at(row).departureTime.second);

        if (ui->searchStopsAccessibleCheckBox->isChecked() && accessible != bht::WheelchairAccessibility_Available)
        {
            row++;
            continue; // it was searched for accessibility and this stop aint accessible so we skip
        }
        if (ui->searchStopsLineEdit->text() != "" && !strCmp(searchString, stopSequence) && !strCmp(searchString, stopName) && !strCmp(searchString, arrivalTime) && !strCmp(searchString, departureTime))
        {
            row++;
            continue; // if the search field has a value and it doesn't match with any of the stops values we continue to the next stop since it wasnt searched for
        };

        std::array<QString, 4> colObj = { QString::fromStdString(stopSequence), QString::fromStdString(stopName), QString::fromStdString(arrivalTime), QString::fromStdString(departureTime) };

        tableItems.push_back(colObj);

        row++;
    }

    size_t rowCount = tableItems.size();
    if (rowCount > 0)
    {
        ui->searchStopsTableWidget->clear(); // clears more that I'd like to, so we have to set the headers again with the next function call
        prepareTableWidget();

        ui->searchStopsTableWidget->setRowCount(rowCount);

        int row = 0;
        for (auto& item : tableItems)
        {
            int col = 0;
            for (; col < colCnt; col++)
                ui->searchStopsTableWidget->setItem(row, col, new QTableWidgetItem(item[col]));

            row++;
        }

        ui->searchStopsTableWidget->resizeColumnsToContents();
        ui->searchStopsResultCountLabel->setText(QString::fromStdString("Results: " + std::to_string(rowCount)));

        return 0;
    }
    else // we didn't find any stops matching the criteria
    {
        QMessageBox msgBox;
        msgBox.setIcon(QMessageBox::Information);
        msgBox.setText("No results found!");
        msgBox.setInformativeText("Your search criteria did not match any results. Please try again with different keywords.");
        msgBox.setWindowTitle("Search Results");
        msgBox.setStandardButtons(QMessageBox::Ok);

        msgBox.exec();

        if (ui->searchStopsAccessibleCheckBox->isChecked())
        {
            ui->searchStopsAccessibleCheckBox->setChecked(false);
        }

        return 1;
    }
}

bool MainWindow::strCmp(const std::string& str1, const std::string& str2)
{
    // Helper lambda function to convert a string to lowercase
    auto toLower = [](const std::string& str) -> std::string
    {
        std::string lowerStr = str;
        std::transform(lowerStr.begin(), lowerStr.end(), lowerStr.begin(), [](unsigned char c) { return std::tolower(c); });
        return lowerStr;
    };

    std::string str1Lower = toLower(str1);
    std::string str2Lower = toLower(str2);

    if (str1Lower == str2Lower)
        return true;

    // find returns npos if not found
    if (str2Lower.find(str1Lower) != std::string::npos)
        return true;

    if (str1Lower.find(str2Lower) != std::string::npos)
        return true;

    return false;
}
