#include <iostream>

int main() {

  // std::cout : Printing stuff to the console
  std::cout << "Hello World!" << std::endl;
 
  std::cout << "The number is : " << 1 << std::endl;

  int age = 21;
  std::cout << "My age is : " << age << std::endl;

  // Error
  std::cerr << "std::cerr output : Something went wrong" << std::endl;

  // Log message
  std::clog << "std::clog output : This is a log message" << std::endl;

  std::string name;

  std::cout << "Please type in your Last Name : " << std::endl;
  std::cin >> name;

  std::cout << "Please type in your age : " << std::endl;
  std::cin >> age;

  std::cout << "Hello " << name << "! You are " << age << " years old " << std::endl;
}
