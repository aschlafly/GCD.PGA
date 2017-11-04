---
title: "CodeBook.md"
author: "Aaron Schlafly"
date: "10/28/2017"
output: html_document
---

## Data codebook

Apologies to the user, but the varaible names represent complex concepts, and don't lend themselves to easy summarization as column labels. This codebook is intended to help understand what the readings represent.  

** subject ** contains the number to identify the subject being measured. Users are anonymous, so simply labled with integers.  
1-30 are the allowable indicators for the 30 subjects.  

** activity_code ** (character lables) correspond to the activity the subject was doing when measurements were taken. Possible values:  
1. Walking  
2. Walking upstairs  
3. Walking downstairs  
4. Sitting  
5. Standing  
6. Laying  

** mean and standard deviation of measurements **
This is best described by splitting the labels into constiuent pieces.

** first word (character) ** represents the time domain signal itself or the frequency domain signal.  
*"t" corresponds to time domain signal  
*"f" corresponds to frequency domain signal  

** second word ** determines whether what is being measured is the body's movement or, in the case of acceleration, whether it is the effect of gravity.  
*"Body" refers to a measurement of the body's movement  
*"Gravity" refers to the effect of gravity, in the case of acceleration  

** third word ** determines whether the measurement is from the phone's accelerometer or gyroscope. There are also Jerk accelerations and gyroscope readings.  
*"Acc" means that the accelerometer took the reading.  
*"AccJerk" means the Jerk reading corresponding to the accelerometer reading.  
*"Gyro" means that the gyroscope took the reading.  
*"GyroJerk" means the Jerk reading corresponding to the gyroscope reading.  

** fourth word ** determines whether the mean or the standard deviation of the readings is in the column.  
*"mean" means mean is being measured.  
*"std" means standard deviation is being measured.  

** X, Y, or Z ** are used in the case of three-dimesional measurements.  
*"X" is used to measure the X-direction component of the measurement.  
*"Y" is used to measure the Y-direction component of the measurement.  
*"Z" is used to measure the Z-direction component of the measurement.  

## Transformation

The data were transformed by taking the mean of the relevant data, where "relevant" means for the rows with a given subject and a given activity. The mean was taken by using the mean() function with rm.na = TRUE.