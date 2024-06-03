#ifndef PERSON_H
#define PERSON_H

#include <iostream>

class Person {
    friend std::ostream& operator<<(std::ostream& out, const Person& person);
  public:
     Person() = default;
    ~Person() = default;
    Person(std::string first_name_param, std::string last_name_param);

    // Getters
    std::string get_first_name() const {
      return first_name;
    }

    std::string get_last_name() const {
      return last_name;;
    }

  private:
    std::string first_name{"Mysterious"};
    std::string last_name{"Person"};
};
#endif // PERSON_H
