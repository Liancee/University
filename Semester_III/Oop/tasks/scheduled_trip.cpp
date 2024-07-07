#include "scheduled_trip.h"

namespace bht
{
    NetworkScheduledTrip::iterator& NetworkScheduledTrip::iterator::operator++()
    {
        if (parent->it < parent->trip.size() - 1) // why dis -1?!
        {
            parent->it += 1;
            element = &(parent->trip.at(parent->it));
        }
        else
            element = nullptr;

        return *this;
    }

    NetworkScheduledTrip::iterator& NetworkScheduledTrip::iterator::operator--()
    {
        if (parent->it > 0)
        {
            parent->it -= 1;
            element = &(parent->trip.at(parent->it));
        }
        else
            element = nullptr;

        return *this;
    }

    const StopTime& NetworkScheduledTrip::iterator::operator*() const
    {
        //if (element == nullptr)
            //return parent->stopTimes.front(); // helloo what do I return when I didn't find it?!

        return *element;
        /*std::string currStopId = element->second;
        for (const auto& item : parent->stopTimes)
            if (!item.stopId.compare(currStopId))
                return item;*/

        // helloo what do I return when I didn't find it?!
        //return parent->stopTimes.front();
    }

    const std::string& NetworkScheduledTrip::iterator::getTripId() const
    {
        return parent->tripId;
    }

    unsigned int NetworkScheduledTrip::iterator::getStopSequence() const
    {
        if (element != nullptr)
            return element->stopSequence;
        else
            return UINT_MAX;
    }

    bool NetworkScheduledTrip::iterator::operator==(const iterator& b) const
    {
        return getTripId() == b.getTripId() && getStopSequence() == b.getStopSequence();
    }

    bool NetworkScheduledTrip::iterator::operator!=(const iterator& b) const
    {
        return !(this->operator==(b));
    }

    NetworkScheduledTrip::iterator NetworkScheduledTrip::begin()
    {
        return iterator{ this, &trip.front() };
    }

    NetworkScheduledTrip::iterator NetworkScheduledTrip::end()
    {
        return iterator{ this, nullptr };
    }
}
