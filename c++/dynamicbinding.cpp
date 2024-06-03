#include <iostream>
using namespace std;

class Base {
  public:
    virtual void show() const {
      cout << "Base::show() called" << endl;
    }

    virtual ~Base() = default; // Virtual destructor
};

class Derived : public Base {
  public:
    void show() const override {
      cout << "Derived::show() called" << endl;
    }
};

int main() {
  Base* bPtr = new Base();
  Base* dPtr = new Derived();

  bPtr->show(); // Output: Based::show() called
  dPtr->show(); // Output: Derived::show() called

  delete bPtr;
  delete dPtr;//

  return 0;            
}

