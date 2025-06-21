#include <immintrin.h>
#include <iostream>
#include <chrono>
#include <array>
#include <random>

float *generate_random_floats() {
    // Create a random-number engine seeded with a nondeterministic value
    static std::mt19937 engine{std::random_device{}()};
    // Define a distribution in [0.0, 1.0)
    std::uniform_real_distribution<float> dist(0.0f, 1.0f);

		float *farr = new float[4096];
    /* std::array<float, 1000> result; */
		for (int i = 0; i < 4096; i++) {
			farr[i] = dist(engine);
		}
    /* for (auto &x : result) { */
    /*     x = dist(engine); */
    /* } */
    return farr;
}

float normal_add(const float *farr) {
	float sum = 0.;
	for (int i = 0; i < 4096; i++) {
		sum += farr[i];
	}
	return sum;
}

float intrin_add(const float *farr) {
	// 1) Accumulator vector, initialized to zero:
	__m256 vsum = _mm256_setzero_ps();

	// 2) Process 8 floats at a time:
	for (int i = 0; i < 4096; i += 8) {
			__m256 v = _mm256_loadu_ps(farr + i);      // load 8 floats
			vsum     = _mm256_add_ps(vsum, v);         // sum‑accumulate
	}

	// 3) Horizontal‑add the 8 lanes of vsum into one float:
	alignas(32) float temp[8];
	_mm256_store_ps(temp, vsum);

	float sum = 0.0f;
	for (int j = 0; j < 8; ++j) {
			sum += temp[j];
	}
	return sum;

	/* float sum256 = 0.; */
	/* for (int i = 0; i < 4096; i+=8) { */
	/* 	sum256 = _mm256_add_ps(A256, sum256) */
	/* } */
	/* return sum256; */
}

int main() {
	float *farr = generate_random_floats();
	auto t1 = std::chrono::high_resolution_clock::now();
	float sum = normal_add(farr);
	auto t2 = std::chrono::high_resolution_clock::now();
	std::chrono::duration<double, std::milli> dt_ms = t2 - t1;
	std::cout << "sum: " << sum << std::endl;
	std::cout << "dt_milli: " << dt_ms.count() << std::endl;

	t1 = std::chrono::high_resolution_clock::now();
	sum = intrin_add(farr);
	t2 = std::chrono::high_resolution_clock::now();
	dt_ms = t2 - t1;
	std::cout << "sum: " << sum << std::endl;
	std::cout << "dt_milli: " << dt_ms.count() << std::endl;

	delete[] farr;
	return 0;
}
