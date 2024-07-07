#include "Network.h"
#include "CSVReader.h"
#include "types.h"
#include <filesystem>
#include <set>

#include <queue>

#include <QtDebug>

namespace st = std::filesystem;

namespace bht
{
  void Network::readCSVFiles()
  {
    for (const auto& entry : st::directory_iterator(dirpath))
    {
      if (entry.is_regular_file() && (entry.path().extension() == ".txt" || entry.path().extension() == ".csv"))
      {
        // I can't use switches with strings wtf O.0
          std::string name = entry.path().filename().string();
        if (name == "agency.txt")
        {
          CSVReader r{entry.path().string()};

          do
          {
              if (!r.line.empty())
              {
                  try
                  {
                      agencies[r.getField("agency_id")] = {r.getField("agency_id"), r.getField("agency_name"), r.getField("agency_url"), r.getField("agency_timezone"), r.getField("agency_lang"), r.getField("agency_phone") };
                  }
                  catch (std::invalid_argument)
                  {
                      qDebug() << "conversion error : agencies";
                  }
              }
          }
          while (r.next());
        }
        else if (name == "calendar.txt")
        {
          CSVReader r{entry.path().string()};

          std::string sDate, eDate;
          do
          {
              if (!r.line.empty())
              {
                  try
                  {
                      sDate = r.getField("start_date"), eDate = r.getField("end_date");
                      calendars[r.getField("service_id")] = {r.getField("service_id"), (ECalendarAvailability)std::stoi(r.getField("monday", "0")), (ECalendarAvailability)std::stoi(r.getField("tuesday", "0")), (ECalendarAvailability)std::stoi(r.getField("wednesday", "0")), (ECalendarAvailability)std::stoi(r.getField("thursday", "0")), (ECalendarAvailability)std::stoi(r.getField("friday", "0")), (ECalendarAvailability)std::stoi(r.getField("saturday", "0")), (ECalendarAvailability)std::stoi(r.getField("sunday", "0")), sDate.empty() ? GTFSDate{ 0, 0, 0 } : GTFSDate{(unsigned char)std::stoi(sDate.substr(6, 2)), (unsigned char)std::stoi(sDate.substr(4, 2)), (unsigned short)std::stoi(sDate.substr(0, 4)) }, eDate.empty() ? GTFSDate{ 0, 0, 0 } : GTFSDate{(unsigned char)std::stoi(eDate.substr(6, 2)), (unsigned char)std::stoi(eDate.substr(4, 2)), (unsigned short)std::stoi(eDate.substr(0, 4)) } };
                  }
                  catch (std::invalid_argument)
                  {
                      qDebug() << "conversion error : calendars";
                  }
              }
          } while (r.next());
        }
        else if (name == "calendar_dates.txt")
        {
          CSVReader r{entry.path().string()};

          std::string date;
          do
          {
              if (!r.line.empty())
              {
                  try
                  {
                      date = r.getField("date");
                      calendarDates.push_back({r.getField("service_id"), date.empty() ? GTFSDate{ 0, 0, 0 } : GTFSDate{(unsigned char)std::stoi(date.substr(6, 2)), (unsigned char)std::stoi(date.substr(4, 2)), (unsigned short)std::stoi(date.substr(0, 4)) }, (ECalendarDateException)std::stoi(r.getField("exception_type", "0")) });
                  }
                  catch (std::invalid_argument)
                  {
                      qDebug() << "conversion error : calendarDates";
                  }
              }
          } while (r.next());
        }
        else if (name == "levels.txt")
        {
          CSVReader r{entry.path().string()};

          do
          {
              if (!r.line.empty())
              {
                  try
                  {
                      levels[r.getField("level_id")] = {r.getField("level_id"), (unsigned int)std::stoi(r.getField("level_index", "0")), r.getField("level_name")};
                  }
                  catch (std::invalid_argument)
                  {
                      qDebug() << "conversion error : levels";
                  }
              }
          }
          while (r.next());
        }
        else if (name == "pathways.txt")
        {
            CSVReader r{entry.path().string()};

            do
            {
                if (!r.line.empty())
                {
                    try
                    {
                        pathways[r.getField("pathway_id")] = { r.getField("pathway_id"), r.getField("from_stop_id"), r.getField("to_stop_id"), (EPathwayMode)std::stoi(r.getField("pathway_mode", "0")), (bool)std::stoi(r.getField("is_bidirectional", "0")), std::stof(r.getField("traversal_time", "0")), (unsigned int)std::stoi((r.getField("length", "0"))), (unsigned int)std::stoi(r.getField("stair_count", "0")), std::stof(r.getField("max_slope", "0")), std::stof(r.getField("min_width", "0")), r.getField("signposted_as") };
                    }
                    catch (std::invalid_argument)
                    {
                        qDebug() << "conversion error : pathways";
                    }
                }
            }
            while (r.next());
        }
        else if (name == "routes.txt")
        {
            CSVReader r{entry.path().string()};

            do
            {
                if (!r.line.empty())
                {
                    try
                    {
                        routes[r.getField("route_id")] = { r.getField("route_id"), r.getField("agency_id"), r.getField("route_short_name"), r.getField("route_long_name"), r.getField("route_desc"), (ERouteType)std::stoi(r.getField("route_type", "0")), r.getField("route_color"), r.getField("route_text_color") };
                    }
                    catch (std::invalid_argument)
                    {
                        qDebug() << "conversion error : routes";
                    }
                }
            }
            while (r.next());
        }
        else if (name == "shapes.txt")
        {
          CSVReader r{entry.path().string()};

            do
            {
                if (!r.line.empty())
                {
                    try
                    {
                        shapes.push_back({ r.getField("shape_id"), std::stod(r.getField("shape_pt_lat", "0")), std::stod(r.getField("shape_pt_lon", "0")), (unsigned int)std::stoi(r.getField("shape_pt_sequence", "0")) });
                    }
                    catch (std::invalid_argument)
                    {
                        qDebug() << "conversion error : shapes";
                    }
                }
            }
            while (r.next());
        }
        else if (name == "stop_times.txt")
        {
          CSVReader r{entry.path().string()};

          std::string aTime, dTime;
          do
          {
              if (!r.line.empty())
              {
                  try
                  {
                      aTime = r.getField("arrival_time"), dTime = r.getField("departure_time");
                      stopTimes.push_back({ r.getField("trip_id"), aTime.empty() ? GTFSTime{ 0, 0, 0 } : GTFSTime{ (unsigned char)std::stoi(aTime.substr(0, 2)),  (unsigned char)std::stoi(aTime.substr(aTime.find(':', 0) + 1, 2)), (unsigned char)std::stoi(aTime.substr(aTime.find(':', aTime.find(':', 0) + 1) + 1, 2)) }, dTime.empty() ? GTFSTime{ 0, 0, 0 } : GTFSTime{ (unsigned char)std::stoi(dTime.substr(0, 2)),  (unsigned char)std::stoi(dTime.substr(dTime.find(':', 0) + 1, 2)), (unsigned char)std::stoi(dTime.substr(dTime.find(':', dTime.find(':', 0) + 1) + 1, 2)) }, r.getField("stop_id"), (unsigned int)std::stoi(r.getField("stop_sequence", "0")), (EPickupType)std::stoi(r.getField("pickup_type", "0")), (EDropOffType)std::stoi(r.getField("drop_off_type", "0")), r.getField("stop_headsign") });
                  }
                  catch (std::invalid_argument)
                  {
                      qDebug() << "conversion error : stopTimes";
                  }
              }
          }
          while (r.next());
        }
        else if (name == "stops.txt")
        {
          CSVReader r{entry.path().string()};

            do
            {
                if (!r.line.empty())
                {
                    try
                    {
                        stops[r.getField("stop_id")] = { r.getField("stop_id"), r.getField("stop_code"), r.getField("stop_name"), r.getField("stop_desc"), std::stod(r.getField("stop_lat", "0")), std::stod(r.getField("stop_lon", "0")), (ELocationType)std::stoi(r.getField("location_type", "0")), r.getField("parent_station"), (EWheelchairAccessibility)std::stoi(r.getField("wheelchair_boarding", "0")), r.getField("platform_code"), r.getField("level_id"), r.getField("zone_id") };
                    }
                    catch (std::invalid_argument)
                    {
                        qDebug() << "conversion error : stops";
                    }
                }
            }
            while (r.next());
        }
        else if (name == "transfers.txt")
        {
          CSVReader r{entry.path().string()};

            do
            {
                if (!r.line.empty())
                {
                    try
                    {
                        transfers.push_back({ r.getField("from_stop_id"), r.getField("to_stop_id"), r.getField("from_route_id"), r.getField("to_route_id"), r.getField("from_trip_id"), r.getField("to_trip_id"), (ETransferType)std::stoi(r.getField("transfer_type", "0")), (unsigned int)std::stoi(r.getField("min_transfer_time", "0")) });
                    }
                    catch (std::invalid_argument)
                    {
                        qDebug() << "conversion error : transfers";
                    }
                }
            }
            while (r.next());
        }
        else if (name == "trips.txt")
        {
          CSVReader r{entry.path().string()};

            do
            {
                if (!r.line.empty())
                {
                    try
                    {
                        trips.push_back({ r.getField("trip_id"), r.getField("route_id"), r.getField("service_id"), r.getField("trip_headsign"), r.getField("trip_short_name"), (ETripDirection)std::stoi(r.getField("direction_id", "0")), r.getField("block_id"), r.getField("shape_id"), (EWheelchairAccessibility)std::stoi(r.getField("wheelchair_accessible", "0")), (bool)std::stoi(r.getField("bikes_allowed", "0")) });
                    }
                    catch (std::invalid_argument)
                    {
                        qDebug() << "conversion error : trips\n" << "\ttrip_id=" << r.getField("trip_id") << "\n" << "\troute_id=" << r.getField("route_id") << "\n" << "\tservice_id=" << r.getField("service_id") << "\n" << "\ttrip_headsign=" << r.getField("trip_headsign") << "\n" << "\ttrip_short_name=" << r.getField("trip_short_name") << "\n" << "\tdirection_id=" << r.getField("direction_id") << "\n" << "\tblock_id=" << r.getField("block_id") << "\n" << "\tshape_id=" << r.getField("shape_id") << "\n" << "\twheelchair_accessible=" << r.getField("wheelchair_accessible") << "\n" << "\tbikes_allowed=" << r.getField("bikes_allowed") << "\n";
                    }
                }
            }
            while (r.next());
        }
      }
    }
  }

