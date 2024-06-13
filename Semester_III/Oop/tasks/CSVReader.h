#ifndef UEBUNG_1_CSVREADER_H
#define UEBUNG_1_CSVREADER_H

#include <string>
#include <fstream>
#include <vector>

class CSVReader
{
  private:
    std::string filepath;
    //std::string filename;
    std::ifstream file;
    void openFileAndGetHeaders();
    void readCellsIntoVector(std::vector<std::string>& vec);

  public:
    // can't really explain it but explicit is (necessary) for constructors with a single parameter so the compiler
    // doesn't try to make an implicit conversion from the parameter type (here: std::string) to the class (here: CSVReader)
    explicit CSVReader(const std::string& filepath)
    {
      this->filepath = filepath;
      openFileAndGetHeaders();
    }
    std::string line;
    std::vector<std::string> fields, rowValues;
    std::string getField(const std::string& key);
    std::string getField(const std::string& key, std::string defaultValue);
    bool next();
    bool hasNext();
    void reset();

  ~CSVReader() { file.close(); }
};

#endif //UEBUNG_1_CSVREADER_H
