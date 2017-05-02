% Reading Digital Inputs from EPOS2 Controller to
% interpret Encoder Counts from a secondary Encoder


% Initiates communication with EPOS2 Controller
TAK = OpenCommunication;

% Check Error
if ( GetErrorState(TAK, 1) )
    ClearErrorState(TAK, 1);
end

%Set EncoderCounts to zero
EncoderCounts = 0;

%Each value is a 16 bit decimal relating to states of input pins 7 and 8
LL = 0;
HL = 32768;
LH = 16384;
HH = 49152;

%Increment or Decrement EncoderCounts based on GetAllDigitalInputs function
while (EncoderCounts < 1000)
	InputA = GetAllDigitalInputs(TAK, 1);
    InputB = GetAllDigitalInputs(TAK, 1);
    
    if     ((InputA == LL) && (InputB == HL))
        EncoderCounts = EncoderCounts + 1;
    elseif ((InputA == HL) && (InputB == HH))
        EncoderCounts = EncoderCounts + 1;
    elseif ((InputA == HH) && (InputB == LH))
        EncoderCounts = EncoderCounts + 1;
    elseif ((InputA == LH) && (InputB == LL))
        EncoderCounts = EncoderCounts + 1;
    elseif ((InputA == LL) && (InputB == LH))
        EncoderCounts = EncoderCounts - 1;
    elseif ((InputA == LH) && (InputB == HH))
        EncoderCounts = EncoderCounts - 1;
    elseif ((InputA == HH) && (InputB == HL))
        EncoderCounts = EncoderCounts - 1;
    elseif ((InputA == HL) && (InputB == LL))
        EncoderCounts = EncoderCounts - 1;
    end
    
    EncoderCounts
    
end

% Close Communications
CloseCommunication(TAK);