    std::vector<Stop> Network::search(std::string searchString, bool accessible)
    {
        std::transform(searchString.begin(), searchString.end(), searchString.begin(), ::tolower); // not influenced by empty string
        oldSearchString = searchString;
        /* this line above is supposed to be for later implementation. An idea is to isntead of returning a vector, we set the
         * search(Accessible)Stops vector properties in the Network class and when the oldSearchString equals the searchString
         * we obviously don't have to search again. Another point is that when search is called with the same searchString but
         * accessible=true we either have already set the searchAccessibleStops vector or else if not implemented that way we
         * just search for accessibility in the searchStops vector*/

        std::string cmpStrLowerCase; // I've read that declared strings like this are initialized as an empty string by default
        std::vector<Stop> result;
        for (const auto& str : stops)
        {
            // find returns npos if not found
            if (!accessible)
            {
                if (searchString.empty())
                    result.push_back(str.second);
                else
                {
                    cmpStrLowerCase = str.second.name;
                    std::transform(cmpStrLowerCase.begin(), cmpStrLowerCase.end(), cmpStrLowerCase.begin(), ::tolower);
                    if (cmpStrLowerCase.find(searchString) != std::string::npos)
                    {
                        result.push_back(str.second);
                    }
                }
            }
            else
            {
                if (str.second.wheelchairBoarding == WheelchairAccessibility_Available)
                {
                    if (searchString.empty())
                        result.push_back(str.second);
                    {
                        cmpStrLowerCase = str.second.name;
                        std::transform(cmpStrLowerCase.begin(), cmpStrLowerCase.end(), cmpStrLowerCase.begin(), ::tolower);
                        if (cmpStrLowerCase.find(searchString) != std::string::npos)
                        {
                            result.push_back(str.second);
                        }
                    }
                }
            }
        }
        return result;
    }

