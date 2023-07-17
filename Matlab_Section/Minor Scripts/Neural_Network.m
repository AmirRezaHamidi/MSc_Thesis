%% Resovling Environment
addpath("Functions")
close all; clear; clc

%% Parameter Initialization

Folder_to_Train = fullfile("Network_Data\1Minutes\");
Network_Data_Folder = Network_Address_Handler(Folder_to_Train);

%% Deep Convolutional Neural Network Construction

% Data Properties
Channel_Division = 3;

% Load Data Image
Network_Data = imageDatastore(Network_Data_Folder, ...
                              "IncludeSubfolders",true, ...
                              "LabelSource","foldernames");

Input_Size = size(imread(Network_Data.Files{1}));
Network_Data = shuffle(Network_Data);
[Train_Data, Validation_Data] = splitEachLabel(Network_Data, 0.9);

% Network Architecture
layers = [
    
    % input layer 
    imageInputLayer(Input_Size)

    % first layer
    convolution2dLayer(7, 96, "Stride", 2, "BiasLearnRateFactor", 20, ...
                                           "WeightLearnRateFactor", 20)
    reluLayer
    maxPooling2dLayer(2, "Stride", 2)

    % second layer
    convolution2dLayer(5, 32, "Stride", 2, "BiasLearnRateFactor", 20, ...
                                           "WeightLearnRateFactor", 20)
    reluLayer
    dropoutLayer(0.5)
    
    % third layer
    convolution2dLayer(3, 16, "Stride", 2, "BiasLearnRateFactor", 20, ...
                                           "WeightLearnRateFactor", 20)
    reluLayer
    maxPooling2dLayer(2, "Stride", 2)

    % fourth layer
    convolution2dLayer(3, 8, "Stride", 2, "BiasLearnRateFactor", 20, ...
                                          "WeightLearnRateFactor", 20)
    reluLayer

    % fifth layer
    fullyConnectedLayer(50, "BiasLearnRateFactor", 20, ...
                            "WeightLearnRateFactor", 20)
    reluLayer

    % sixth layer
    fullyConnectedLayer(32, "BiasLearnRateFactor", 20, ...
                            "WeightLearnRateFactor", 20)
    reluLayer

    % seventh layer
    fullyConnectedLayer(2, "BiasLearnRateFactor", 20, ...
                           "WeightLearnRateFactor", 20)
    softmaxLayer
    
    % output layer
    classificationLayer];

% Network Properties
Learning_Rate = 1e-4;
Number_Of_Epochs = 60;
Mini_Batch_Size = 73;
Validation_Frequency = floor(size(Train_Data.Files, 1) / Mini_Batch_Size);

% Training Options
options = trainingOptions("adam", ...
                          "InitialLearnRate", Learning_Rate, ...
                          "MaxEpochs", Number_Of_Epochs, ...
                          "MiniBatchSize", Mini_Batch_Size, ...
                          "ValidationFrequency", Validation_Frequency, ...
                          "ValidationData", Validation_Data, ...
                          "Plots","training-progress");

Message = "Do You Want to See the Network Information [y,N] ?";
See_Network = Asker(Message);

% Network summary
if See_Network =="y"

    analyzeNetwork(layers, TargetUsage="trainNetwork");
    clc

end

% Training the Network
CNNModel = trainNetwork(Train_Data, layers, options);
%% The End :)