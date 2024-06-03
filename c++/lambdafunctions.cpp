#include <iostream>

int main() {
  auto func = []() {
    std::cout << "Hello World!" << std::endl;
  };

  func();

  []() {
    std::cout << "Hello there!" << std::endl;
  }();
  
  [](double a, double b) {
    std::cout << "The sum of " << a << " and " << b << " is " << a + b << std::endl;
  }(1.0, 2.0);
  
  auto result = [](double a, double b) {
    return a + b;
  }(12.1, 5.7);
  std::cout << "The result is : " << result << std::endl;

  int c{42};

  auto captureList = [=]() {
    std::cout << "The value of c is : " << c << std::endl;
  };

  captureList();

  for (size_t i = 0; i < 5; i++) {
      std::cout << "Outer value : " << c << std::endl;
      func();
      ++c;
  }
  return 0;
}

