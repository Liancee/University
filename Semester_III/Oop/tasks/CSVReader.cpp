#include "CSVReader.h"
#include <iostream>
#include <sstream>
#include <algorithm>

void CSVReader::openFileAndGetHeaders()
{
  //std::ifstream file(filepath.c_str(), std::ifstream::in);
  file.open(filepath.c_str());
  if (!file.is_open())
  {
    std::cerr << "Error opening file: " << filepath.c_str() << std::endl;
    //throw std::runtime_error("Error opening file: " + filepath);
    exit(EXIT_FAILURE);
  }
  else if (file.good() && !(file.peek() == std::ifstream::traits_type::eof())) // && is not empty
  {
    //filename = filepath.substr(filepath.find_last_of('/') + 1);

    // get file headers
    if (!next())
    {
      // this is for reading the first line (headers), so the next() func implies sth false here
      std::cout << "Couldn't read headers, program will exit..." << std::endl;
      exit(EXIT_FAILURE);
    }
    readCellsIntoVector(fields);
    if (!next())
    {
      std::cout << "Couldn't read the next line after headers, program will exit..." << std::endl;
      exit(EXIT_FAILURE);
    }
  }
  else std::cout << "Error opening file: " << filepath.c_str() << std::endl;
  //for (int i = 0; i < r.fields.size(); i++) std::cout << fields[i] << std::endl;
}

std::string CSVReader::getField(const std::string& key) { return getField(key, {}); }
std::string CSVReader::getField(const std::string& key, std::string defaultValue)
{
  unsigned short index;
  std::string val;
  auto iterator = std::find(fields.begin(), fields.end(), key);
  if (iterator != fields.end())
  {
    index = std::distance(fields.begin(), iterator); // element was found, set index
    val = rowValues[index];
    if (!val.empty()) return val;
  }
  return defaultValue; // {} is equivalent to return std::string and is String.Empty from C#
}

void CSVReader::readCellsIntoVector(std::vector<std::string>& vec)
{
  vec.clear(); // forgot that push_back only appends *___*

  if (!line.empty() && (line.back() == '\r' || line.back() == '\n')) line.erase(line.size() - 1);

  std::stringstream ss(line);
  std::string cell, longCell;
  bool inQuotes = false;
  while (std::getline(ss, cell, ','))
  {
    if (!inQuotes)
    {
      if (!cell.empty() && cell.front() == '"') // check if the cell starts with a quote
      {
        inQuotes = true;
        cell.erase(0, 1); // remove the opening quote
        longCell = cell; // we ate this first part if this cell didn't end with an "
      }

      // If the cell ends with a quote, we're exiting quoted text
      if (!cell.empty() && cell.back() == '"')
      {
        inQuotes = false;
        cell.pop_back(); // remove the closing quote
      }
    }
    else
    {
      // check if we end with a ", otherwise if this is the second iteration we have multiple , chars within a cell O.0
      if (!cell.empty() && cell.back() != '"') longCell += ',' + cell;//vec.back() += ',' + cell;
      else // cell ends with a quote, we're exiting quoted text and thus append
      {
        inQuotes = false;
        cell.pop_back(); // remove the closing quote
        longCell += cell; // get the last part of the now finished longCell
        cell = longCell; // set the complete longCell as cell to be pushed
      }
    }

    // append the cell to the vector if we're not inside quoted text
    if (!inQuotes) vec.push_back(cell);


    // remove puts all " chars at the end of the string and returns an iterator pointing at the first " char of them
    // that is now at the end. Then erase deletes all chars from the string starting at this iterator to the last char.
    //cell.erase(std::remove(cell.begin(), cell.end(), '"'), cell.end());
  }
}

bool CSVReader::next()
{
  if (!file.eof())
  {
    getline(file, line);
    readCellsIntoVector(rowValues);
    return true;
  }
  return false;
}

auto CSVReader::hasNext() -> bool { return file.peek() != EOF; }

void CSVReader::reset()
{
  file.seekg(0, std::ios::beg); // goto start of file
  getline(file, line); // go to first line of file containing headers
  getline(file, line); // go to first line containing data
}
