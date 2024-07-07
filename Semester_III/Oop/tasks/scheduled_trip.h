#pragma once

#include <vector>
#include "types.h"

namespace bht
{
    /**
     * Defines a class representing a single trip with convenient accessor get methods to
     * related route, stop and stop times information
     */
    class NetworkScheduledTrip
    {
        private:
        // TODO: THIS CLASS IS INCOMPLETE AND YOU NEED TO IMPLEMENT THE REQUIRED ATTRIBUTES
            const std::vector<StopTime> trip; // vector<pair<StopTime, pair<stop_sequence, stopId>>>
            const std::string tripId;
            unsigned int it;

        public:
            /**
             * Define an iterator to navigate the stops of a scheduled trip
            */
            NetworkScheduledTrip(const std::vector<StopTime> trip, const std::string tripId) : trip{trip}, tripId{tripId}, it{0} { }

            class iterator
            {
                private:
                // TODO: THIS CLASS IS INCOMPLETE AND YOU NEED TO IMPLEMENT THE REQUIRED ATTRIBUTES
                    NetworkScheduledTrip *parent;
                    const StopTime* element;

                public:
                // TODO: THIS CLASS IS INCOMPLETE AND YOU NEED TO IMPLEMENT THE REQUIRED ATTRIBUTES
                    iterator(NetworkScheduledTrip *parent, const StopTime* element) : parent{parent}, element{element} {}

                    /**
                     * Move the iterator to the next stop in this trip
                     */
                    iterator& operator++();

                    /**
                     * Move the iterator to the previous stop in this trip
                     */
                    iterator& operator--();

                    /**
                     * Return the current stop time this iterator points to
                     * HINT operator* is the dereference operator; NOT the multiplication operator
                    */
                    const StopTime& operator*() const;

                    /**
                     * Return the referenced trip of the current stop
                     */
                    const std::string& getTripId() const;

                    /**
                     * return the current stop sequence number on the trip
                     * HINT: This sequence number might be invalid to indicate the end of a trip
                     */
                    unsigned int getStopSequence() const;

                    /**
                     * Two stops are considered equal if they are in the same trip
                     * and represent the same stop in the sequence of stops
                     */
                    bool operator==(const iterator& b) const;
                    bool operator!= (const iterator& b) const;
            };

        /**
         * Create a new iterator representing the start of a trip
         */
        iterator begin();

        /**
         * Create a new iterator pointing beyond the last element of the trip
         */
        iterator end();
    };

}
