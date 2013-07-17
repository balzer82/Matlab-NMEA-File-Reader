%% GPS Messungen einlesen und Stats plotten
% CC-BY-SA 2.0 Paul Balzer
%
f = dir('*.log');

for i = 1:length(f)

    filename = f(i,1).name;

    
    [hour, minute, second, velocity, numsats, height, lat_decimal, long_decimal, quality] = readGPS(filename);

    GPStime = (hour*3600+minute*60+second)*1000; %Umrechnung von UTC in ms
    % Daten da löschen, wo keine Zeit vorhanden war
    hour(GPStime==0)=[];
    minute(GPStime==0)=[];
    second(GPStime==0)=[];
    velocity(GPStime==0)=[];
    numsats(GPStime==0)=[];
    height(GPStime==0)=[];
    lat_decimal(GPStime==0)=[];
    long_decimal(GPStime==0)=[];
    quality(GPStime==0)=[];
    GPStime(GPStime==0)=[];
    GPStime = GPStime-GPStime(1); % alles auf Messbeginn reduzieren

    disp(['Lese Datei ' filename])
  

% NumSat Plot
    figure(1)
    set(gcf,'Position',[100 100 848 480],'Visible','off',...
        'PaperpositionMode','Auto','NextPlot','replacechildren')
    stairs(GPStime/1000,numsats,'Color',[0 0 .9],'Linewidth',3)
    hold on
    stairs(GPStime/1000,quality,'Color',[0 .8 0])
    line(GPStime/1000,velocity,'Color',[0.7 0 0])
    grid on
    xlabel('Zeit [s]')
    ylim([0 12])
    set(gca,'Ytick',[0:1:12])
    title([{'Anzahl empfangener Satellitensignale'};{filename}])
    legend('Anzahl Satelliten','NMEA Quality Flag','Geschwindigkeit [km/h]')
    print(gcf,'-dpng','-r300',strrep(filename,'.log','-NumSats.png'))

% Flags Plot
    figure(2)
    set(gcf,'Position',[100 100 848 480],'Visible','off',...
        'PaperpositionMode','Auto','NextPlot','replacechildren')
    stem3(lat_decimal(velocity>0),long_decimal(velocity>0),velocity(velocity>0),...
        'fill','MarkerSize',3,'MarkerFaceColor',[0 0 1],'Color',[.8 .8 .8]);
    hold on
 
    view(45,60)
    title([{'Gefahrener Kurs und Geschwindigkeit'};{filename}])
    %Kurs überlagern
    line(lat_decimal(velocity>0),long_decimal(velocity>0),'LineWidth',4,'color','black')
    set(gca,'XTicklabel',[],'YTicklabel',[]);
    xlabel('Lat'), ylabel('Long'), zlabel('Geschwindigkeit [km/h]')
    grid on
    box off
    print(gcf,'-dpng','-r300',strrep(filename,'.log','-Course.png'))

end
