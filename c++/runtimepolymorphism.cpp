#include <iostream>
using namespace std;

class Animal {
  public:
    virtual void makeSound() const {
      cout << "Some generic anaimal sound" << endl;
    } 

    virtual ~Animal() = default; // Virtual destructor
};

class Dog : public Animal {
  public:
    void makeSound() const override { // Override keyword is optional
      cout << "Wolf!" << endl;
    }
};

class Cat : public Animal {
  public:
    void makeSound() const override {
      cout << "Meow!" << endl;
    }
};

int main() {
  Animal* animal1 = new Dog();
  Animal* animal2 = new Cat();

  animal1->makeSound(); // Output: Wolf!
  animal2->makeSound(); // Output: Meow!

  delete animal1;
  delete animal2;

  return 0;
}
