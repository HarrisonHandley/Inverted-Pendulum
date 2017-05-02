function res = GetAllDigitalInputs(handle, nodeid)
% This function reads the state of every Digital Input pin at once.
% It will out put a decimal value relating to the 16 bit chunch that
% Contains the values of each pin, 1 (high) or 0 (low) Read the EPOS2 
% Hardware Reference and Firmware Specification for more details.