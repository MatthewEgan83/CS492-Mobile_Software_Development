# wasteagram

A Flutter project.

## Project Description

This project is a model of a mobile application for a coffee shop where employees can document food wasted at the end of the day.
This is accomplished with "posts" containing photos taken of the items, the number of leftover items, the date the photo was taken,
and the location of the device when the post was created. The application also displays a list of all previous posts that have been created. 

## Project Walkthrough

The application starts by either loading the list of items already catalouged, or a spinning wheel if no items have been logged.  The user can then tap the "Add New Waste Button".  This takes the user to a screen where they can access the camera by tapping the "Take Photo" button.  This accesses the camera and the usre can take a photo. After the photo is taken, the user can tap "Post Photo", and will be taken to a screen there they can enter the number of items in the photo to log.  Then going back to the home screen by tapping the back arrow at the top, the new entry will be logged in the list, and the number of items recorded will be displayed at the top.  Tapping on the individual post will then take the user to a new page with the photo and details of the post, with the date, photo, number of items in the post, and the latitude and longitude of the post.

To view a simulation of the application on an emulator, play the mp4 file located in the directory.  
