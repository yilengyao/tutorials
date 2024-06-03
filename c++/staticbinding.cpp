#include <iostream>
using namespace std;

class Base{
  public:
    void show() const {
      cout << "Base::show() called" << endl;
    }
};

class Derived : public Base {
  public:
    void show() const {
      cout << "Derived::show() called" << endl;
    }
};

int main() {
  Base b;
  Derived d;
  Base* bPtr = &b;
  Base* dPtr = &d; // Note: dPtr is a Base pointer, 
  b.show(); // Output: Base::show() called
  d.show(); // Output: Derived::show() called
  bPtr->show(); // Output: Base::show() called
  dPtr->show(); // Output: Base::show() called, due to static binding

  delete bPtr;
  delete dPtr;

  return 0;
}
