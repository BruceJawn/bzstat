//To compile:
//cd('D:\Octave\yourtestcodefolder\'); 
//mkoctfile octtest.cc;
//test Octave code: 
//octtest([1,2;3,4],[5,6;7,8])
//Bruce Zhou
//http://bzstat.wordpress.com
//2014, June, 29

#include <octave/oct.h>
#include <octave/parse.h>

double trace(Matrix mx)
{
	double value = 0.0;
	dim_vector dv = mx.dims();
	int p = dv(0);
	for(int i=0;i<p;i++)//starts from 0 here!
	{
		value += mx(i,i); 
	}
	return value;
}
double sumall(Matrix mx)
{
	double value = 0.0;
	dim_vector dv = mx.dims();
	int pr = dv(0);
	int pc = dv(1);
	for (int ir1 = 0 ; ir1 < pr ; ir1++)  
		for (int ic1 = 0 ; ic1 < pc ; ic1++) 
		{
			value+=mx(ir1,ic1);
		}
		return value;
}

DEFUN_DLD (octtest, args, nargout, "test of octave oct")
{
	//print_usage ();

	//get input length
	int nargin = args.length ();

	//get matrix input
	Matrix A(args(0).matrix_value());
	Matrix B(args(1).matrix_value());
	//return octave_value (A * B);

	//get scalar input
	//double args2=args(2).scalar_value();

	//Matrix define
	dim_vector dv (2);
	dv(0) = 2; dv(1) = 4;
	Matrix myMx1 (dv);

	//or
	Matrix myMx2(2, 4);

	//get Matrix dimension:
	dim_vector dv2=myMx2.dims();
	//nrows = dv(0);
	//ncols = dv(1);

	//set/get Matrix element:
	myMx1(1,2) = 1;
	myMx1(1,2) = 1;

	//Matrix operations:
	Matrix Mx_p = A+B;
	Matrix Mx_m = A-B;
	Matrix Mx_t = A * B;
	Matrix Mx_d = A * B.inverse();
	Matrix Mx_at = A.transpose();

	//Get Matrix Rows/Columns
	int i=1;
	int j=2;
	RowVector Mx_i=myMx1.row(i);
	ColumnVector  Mx_j=myMx1.column(j);

	//Row Sums:
	RowVector Mxsum = (myMx1.sum()).row(0);

	//Matrices Combination:
	int rows, columns, columns2;
	// initialize row and column values to something
	rows = 2;
	columns = 2;
	columns2 = 4;
	Matrix A2(rows,columns);
	Matrix B2(rows,columns2);
	// initialize the contents of A and B to something
	//A2.resize(rows,columns+columns2); 
	A2.insert(B2, 0, columns);
	feval ("disp", octave_value(A2), nargout);

	//call Octave function
	double stat = 0.0;
	octave_value_list ipv =  feval ("normcdf", octave_value(stat), nargout);
	feval ("disp", octave_value(ipv(0).scalar_value()), nargout);

	double tr = trace(A);
	double sm = sumall(A);

	return octave_value_list ();
}