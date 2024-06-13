#ifndef UEBUNG_1_NETWORK_H
#define UEBUNG_1_NETWORK_H

#include <string>
#include <unordered_map>
#include <vector>
#include "types.h"

namespace bht
{
    class Network
    {
        private:
            std::string dirpath;

            void readCSVFiles();

        public:
            Network(){;} // necessary for QT it seems
            explicit Network(const std::string& dirpath)
            {
              this->dirpath = dirpath;
              readCSVFiles();
            }

            // NOTE: the last element in the file is the first in the enumerable
            std::unordered_map<std::string, Agency> agencies;
            std::vector<CalendarDate> calendarDates;
            std::unordered_map<std::string, Calendar> calendars;
            std::unordered_map<std::string, Level> levels;
            std::unordered_map<std::string, Pathway> pathways;
            std::unordered_map<std::string, Route> routes;
            std::vector<Shape> shapes;
            std::vector<StopTime> stopTimes;
            std::unordered_map<std::string, Stop> stops;
            std::vector<Transfer> transfers;
            std::vector<Trip> trips;

            std::string oldSearchString;
            std::vector<Stop> searchedStops;
            //std::vector<Stop> searchedAccessibleStops;

            std::pair<std::string, Route> selectedRoute;
            std::vector<Trip> tripsOfSelectedRoute;
            Trip selectedTrip;
            std::vector<StopTime> stopTimesOfSelectedTrip;

            std::vector<Stop> search(std::string searchString, bool accessible = false);
            //std::vector<bht::StopTime> getTravelPlan(const std::string& fromStopId, const std::string& toStopId);
  };
}

#endif //UEBUNG_1_NETWORK_H
