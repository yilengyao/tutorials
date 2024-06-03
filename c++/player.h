#ifndef PLAYER_H
#define PLAYER_H

#include <string>
#include <iostream>
#include "person.h"

class Player : public Person {
      friend std::ostream& operator<<(std::ostream& out, const Player& player);
    public:
      Player() = default;
      ~Player() = default;
      Player(std::string game_param);
      Player(std::string& game_param);
    private:
      std::string m_game{"None"};
};

#endif // PLAYER_H
