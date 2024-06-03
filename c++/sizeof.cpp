#include <stdio.h>

int main() {
  struct point {
    double x;
    double y;
  };

  struct point pt, *pp;

  printf("sizeof pt  %1zu\n", sizeof(pt));
  printf("sizeof pp  %1zu\n", sizeof(pp));
  printf("sizeof point %1zu\n", sizeof(struct point));
}
