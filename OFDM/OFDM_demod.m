function[Received_signal] = OFDM_demod (Received_ofdm_signal,No_fft_tones)
%This function applies fft at the receicer end to remove the OFDM effects.
       for i = 1:size(Received_ofdm_signal,1)
           Received_signal(i,:) = fft(Received_ofdm_signal(i,:),No_fft_tones);
        end
        