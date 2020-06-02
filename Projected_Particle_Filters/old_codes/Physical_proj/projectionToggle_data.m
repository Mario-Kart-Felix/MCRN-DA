function [q_data] = projectionToggle_data(DataModelProjection,Model_Dimension,Ur,p)
% Type of projection for the Data Models
if DataModelProjection == 0
    q_data = eye(Model_Dimension); %identity matrix
%     PinvH=
elseif DataModelProjection == 1
    q_data = getpod(Ur,p);
elseif DataModelProjection == 2
    q_data = getDMD( Ur,p );
% elseif DataModelProjection == 3
%    [q_data,~] = getausproj(Model_Dimension,p,Fmod,t,est,h,q,LE);
end

