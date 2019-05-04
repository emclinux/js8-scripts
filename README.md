# js8-scripts
`gcs` is a ruby script that gets the callsign and information about that callsign.
`js8gcs` runs the gcs script based on what callsign you have selected in js8call.

##Install (Ubuntu/Debian/RPi)
First install rubygems
`sudo apt-get install ruby ruby-dev`

Install needed gems for gcs
`gem install nokogiri notify dx-grid`

Make scripts executable
`chmod +x gcs; chmod +x js8gcs`

##Usage (GCS)
For just callsign information from hamqth.com:
`./gcs CALLSIGN`
example
```./gcs w1aw
Callsign: W1AW
Name     : ARRL HQ OPERATORS CLUB
QTH      : Newington
Country  : United States
Grid     : FN31
State    : CT

Worked before (JS8): No

map at: http://maps.google.com?q=NewingtonCT
```

If you would like to have this information in a desktop notification add a -n to the command
`./gcs -n w1aw`

If you would like to have distance added to the output add a -g and your grid square
```./gcs w1aw -g em79
Callsign: W1AW
Name     : ARRL HQ OPERATORS CLUB
QTH      : Newington
Country  : United States
Grid     : FN31 (829 Miles)
State    : CT

Worked before (JS8): No

map at: http://maps.google.com?q=NewingtonCT```

If you would like to open a webpage like https://qrz.com/db or http://www.levinecentral.com/ham/grid_square.php
`./gcs -w w1aw`

Or you can choose one or all of them.  For example here is all options
`./gcs w1aw -n -w -g em79`

##Usage (JS8GCS)
First start js8call.  Once js8call is open, in a terminal window start js8gcs
`./js8gcs`

This will at first display nothing, In js8call select any callsign and within 15 seconds a notification will open and a webpage will open.  If you would like to change this, for example have it not open a webpage then edit the following line in the js8gcs scripts

`        puts `#{gcs_path}/gcs -n #{current_cs} -g #{my_grid} -w``
