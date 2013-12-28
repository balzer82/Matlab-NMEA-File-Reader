Matlab-NMEA-File-Reader
=======================

Reads [NMEA](http://de.wikipedia.org/wiki/NMEA_0183 "NMEA bei Wikipedia") coded GPS Data from .log File to Matlab and creates Plot of stats and course driven.



Input file (NMEA Example)
-------------------------
```
$GPGGA,080231.000,5102.0344,N,01344.3717,E,1,09,1.0,115.6,M,45.8,M,,0000*53
$GPRMC,080231.000,A,5102.0344,N,01344.3717,E,0.00,195.19,100712,,,A*63
$GPVTG,195.19,T,,M,0.00,N,0.0,K,A*08
$GPGGA,080232.000,5102.0344,N,01344.3717,E,1,09,1.0,115.6,M,45.8,M,,0000*50
$GPGSA,A,3,05,15,19,28,27,18,26,07,08,,,,1.7,1.0,1.3*33
$GPGSV,3,1,12,26,79,297,39,28,61,130,41,08,51,063,36,05,36,207,41*72
$GPGSV,3,2,12,15,35,298,37,27,21,258,39,07,11,071,30,19,10,034,42*77
$GPGSV,3,3,12,21,06,306,24,18,06,327,40,09,04,255,,17,00,139,*73
$GPRMC,080232.000,A,5102.0344,N,01344.3717,E,0.00,195.19,100712,,,A*60
$GPVTG,195.19,T,,M,0.00,N,0.0,K,A*08
$GPGGA,080233.000,5102.0344,N,01344.3717,E,1,09,1.0,115.6,M,45.8,M,,0000*51
$GPRMC,080233.000,A,5102.0344,N,01344.3717,E,0.00,195.19,100712,,,A*61
$GPVTG,195.19,T,,M,0.00,N,0.0,K,A*08
```

Output Course and Stat Image
----------------------------

![Course und Geschwindigkeit](https://raw.github.com/balzer82/Matlab-NMEA-File-Reader/master/GPS-Log-Messung1-Course.png  "Geschwindigkeit und gefahrener Kurs")

![Stats](https://raw.github.com/balzer82/Matlab-NMEA-File-Reader/master/GPS-Log-Messung1-NumSats.png  "Stats der Messung")
