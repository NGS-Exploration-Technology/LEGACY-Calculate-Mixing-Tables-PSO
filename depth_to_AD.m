function AD_cts_out=depth_to_AD_vectorized(Depth, Depth_to_AD_Table)
%function AD_cts_out=depth_to_AD_alg(Depth, Depth_Table)
%   Test function to test fast lookup table algorithm
%   Function uses a lookup table and interpolation to find AD Cts
%
%Inputs:
%   Depth = Ocean Depth in Meters
%   Depth_Table = Lookup table of AD Cts
%
%Outputs
%   AD_Cts = AD_Cts associated with Depth.
%
%National Geographic Society
%April 17, 2015
%Eric Berkenpas

%Calculate Real
Real = floor(Depth);

%Calculate Fraction
Fraction = Depth-Real;

%Get First AD Cts
Table_Point1 = Depth_to_AD_Table(Real+1)';

%Get Second AD Cts
Table_Point2 = Depth_to_AD_Table(Real+2)';

%Interpolate Between Fraction
Interpolated_AD = (Table_Point2-Table_Point1).*Fraction;

%Add Interpolated Counts to First AD Cts
AD_cts_out = floor(Table_Point1+Interpolated_AD);