#include <iostream>
#include "cylinder.h"

Cylinder::Cylinder(double radius_param, double height_param) {
  base_radius = radius_param;
  height = height_param;
}

double Cylinder::volume() {
      return M_PI * base_radius * base_radius * height;
}

int main() {
  Cylinder c;
  std::cout << "Volume : " << c.volume() << std::endl;
  
  Cylinder cylinder1{3.0, 4.0};
  std::cout << "Volume : " << cylinder1.volume() << std::endl;
  return 0;
}