    bool Network::neighborAlreadyExistsInAdjList(std::string nodeStopId, std::string neighborStopId)
    {
        auto iterator = std::find_if(adjacencyList[nodeStopId].begin(), adjacencyList[nodeStopId].end(), [&neighborStopId](const std::string& p)
        {
            return p == neighborStopId;
        });

        if (iterator == adjacencyList[nodeStopId].end()) // if the iterator is at the end we searched through the entire vector without finding our node(stop)
        {
            return false;
        }
        return true;
    }

    void Network::createAdjacencylist()
    {
        for (const auto& stopTime : stopTimes)
        {
            tripsWithSortedStopsByStop_sequence[stopTime.tripId].emplace_back(stopTime.stopSequence, stopTime.stopId);
        }
        for (auto& entry : tripsWithSortedStopsByStop_sequence) // sort by stop_sequence
        {
            std::vector<std::pair<unsigned int, std::string>>& stops = entry.second;
            std::sort(stops.begin(), stops.end(), [](const std::pair<unsigned int, std::string>& a, const std::pair<unsigned int, std::string>& b)
            {
                return a.first < b.first;
            });
        }

        for (auto& trip : tripsWithSortedStopsByStop_sequence)
        {
            unsigned short c = 0;
            auto length = trip.second.size() - 1; // -1 accounting for c starting at 0
            for (auto& stop : trip.second)
            {
                if (c < length) // first stop on the trip
                {
                    if (!neighborAlreadyExistsInAdjList(stop.second, trip.second[c + 1].second))// check if we already inserted this stop as neighbor
                        adjacencyList[stop.second].emplace_back(trip.second[c + 1].second); // add next stop on trip as neighbor
                }
                c++;
            }
        }
        // HOW COULD I FCKN FORGET TO ADD CROSSOVERS AS CONNECTION.. IM LITERALLY RETARDED THAT COST HOURS IF NOT DAYS ▄︻̷̿┻̿═━一 (ಠ‿ಠ)
        for (const std::pair<std::string, std::vector<std::string>>& node : adjacencyList)
        {
            for (const std::pair<std::string, Stop>& stop : stops)
            {
                const Stop& currentStop = stops[node.first];
                if (currentStop.zoneId == stop.second.zoneId && currentStop.id != stop.second.id)
                {
                    if (!neighborAlreadyExistsInAdjList(currentStop.id, stop.second.id))
                        adjacencyList[currentStop.id].emplace_back(stop.second.id);
                }
            }
        }
    }

