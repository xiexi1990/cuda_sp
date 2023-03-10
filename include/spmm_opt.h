#ifndef SpMM_OPT_H
#define SpMM_OPT_H
#include "spmm_base.h"

class SpMMOpt : public SpMM
{
public:
    SpMMOpt(int *dev_out_ptr, int *dev_out_idx, int out_num_v, int out_num_e, int out_feat_in) : SpMM(dev_out_ptr, dev_out_idx, out_num_v, out_num_e, out_feat_in) {}
    SpMMOpt(CSR *g, int out_feat_in) : SpMM(g, out_feat_in) {
    }
    ~SpMMOpt()
    {
        
    }
    

    virtual void preprocess(float *vin, float *vout);

    virtual void run(float *vin, float *vout);
};
#endif