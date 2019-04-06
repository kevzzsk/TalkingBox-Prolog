function [reply,status]=QueryProlog(query,operation)


reply=[];status=1;

if strcmpi(operation,'w')
    %{
    fcontent = fileread('interactive.pl');
    fid = fopen('interactive.pl', 'wt');
    fwrite(fid, regexp(fcontent, '.*(?=\n.*?)', 'match', 'once'));
    fclose(fid);
    %}
    global Memorize;
    fid = fopen('interactive.pl', 'a');
    if iscell(query), query=query{1}; end
    fprintf(fid, ['\n' query]);
%     fprintf(fid, ['\n' Memorize]);
    fclose(fid);
    prolog_object=org.jpl7.Query('consult(''interactive.pl'').');
    prolog_object.hasSolution
    return;
else
    x=org.jpl7.Query(query);
    r = x.hasSolution;
    if (r)
        r = x.allSolutions;
        if ~isempty(r)
            global X MemoryList;
            match=true;counter=1;
            while(match)
                if length(r)<counter,
                    match=false;
                    reply='!!!Exhausted of options!!!';status=0;
                else
                    reply=string(r(counter).values); reply=reply{1}(2:end-1);
                    if sum(strcmpi(reply,MemoryList))==0
                        match=false;
                    else
                        counter=counter+1;%disp(counter);
                        
                    end
                end
            end
        end
        
    end
end