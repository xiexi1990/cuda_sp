#include "gtest/gtest.h"
#include "util.h"
#include "data.h"

int main(int argc, char** argv)
{
    argParse(argc, argv);
    int* tmp1 = NULL;
    int* tmp2 = NULL;
    int* tmp3 = NULL;
    load_graph(inputgraph, kNumV, kNumE, tmp1, tmp2, tmp3);
    checkCudaErrors(cudaMalloc2((void**)&gptr, (kNumV + 1) * sizeof(int)));
    checkCudaErrors(cudaMalloc2((void**)&gidx, kNumE * sizeof(int)));
    checkCudaErrors(cudaMalloc2((void**)&gcoo_row, kNumE * sizeof(int)));
    checkCudaErrors(cudaMemcpy(gptr, tmp1, sizeof(int) * (kNumV + 1), cudaMemcpyHostToDevice));
    checkCudaErrors(cudaMemcpy(gidx, tmp2, sizeof(int) * kNumE, cudaMemcpyHostToDevice));
    checkCudaErrors(cudaMemcpy(gcoo_row, tmp3, sizeof(int) * kNumE, cudaMemcpyHostToDevice));
    registerPtr(gptr);
    registerPtr(gidx);
    registerPtr(gcoo_row);
    dbg(kLen);

    curandCreateGenerator(&kCuRand, CURAND_RNG_PSEUDO_DEFAULT);
    curandSetPseudoRandomGeneratorSeed(kCuRand, 123ULL);

    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
    
}