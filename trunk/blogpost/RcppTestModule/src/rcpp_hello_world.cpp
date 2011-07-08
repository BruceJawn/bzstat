//rcpp_hello_world.cpp
#include "rcpp_hello_world.h"

using namespace Rcpp;

double norm(double x, double y){
return sqrt(x*x+y*y);
}

RCPP_MODULE(mod){
 function("norm", 
	      &norm,
		  List::create( _["x"] = 0.0, _["y"] = 0.0),
		  "Provides a simple vector norm");
}
