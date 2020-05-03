import matlab.engine
import matlabEngineFunctions
from scipy.io import loadmat
import math
import os

##############Change the working directory of the system to the script's directory###############
absolutePath = os.path.abspath(__file__)
directoryName = os.path.dirname(absolutePath)
os.chdir(directoryName)


##########Starting matlab engine ###################
print("starting matlab engine...\n")
eng = matlab.engine.start_matlab() #starting matlab engine to handle the computations


##############loading a previously saved feature matrix#################
featureMatrixDir = '.\Data\Pat1.mat' #directory of the feature matrix to be loaded
sudoPatient = loadmat(featureMatrixDir) #loading the feature featureMatrix
featureMatrix = sudoPatient["Data"] #extracting the feature matrix from the file
Nwindows, Nfeatures = featureMatrix.shape #extracting the size of the feature feature Matrix
featureMatrix = featureMatrix.tolist() #converting the numby array into a list

discriminativeFeatures = [0,1,2,3,4,5,6,7,8] #indices for the discriminative features (arbitrary)

windowIter = 0


############Predicting the output###################
while(windowIter < Nwindows):
    print("processing window {0}\n".format(windowIter))
    observation = [featureMatrix[windowIter][col] for col in discriminativeFeatures] #extract a single observation
    observation = matlab.double(observation) #convert into matlab matrix of type double
    result = eng.predictionOutput(observation) #send the observation to be processed by matlab engine
    print("output of window {0} is {1} \n".format(windowIter, result))
    windowIter = windowIter + 1
