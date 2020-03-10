OFDM LDAR code V1.0
Developed in WiNetS lab, Morgan State University, Baltimore, MD.
Last modified on : July 8,2013
Last modified by : Tara 

This folder contains the main driver and 9 functions. To run this OFDM simulation software run the main file:


 "Main_OFDM_code.m"

Functions that are called by the main code are listed below:


Encoder:
	This function changes the transmitted bits from binary to decimal followed byViterbi encoding.
	Coding_scheme identifies the mode for coding.
   		'0' for no coding
   		'1' for convolutional coding
   		'2' for BCH coding
QAM_mod:
	This function changes the data from serial to parallel which is followed
	by QAM modulation.

Add_Cyclic_Prefix:
	This function adds cyclic prefix to the transmitted signal to mitigate
	for ISI. 1/4 of the data field is folded back to the end of each packet

Decoder:
	This function changes the received bits from decimal to binary which is followed by Viterbi decoding.
	Coding_scheme identifies the mode for decoding. 
     		'0' for no decoding
     		'1' for Viterbi decoding
     		'2' for BCH decoing

OFDM:
	This function applies ifft at the transmitter to change the signal in to OFDM tones.


IOFDM:
	This function applies fft at the receicer end to remove the OFDM effects.



QAM_demod:
	This function demodulates the received signal and changes the demodulated
	signal from parallel to serial.


Remove_Cyclic_Prefix:
	This function changes the signal from serial to parallel and
	removes the cyclic prefix.


Transmit:
	This function transmits the signal through the channel h. Channel impulse
	response is defined in the main code. Measured AWGN is added with the specified SNR. 












