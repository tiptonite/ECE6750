#include <iostream>
#include <chrono>

#define Lh 1000 // impulse
#define Lx 100000 // input

int main() {

    int Lz = Lx + 2*(Lh-1); // Length of padded input
    int Ly = Lh + Lx - 1; // Length of output

    int y[Ly] = { 0 }; // Output array
    int x[Lz] = { 0 }; // Input array
    int h[Lh] = { 0 }; // Impulse array

    // Fill the arrays

    auto start = std::chrono::system_clock::now();

    for (int i = 0; i < Ly; i++) {
        for (int j = 0; j < Lh; j++) {
            y[i] += h[j] * x[i+j];
        }
    }

    auto end = std::chrono::system_clock::now();
    auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);

    std::cout << "### TIME ELAPSED ###" << std::endl;
    std::cout << " > " << elapsed.count() << " ms" << std::endl << std::endl;

    return EXIT_SUCCESS;
}
