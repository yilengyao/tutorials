#include "person.h"

Person::Person(std::string first_name_param, std::string last_name_param)
  : first_name(first_name_param), last_name(last_name_param) {
}

std::ostream& operator<<(std::ostream& out, const Person& person) {
  out << "Pserson [" << person.first_name << " " << person.last_name << "]";
  return out;
}

