clc
clear
script_dir = pwd;
setenv("PATH",getenv("PATH") + ";" +script_dir);
file_dir = uigetdir('.', 'Pick File Directory');
cd(file_dir);
AllObject=dir();
AllFile=AllObject([AllObject.isdir]==0);
for iFile=1:length(AllFile)
    % set startWith8DigitDate true and validate it
    startWith8DigitDate=true;
    try
        datetime(AllFile(iFile).name(1:8),'InputFormat','yyyyMMdd');
    catch ME
        startWith8DigitDate=false;
    end
    if startWith8DigitDate
        warning('%s already start with 8 digital date',AllFile(iFile).name);
        continue;
    else
        file_modified_date_str=AllFile(iFile).date;
        file_modified_date=datetime(file_modified_date_str);
        file_modified_date_str_yyyyMMdd=char(string(file_modified_date,'yyyyMMdd'));
        output_name=strcat(file_modified_date_str_yyyyMMdd," ",AllFile(iFile).name);
        if ~exist(fullfile(file_dir,output_name),'file')
            status=movefile(fullfile(file_dir,AllFile(iFile).name),fullfile(file_dir,output_name));
            if ~status
                warning('%s can not be renamed',AllFile(iFile).name);
            end
        else
            warning('Exist same file %s',output_name);
        end
    end
end
cd(script_dir);





