#include <assert.h>
#include <stdio.h>

// Find the upper bound of a value inside an array sorted in ascending order
int ub_asc(double val, double *arr, int first, int length) {

    int half, mid;

    while (length > 0) {
        half = length >> 1;
        mid = first;
        mid += half;
        if (arr[mid] < val) {
            first = mid;
            ++first;
            length -= half + 1;
        }
        else
            length = half;
    }

    return(first);
}

// Find the lower bound of a value inside an array sorted in ascending order
int lb_asc(double val, double *arr, int first, int length) {
    
    int half, mid;
    
    if (val < arr[first])
	    first += length;
	else
    	while (length > 0) {
	    	if (length == 1) {
		    	if (val >= arr[first])
			    	break;
		    	first += length;
		    	break;
			}
	    	if (length == 2) {
		    	if (val >= arr[first + 1]) {
			    	++first;
			    	break;
				}
		    	if (val >= arr[first])
			    	break;
		    	first += length;
		    	break;
			}
		    	
        	half = length >> 1;
        	mid = first + half;
        	if (val < arr[mid])
            	length = half;
        	else {
            	first = mid;
            	length -= half;
        	}
    	}

    return first;
}

int main(int argc, char* argv[]) {

	// Array in ascending order
	double asc_arr_1[] = {1.0, 6.0, 9.0, 16.0, 32.0, 45.0, 78.0, 100.0};
	double asc_arr_2[] = {5.0, 10.0};
    double asc_arr_3[] = {286.1456, 287.1488, 288.1514};

	assert(ub_asc(101.0, asc_arr_1, 0, 8) == 8);
	assert(ub_asc(80.0,  asc_arr_1, 0, 8) == 7);
	assert(ub_asc(78.0,  asc_arr_1, 0, 8) == 6);
	assert(ub_asc(100.0, asc_arr_1, 0, 8) == 7);
	assert(ub_asc(77.0,  asc_arr_1, 0, 8) == 6);
	assert(ub_asc(5.0,   asc_arr_1, 0, 8) == 1);
	assert(ub_asc(1.0,   asc_arr_1, 0, 8) == 0);
	assert(ub_asc(0.0,   asc_arr_1, 0, 8) == 0);

	assert(ub_asc(10.0,  asc_arr_2, 0, 2) == 1);
	assert(ub_asc(10.1,  asc_arr_2, 0, 2) == 2);
	assert(ub_asc(9.0,   asc_arr_2, 0, 2) == 1);
	assert(ub_asc(5.1,   asc_arr_2, 0, 2) == 1);
	assert(ub_asc(5.0,   asc_arr_2, 0, 2) == 0);
	assert(ub_asc(4.9,   asc_arr_2, 0, 2) == 0);
	assert(ub_asc(0.0,   asc_arr_2, 0, 2) == 0);

	assert(ub_asc(201.0918, asc_arr_3, 0, 3) == 0);
	assert(ub_asc(286.145, asc_arr_3, 0, 3) == 0);
	assert(ub_asc(286.1456, asc_arr_3, 0, 3) == 0);
	assert(ub_asc(286.146, asc_arr_3, 0, 3) == 1);
	assert(ub_asc(287.1488, asc_arr_3, 0, 3) == 1);
	assert(ub_asc(287.1489, asc_arr_3, 0, 3) == 2);
	assert(ub_asc(288.1514, asc_arr_3, 0, 3) == 2);
	assert(ub_asc(289.0, asc_arr_3, 0, 3) == 3);

	assert(lb_asc(101.0, asc_arr_1, 0, 8) == 7);
	assert(lb_asc(80.0,  asc_arr_1, 0, 8) == 6);
	assert(lb_asc(78.0,  asc_arr_1, 0, 8) == 6);
	assert(lb_asc(100.0, asc_arr_1, 0, 8) == 7);
	assert(lb_asc(77.0,  asc_arr_1, 0, 8) == 5);
	assert(lb_asc(5.0,   asc_arr_1, 0, 8) == 0);
	assert(lb_asc(1.0,   asc_arr_1, 0, 8) == 0);
	assert(lb_asc(0.0,   asc_arr_1, 0, 8) == 8);

	assert(lb_asc(10.0,  asc_arr_2, 0, 2) == 1);
	assert(lb_asc(11.0,  asc_arr_2, 0, 2) == 1);
	assert(lb_asc(9.0,   asc_arr_2, 0, 2) == 0);
	assert(lb_asc(5.0,   asc_arr_2, 0, 2) == 0);
	assert(lb_asc(4.0,   asc_arr_2, 0, 2) == 2);

	assert(lb_asc(201.0918, asc_arr_3, 0, 3) == 3);
	assert(lb_asc(286.145, asc_arr_3, 0, 3) == 3);
	assert(lb_asc(286.1456, asc_arr_3, 0, 3) == 0);
	assert(lb_asc(286.146, asc_arr_3, 0, 3) == 0);
	assert(lb_asc(287.1488, asc_arr_3, 0, 3) == 1);
	assert(lb_asc(287.1489, asc_arr_3, 0, 3) == 1);
	assert(lb_asc(288.1514, asc_arr_3, 0, 3) == 2);
	assert(lb_asc(289.0, asc_arr_3, 0, 3) == 2);

	return 0;
}
