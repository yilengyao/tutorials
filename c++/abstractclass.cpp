#include <iostream>
using namespace std;

class AbstractAnimal {
  public:
    virtual void makeSound() const = 0; // Pure virtual function
    virtual ~AbstractAnimal() = default;                                       
};

class Dog : public AbstractAnimal {
  public:
    void makeSound() const override {
      cout << "Wolf!" << endl;
    }
};

class Cat : public AbstractAnimal {
  public:
    void makeSound() const override {
      cout << "Meow!" << endl;
    }
};

int main() {
  AbstractAnimal* animal1 = new Dog();
  AbstractAnimal* animal2 = new Cat();

  animal1->makeSound(); // Output: Wolf!
  animal2->makeSound(); // Output: Meow!
                        //
  delete animal1;
  delete animal2;

  return 0;// //
}


