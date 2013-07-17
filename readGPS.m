function [hour, minute, second, velocity, numsats, height, lat_decimal, long_decimal, quality] = readGPS(Filename)
%% Ließt NMEA GPS Daten ein
% GPSdaten=readGPS(filename)
% GSPdaten ist eine Matrix mit folgendem Inhalt:
% 
% Definition: http://de.wikipedia.org/wiki/NMEA_0183

fid = fopen(Filename,'rt');

%nach den Zeilenvorschüben suchen, 10 ist der ASCII-Code für einen
%Zeilenvorschub
dateilange = nnz(fread(fid)==10);
disp(sprintf('Es werden ca. %d Zeilen eingelesen...',dateilange));

%Pointer wieder auf Beginn setzen
fseek(fid,0,'bof');

%Preallocation der Daten
zeile = 1;
GPS_data=zeros(dateilange,9);
hour = 0;
minute = 0;
second = 0;
UTC = 0;
lat_degree = 0;
lat_decimal = 0;
long_decimal = 0;
lat_A = '0';
long_A = '0';
velocity = 0;
course = 0;
numsats = 0;
height=0;
lat_decimal=0;
long_decimal=0;
quality = 0;

while ~feof(fid) % so lange Dateiende nicht erreicht ist
    line = fgetl(fid); % Zeile lesen
    if isempty(line) % wenn leere Zeile
        continue     % überspringen
    elseif strncmp(line,'$GPGGA',6) % wenn Zeile mit $GPRMC
      data = textscan(line,'%s%f%f%c%f%c%f%f%f%f',1,'delimiter',','); 
        % compute UTC(HHMMSS.SSS), Universal Time Coordinated 
        hour = floor(data{2}/10000); 
        minute = floor((data{2}-hour*10000)/100); 
        second = round(data{2}-floor(data{2}/100)*100); 
        UTC = strcat(num2str(hour),':',num2str(minute),':',num2str(second)); 

        %compute latitude(DDMM.MMM) and longitude(DDDMM.MMMM) 
        lat_degree = floor(data{3}/100); 
        lat_decimal = round((data{3}-lat_degree*100)/60*10^6)/10^6; 
        lat_A = strcat(num2str(lat_degree+lat_decimal),data{4}); 

        long_degree= floor(data{5}/100); 
        long_decimal = round((data{5}-long_degree*100)/60*10^6)/10^6; 
        long_A = strcat(num2str(long_degree+long_decimal),data{6});

        numsats = data{8};

        %GPS-Qualität:
        % 0 für ungültig
        % 1 für GPS fix
        % 2 für DGPS fix
        % 6 für geschätzt (nur bei NMEA-0183 ab Version 2.3)
        quality = data{7};

        %Höhe der Antenne über Geoid oder MSL (mean sea level)
        height = data{10};
        
    elseif strncmp(line,'$GPVTG',6) % wenn Zeile mit $GPRMC
        GPVTGdata = textscan(line,'%s%f%c%f%c%f%c%f%c',1,'delimiter',',');
        % compute velocity(km/h) and course 
        velocity = GPVTGdata{8}; 
        course = GPVTGdata{2}; 
    end
    GPS_data(zeile,:)=[hour, minute, second, velocity, numsats, height, lat_decimal, long_decimal, quality];
    zeile = zeile + 1; % eine Zeile weiter
end

fclose(fid); %schließen

hour = GPS_data(:,1);
minute = GPS_data(:,2);
second = GPS_data(:,3);
velocity = GPS_data(:,4);
numsats = GPS_data(:,5);
height = GPS_data(:,6);
lat_decimal = GPS_data(:,7);
long_decimal = GPS_data(:,8);
quality = GPS_data(:,9);