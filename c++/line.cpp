#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>

int main() {
  FILE* file = fopen("romeo.txt", "r");
  if (file == NULL) {
    std::cout << "Error opening file\n";
    return 1;
  }
  
  // how go we get size of file?
  int fileSize = fseek(file, 0, SEEK_END);
 
  std::cout << "File size: " << fileSize << "\n";

  while (file.getline(line, 100)) {
    std::cout << line << "\n";
  }

  fclose(file);
  std::cout << file << "\n";


}
