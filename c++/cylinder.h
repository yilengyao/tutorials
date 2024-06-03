#define _USE_MATH_DEFINES
#include <cmath>

class Cylinder {
  private :
    double base_radius {1.0};
    double height {1.0};

  public :
    Cylinder() = default;

    Cylinder(double radius_param, double height_param);

    double volume(); 
};
