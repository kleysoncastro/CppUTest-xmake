#include <iostream>
#include "mqtt.h"

namespace mqtt_ultil
{

    void print_msg(void)
    {
        std::cout << "hello print mqtt" << std::endl;
    }

    std::string pyload(void)
    {
        return "mqtt";
    }

}