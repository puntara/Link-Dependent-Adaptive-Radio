% Morgan State University
% WiNetS lab, Electrical and Computer Engineering
% Version 1.3
% Last modified 0n July 14,2013
% This code simulates a communication system with
%   64 tone OFDM modulation.
%   4-16-64-256 QAM midularion.( b_p_sym= 2 for 4QAM, b_p_sym= 4 for 16-QAM, b_p_sym= 6 for 64QAM ,b_p_sym= 8 for 256QAM)
%   rate 1/2 and 3/4 convolutional coding.
%   SNR range 1:50 dB
%   different channel impulse responses; Channel is selected by Channel_no
%   parameter ( 0: AWGN, 1, 2, 3, 4, 5, 6) for multipath channel
%   Change the variable names to meaningful ones!

%close all
clear all
clc
randn('state',0)
rand('state',0)
Block_length=240;
No_fft_tones= 64 ;                       % FFT Size
Total_data_size=No_fft_tones*Block_length;                       %Total Number of bits

b_p_sym=8;                           % Bits per Symbol ( b_p_sym= 2 for 4QAM, b_p_sym= 4 for 1-QAM, b_p_sym= 8 for 64QAM) 
M=2^b_p_sym;                         % M-QAM size
NumMc=1;                      % Number of Montecarlo Runs
Eb_N0_dB = 1:30;
Coding_scheme = 0 ;          % Use '0' for no coding; '1' for convolutional coding; '2' for block coding
Coding_rate =1;%/2;%/2 %3/4%;%% 1/2;%%%
Coding_trellis = poly2trellis([7],[171 133]);    %Generator plynomial for coding
Cyclic_prefix_length = 4;         % 

Channel_no = 0  % Identify the simulation channel; Use "0" for AWGN channel;
Equalize = true;
Display_results = true;
for snr =  1:length(Eb_N0_dB)
    
    for Mc = 1 : NumMc
        disp([snr Mc])
        data=randi([0,1],1,Total_data_size); % Generate random data
        
        [Encoded_data] = Encoder (data,Coding_trellis,b_p_sym,Coding_scheme,Coding_rate); %Convolutional Coding
        
        [Modulated_Signal] = QAM_mod(Encoded_data,No_fft_tones,M);
        
        ofdm_symbols = OFDM_mod (Modulated_Signal,No_fft_tones);% Generate ofdm symbols
        
        ofdm_syms_CP = Add_Cyclic_Prefix(ofdm_symbols,No_fft_tones,Cyclic_prefix_length);
        
        [Received_ofdm_signal_CP,h] = Channel(ofdm_syms_CP,Eb_N0_dB(snr), Channel_no,b_p_sym);
        
        Received_ofdm_signal = Remove_Cyclic_Prefix(Received_ofdm_signal_CP,No_fft_tones,Block_length,b_p_sym,Coding_rate,Cyclic_prefix_length);
        
        Received_signal = OFDM_demod (Received_ofdm_signal,No_fft_tones);
        
        if Equalize;[Equalized_Signal,h_estimate,Cee(snr)] = Equalizer(Modulated_Signal, Received_signal,No_fft_tones,h);end
        if ~ Equalize;Equalized_Signal = Received_signal;end
            
        
        Demodulated_signal = QAM_demod(Equalized_Signal,M);
        
        Decoded_bits = Decoder(Demodulated_signal,Coding_trellis,b_p_sym,Coding_scheme,Coding_rate);
        
        [dummy, ser(Mc)] = biterr(data,Decoded_bits); % Check bit error rate with coding
        
    end % of MC loop
    
    SER(snr) = sum(ser)/NumMc;
        
end  % Of SNR loop

Show_results          % Displays BER curve if Display_results flag is set to true;


