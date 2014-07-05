warning off;
% Suppose that initially we are in the cuurent folder containing all the
% data folds.
% Get the list of the text files in '1.1zuo':
load('operations.mat');
[leno,z] = size(operations);
if leno >= 2
for l=2:leno
    % Define the parameters needed to decide the interval of the data items
    % being selected:
    startdate = cell2mat(operations(l,1)); % Starting date - complete
    startyear = startdate(1:4); % Starting date - year
    startmonth = startdate(6:7); % Starting date - month
    startday = startdate(9:10); % Starting date - day
    starttime = cell2mat(operations(l,2));  % Starting time - complete
    starthour = starttime(1:2);  % Starting time - hour
    startminute = starttime(4:5);  % Starting time - minute
    startsecond = starttime(7:8);  % Starting time - second
    enddate = cell2mat(operations(l,3)); % Starting date - complete
    endyear = enddate(1:4); % Starting date - year
    endmonth = enddate(6:7); % Starting date - month
    endday = enddate(9:10); % Starting date - day
    endttime = cell2mat(operations(l,4));  % Starting time - complete
    endhour = endttime(1:2);  % Starting time - hour
    endminute = endttime(4:5);  % Starting time - minute
    endsecond = endttime(7:8);  % Starting time - second\
    startdateline = str2num(strcat(startyear,startmonth,startday));
    starttimeline = str2num(strcat(starthour,startminute,startsecond));
    enddateline = str2num(strcat(endyear,endmonth,endday));
    endtimeline = str2num(strcat(endhour,endminute,endsecond));
    surname = cell2mat(operations(l,6));
    directory11 = dir('.\sensor\');
    mkdir('.\sensor\figs');
    % For every txt file, get the values we want by the above parameters
    % and plot them out.
    for i = 1:length(directory11)
        date=[];
        time=[];
        temp=[];
        database=[];
        ini=1;
        fin=1;
        mn=0;
        len = length(directory11(i).name);
        name = strcat(directory11(i).name,'');
        if len>=4
            if length(strfind(name(len-3:len),'.txt')) == 1
                [date,time,temp]=textread(strcat('.\sensor\',name),'%s %s\t%s');
                database=[date time temp];
                ini=1;
                fin=1;
                for m = 1:length(database)
                    datadate = cell2mat(date(m));
                    datatime = cell2mat(time(m));
                    if length(datadate) == 10 && length(datatime) == 8
                    datayear = datadate(1:4);
                    datamonth = datadate(6:7);
                    dataday = datadate(9:10);
                    datahour = datatime(1:2);
                    dataminute = datatime(4:5);
                    datasecond = datatime(7:8);
                    datadateline = str2num(strcat(datayear,datamonth,dataday));
                    datatimeline = str2num(strcat(datahour,dataminute,datasecond));
                    if (datadateline == startdateline && datatimeline >= starttimeline) || (datadateline > startdateline)
                        ini = m;
                        break;
                    end
                    end
                end
                datadate=[];
                datatime=[];
                for n = 1:length(database)
                    datadate = cell2mat(date(n));
                    datatime = cell2mat(time(n));
                    if length(datadate) == 10 && length(datatime) == 8
                    datayear = datadate(1:4);
                    datamonth = datadate(6:7);
                    dataday = datadate(9:10);
                    datahour = datatime(1:2);
                    dataminute = datatime(4:5);
                    datasecond = datatime(7:8);
                    datadateline = str2num(strcat(datayear,datamonth,dataday));
                    datatimeline = str2num(strcat(datahour,dataminute,datasecond));
                    if (datadateline == enddateline && datatimeline >= endtimeline) || (datadateline > enddateline)
                        fin = n;
                        break;
                    end
                    end
                end
                if ini >= fin
                    continue;
                end
                %ini
                %fin
                k=ini:fin;
                mn = mean(cellfun(@str2num,database(ini:fin,3)));
                hold on;
                grid on;
                plot(k,cellfun(@str2num,database(ini:fin,3)),'g*');
                plot(k,mn,'rd');
                title(num2str(mn));
                hold off;
                print(gcf,'-dpng',strcat('.\sensor\figs\',surname,'_',directory11(i).name(1:len-4),'_plot.png')); % Save the fig in ./figs/
                close;
            end
        end
    end
end
end