#include <iostream>
#include <chrono>

#define Lh  1000 // impulse
#define Lx  100000 // input
#define REP 100 // number of repetitions

int main() {

    int Lz = Lx + 2*(Lh-1); // Length of padded input
    int Ly = Lh + Lx - 1; // Length of output

    int y[Ly] = { 10 }; // Output array
    int x[Lz] = { 10 }; // Input array
    int h[Lh] = { 10 }; // Impulse array

    // Fill the arrays

    int acc = 0;

    for (int i = 0; i < REP; i++) {

        auto start = std::chrono::system_clock::now();

        for (int i = 0; i < Ly; i++) {
            for (int j = 0; j < Lh; j++) {
                y[i] += h[j] * x[i+j];
            }
        }

        auto end = std::chrono::system_clock::now();
        auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

        acc += elapsed.count();

    }

    acc /= REP;

    std::cout << "### TIME ELAPSED ###" << std::endl;
    std::cout << " > " << acc << " ms" << std::endl << std::endl;

    return EXIT_SUCCESS;
}
