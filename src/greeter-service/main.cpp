#include <cstdlib>
#include <iostream>
#include <memory>

// #include <proto/greeter.grpc.pb.h>
#include <proto/greeter.pb.h>

int
main(int argc, char** argv)
{
    try
    {
        // Greeter::AsyncService _greeterService{};
        HelloRequest _request{};
        HelloReply _reply{};
        std::cout << "greeter service created -- no stacksmash" << std::endl;
        return EXIT_SUCCESS;
    }
    catch (const std::exception& e)
    {
        std::cerr << "\nUncaught exception: " << e.what() << std::endl;
        throw;
    }
    catch (...)
    {
        std::cerr << "\nUncaught exception of unknown type" << std::endl;
        throw;
    }
}
