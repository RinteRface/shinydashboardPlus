## Test environments
* local OS X install, R 3.4.4
* ubuntu 14.04 (on travis-ci), R 3.4.4

[![Build Status](https://travis-ci.org/DivadNojnarg/shinydashboardPlus.svg?branch=master)](https://travis-ci.org/DivadNojnarg/shinydashboardPlus)

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE:

*checking Rd line widths ... NOTE
 Rd file 'productList.Rd':
  \examples lines wider than 100 characters:
               src = "https://image.darty.com/hifi_video/televiseurs-led/grand_ecran_led/samsung_ue55mu9005_4k_uhd_s1703224306074A_140323143 ... [TRUNCATED]

 Rd file 'userList.Rd':
  \examples lines wider than 100 characters:
               src = "https://d33wubrfki0l68.cloudfront.net/071952491ec4a6a532a3f70ecfa2507af4d341f9/c167c/images/hex-dplyr.png", 

 Rd file 'widgetUserBox.Rd':
  \examples lines wider than 100 characters:
           backgroundUrl = "https://images.pexels.com/photos/531880/pexels-photo-531880.jpeg?auto=compress&cs=tinysrgb&h=350",

These lines will be truncated in the PDF manual.


It is not a crucial issue since it only concerns the size of url, that will be available
in the help section of R.