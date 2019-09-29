static class CanvasModes {
  static final int GAVG = 0;
  static final int LUMA = 1;
}

static class ConvModes {
  static final int IDENTITY = -1;
  static final int EDGE_DETECT1 = 0;
  static final int EDGE_DETECT2 = 1;
  static final int SHARPEN = 2;
}

static class ConvMask {
  static final int CM_SIZE = 3;
  static final float[][] SHARPEN = { { -1, -1, -1 }, 
                                     { -1,  9, -1 }, 
                                     { -1, -1, -1 } };
                                          
  static final float[][] EDGE_DETECT1 = { { -1, -1, -1 }, 
                                          { -1,  8, -1 }, 
                                          { -1, -1, -1 } };
 
  static final float[][] EDGE_DETECT2 = { {  1,  0, -1 }, 
                                          {  0,  0,  0 }, 
                                          { -1,  0,  1 } };

  static final float[][] IDENTITY = { {  0,  0,  0 }, 
                                      {  0,  1,  0 }, 
                                      {  0,  0,  0 } };
                                      
  static float[][] mask(int id) {
     switch(id) {
       case ConvModes.EDGE_DETECT1:
       return ConvMask.EDGE_DETECT1;
       case ConvModes.EDGE_DETECT2:
       return ConvMask.EDGE_DETECT2;
       case ConvModes.SHARPEN:
       return ConvMask.SHARPEN;
       default:
       return ConvMask.IDENTITY;
     }
  }
  
  static int size(int id) {
    switch(id) {
      // TODO:
      default:
      return 3;
    }
  }
}
