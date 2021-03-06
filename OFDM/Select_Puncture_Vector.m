function [Puncture_vector] = Select_Puncture_Vector(Coding_rate)
% Based on the given coding rate in the main function, this function
% assigns the puncturing vector to acheive the higher rate from rate 1/2
% convolutional coding.
switch Coding_rate
    case 1/2
        Puncture_vector= [1 1 1 1 1 1];
    case 3/4
        Puncture_vector= [1 1 0 1 1 0];
end