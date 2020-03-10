function [Demodulated_signal] = QAM_demod(Received_signal,M)
%This function demodulates the received signal and changes the demodulated
%signal from parallel to serial.

    Received_signal = Received_signal*sqrt((2/3)*(M-1));
         

z = qamdemod(Received_signal,M);

Demodulated_signal = reshape(z.',1,numel(z));
