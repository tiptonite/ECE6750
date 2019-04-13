#include <iostream>
#include <chrono>
#include <fstream>

#define Lh  128  // impulse
#define Lx  1000 // input
#define REP 1000 // number of repetitions

int main() {

    int Lz = Lx + 2*(Lh-1); // length of padded input
    int Ly = Lh + Lx - 1; // length of output

    int y[Ly] = { 0 }; // output array
    int x[Lz] = { 0 }; // input array
    int h[Lh] = { 0 }; // impulse array
    int t[REP]; // time array

    // Fill the arrays
    for (int i = (Lh - 1); i < (Lx + Lh - 1); i++)
        x[i] = 1;

    for (int i = 0; i < Lh; i++)
        h[i] = 1;

    int acc = 0; // accumulator for average

    for (int i = 0; i < REP; i++) {

        for (int i = 0; i < Ly; i++)
            y[i] = 0;

        auto start = std::chrono::system_clock::now(); // start timer

        // Convolution
        for (int i = 0; i < Ly; i++)
            for (int j = 0; j < Lh; j++)
                y[i] += h[j] * x[i+j];

        auto end = std::chrono::system_clock::now(); // end timer
        auto elapsed = std::chrono::duration_cast<std::chrono::microseconds>(end - start);

        acc += elapsed.count();
        t[i] = elapsed.count();

    }

    std::ofstream fout("conv.txt");

    for (int i = 0; i < Ly; i++)
        fout << y[i] << std::endl;

    fout.close();

    fout.open("time.txt");

    for (int i = 0; i < REP; i++)
        fout << t[i] << std::endl;

    fout.close();

    acc /= REP;

    std::cout << "### TIME ELAPSED ###" << std::endl;
    std::cout << " > " << acc << " us" << std::endl << std::endl;

    return EXIT_SUCCESS;
}