    // upgrade from Dijkstra, so
    double heuristic(const Stop& a, const Stop& b)
    {
        // Simple Euclidean distance as heuristic
        double dx = a.longitude - b.longitude;
        double dy = a.latitide - b.latitide;
        return std::sqrt(dx * dx + dy * dy);
    }

    std::vector<bht::StopTime> Network::getTravelPlan(const std::string& fromStopId, const std::string& toStopId)
    {
        // A* algorithm
        bool pathFound = false;

        //std::priority_queue<std::pair<int, std::string>> openlist;
        std::set<std::pair<int, std::string>> openlist;
        std::set<std::pair<int, std::string>> closedlist;

        std::unordered_map<std::string, int> gScore;
        std::unordered_map<std::string, std::string> previous;

        //openlist.push({0, fromStopId});
        openlist.insert({0, fromStopId});

        while (!openlist.empty())
        {
            //std::pair<int, std::string> currentStop = openlist.top();
            std::pair<int, std::string> currentStop = *openlist.begin();
            std::string currentStopId = currentStop.second;
            //openlist.pop();
            openlist.erase(openlist.begin());

            if (currentStopId == toStopId) // Hooray! we found the shortest path (づ｡◕‿‿◕｡)づ
            {
                pathFound = true;
                break;
            }

            closedlist.emplace(currentStop);

            for (const std::string& neighbor : adjacencyList[currentStopId]) // adjList[currentStopId] is vector<trip_id, stop_sequence> from stop_times
            {
                //if (closedlist.contains(neighbor)) then continue
                bool c0ntinue = false;
                for (const std::pair<int, std::string>& item :  closedlist)
                        if (item.second == neighbor)
                            c0ntinue = true;
                if (c0ntinue)
                    continue;

                int tentative_gScore = gScore[currentStopId] + (stops[neighbor].zoneId == stops[currentStopId].zoneId ? 0 : 1); // weight; check for Gleiswechsel lol

                //if (openlist.contains(neighbor))
                bool isInOpList = false;
                for (const std::pair<int, std::string>& item : openlist)
                    if (item.second == neighbor)
                        isInOpList = true;
                if (isInOpList && tentative_gScore >= gScore[neighbor])
                    continue;

                // Vorgängerzeiger setzen und g Wert merken oder anpassen
                previous[neighbor] = currentStopId; // successor.predecessor := currentNode
                gScore[neighbor] = tentative_gScore; // g(successor) = tentative_g
                // f-Wert des Knotens in der Open List aktualisieren
                // bzw. Knoten mit f-Wert in die Open List einfügen
                int fScore = gScore[neighbor] + heuristic(stops[neighbor], stops[toStopId]); // f := tentative_g + h(successor)

                openlist.insert({fScore, neighbor}); // do I have to remove the old val?!
                /*if (isInOpList) // in theory this should update the val and else should insert
                    openlist.insert({fScore, neighbor}); // do I have to remove the old val?!
                else
                    openSet.insert({fScore[neighbor], neighbor});*/
            }
        }

        if (pathFound)
        {
            // Reconstruct the path
            std::vector<StopTime> travelPlan;
            std::string currentStopId = toStopId;

            while (currentStopId != fromStopId)
            {
                StopTime stopTime;
                stopTime.stopId = currentStopId;
                travelPlan.push_back(stopTime);
                currentStopId = previous[currentStopId];
            }
            StopTime stopTime;
            stopTime.stopId = fromStopId;
            travelPlan.push_back(stopTime);

            std::reverse(travelPlan.begin(), travelPlan.end());
            return travelPlan;
        }
        else return {};
    }

    NetworkScheduledTrip Network::getScheduledTrip(const std::string& tripId) const
    {
        std::vector<StopTime> stopTimesOfTrip;
        for (const std::pair<unsigned int, std::string>& stop : tripsWithSortedStopsByStop_sequence.at(tripId))
        {
            for (const StopTime& item : stopTimes)
                if (stop.second == item.stopId)
                {
                    stopTimesOfTrip.push_back(item);
                    break;
                }
        }
        return NetworkScheduledTrip(stopTimesOfTrip, tripId);
    }
}
