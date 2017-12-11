# -*- coding: utf-8 -*-
"""
Created on Wed Dec  6 00:07:54 2017

@author: Mohsen.B
"""

from scipy.io import loadmat
import numpy as np

#data = mat.get('csi')
#a = np.array(data).ravel()
#A = np.vstack([a, a])

# data loading
for i in range(17):
    for j in range(3):
        for k in range(20):
            mat = loadmat('room1_data/LOC'+ str(i+1) +'/'+ str(j+1) +'_csi'+ str(k+1) +'.mat')
            InData = mat.get('csi')
            InDataR = np.array(InData).ravel()
            if i == 0 and j == 0 and k == 0:
                x = InDataR
                y = i+1;
            else :
                x = np.vstack([x, InDataR])
                y = np.vstack([y, i+1])
                
# Feature Scaling
from sklearn.preprocessing import MinMaxScaler
sc = MinMaxScaler(feature_range = (0, 1))
x = np.abs(x)
x = sc.fit_transform(x)

# Creating categorical output
from keras.utils.np_utils import to_categorical
y_cat = to_categorical(y, num_classes=None)
y_cat = y_cat[:, 1:]
# Train and test split
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(
    x, y_cat, test_size=0.15, random_state=42)
    

import keras
from keras.wrappers.scikit_learn import KerasClassifier
from sklearn.model_selection import cross_val_score
from keras.models import Sequential
from keras.layers import Dense

def build_classifier():
    # Initialising the ANN
    classifier = Sequential()
    # Adding the input layer and the first hidden layer
    classifier.add(Dense(units = 45, kernel_initializer = 'uniform', activation = 'relu', input_dim = 90))
    # Adding the second hidden layer
    classifier.add(Dense(units = 45, kernel_initializer = 'uniform', activation = 'relu'))
    # Adding the third hidden layer
    classifier.add(Dense(units = 30, kernel_initializer = 'uniform', activation = 'relu'))
    # Adding the 4th hidden layer
    classifier.add(Dense(units = 17, kernel_initializer = 'uniform', activation = 'relu'))
    # Adding the output layer
    classifier.add(Dense(units = 17, kernel_initializer = 'uniform', activation = 'sigmoid'))
    # Compiling the ANN
    classifier.compile(optimizer = 'adam', loss = 'categorical_crossentropy', metrics = ['accuracy'])
#    # Fitting the ANN to the Training set
#    classifier.fit(X_train, y_train, batch_size = 5, epochs = 200)
    return classifier

# Predicting the Test set results
classifier = KerasClassifier(build_fn = build_classifier, batch_size = 5, epochs = 300)
accuracies = cross_val_score(estimator = classifier, X = x, y = y_cat, cv = 10)
mean = accuracies.mean()
variance = accuracies.std()
print('mean = '+ str(mean) + '    var : ' +str(variance))

# Predicting the Test set results
y_pred = classifier.predict(X_test)
y_pred = (y_pred > 0.5)

# Making the Confusion Matrix
from sklearn.metrics import accuracy_score
print(accuracy_score(y_test, y_pred))

from sklearn.metrics import classification_report
print(classification_report(y_test, y_pred))

