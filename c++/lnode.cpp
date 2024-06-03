#ifndef LNODE_H
#define LNODE_H

struct lnode {
  char *text;
  struct lnode *next;
};

#endif
