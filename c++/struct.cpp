#include <stdio.h>

int main() {
  struct point {
    double x;
    double y;
  };

  struct point p1, p2;

  p1.x = 3.0;
  p1.y = 4.0;

  p2 = p1;
  printf("%f %f\n", p2.x, p2.y);
}
