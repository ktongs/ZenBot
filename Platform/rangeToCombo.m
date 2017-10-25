function combo = rangeToCombo(range,heroCardNumbers,commonCardNumbers)
%This will return the possible combinations given player range

[M,~] = size(range);
% stringInput = '';
combo = [];

for w = 1:M
    addedCombos = getCombo(range{w,:});
    combo = [combo; addedCombos];
end

    function x = getCombo(stringInput)
        
        if strcmpi(stringInput(1),stringInput(2)) %pair
            type = 'p';
        elseif strcmpi(stringInput(3),'o') %offsuit
            type = 'o';
        elseif strcmpi(stringInput(3),'s') %suited
            type = 's';
        else
            msgbox ('invalid range')
        end
        
        x = zeros(1,2);
        count = 1;
        switch type
            case 'p'
                switch stringInput(1)
                    case 'A'
                        numStart = 1;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case 'K'
                        numStart = 5;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case 'Q'
                        numStart = 9;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case 'J'
                        numStart = 13;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case 'T'
                        numStart = 17;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case '9'
                        numStart = 21;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case '8'
                        numStart = 25;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case '7'
                        numStart = 29;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case '6'
                        numStart = 33;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case '5'
                        numStart = 37;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case '4'
                        numStart = 41;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case '3'
                        numStart = 45;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    case '2'
                        numStart = 49;
                        for j = numStart:numStart + 3
                            if (j ~= heroCardNumbers)
                                if (j ~= commonCardNumbers)
                                    for k = j:numStart + 3
                                        if (k~=j)
                                            if (k ~= heroCardNumbers)
                                                if (k ~= commonCardNumbers)
                                                    x(count,:) = [j k];
                                                    count = count + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        
                end
            case 's'
                startMat = zeros(1,2);
                for i = 1:2
                    switch stringInput(i)
                        case 'A'
                            numStart = 1;
                            startMat(1,i) = numStart;
                        case 'K'
                            numStart = 5;
                            startMat(1,i) = numStart;
                        case 'Q'
                            numStart = 9;
                            startMat(1,i) = numStart;
                        case 'J'
                            numStart = 13;
                            startMat(1,i) = numStart;
                        case 'T'
                            numStart = 17;
                            startMat(1,i) = numStart;
                        case '9'
                            numStart = 21;
                            startMat(1,i) = numStart;
                        case '8'
                            numStart = 25;
                            startMat(1,i) = numStart;
                        case '7'
                            numStart = 29;
                            startMat(1,i) = numStart;
                        case '6'
                            numStart = 33;
                            startMat(1,i) = numStart;
                        case '5'
                            numStart = 37;
                            startMat(1,i) = numStart;
                        case '4'
                            numStart = 41;
                            startMat(1,i) = numStart;
                        case '3'
                            numStart = 45;
                            startMat(1,i) = numStart;
                        case '2'
                            numStart = 49;
                            startMat(1,i) = numStart;
                    end
                end
                
                for p = startMat(1,1):startMat(1,1) + 3
                    if (p ~= heroCardNumbers)
                        if (p ~= commonCardNumbers)
                            for q = startMat(1,2):startMat(1,2) + 3
                                if (q ~= heroCardNumbers)
                                    if (q ~= commonCardNumbers)
                                        if (mod(p,4) == mod (q,4)) %check if suited
                                            x(count,:) = [p q];
                                            count = count + 1;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            case 'o'
                startMat = zeros(1,2);
                for i = 1:2
                    switch stringInput(i)
                        case 'A'
                            numStart = 1;
                            startMat(1,i) = numStart;
                        case 'K'
                            numStart = 5;
                            startMat(1,i) = numStart;
                        case 'Q'
                            numStart = 9;
                            startMat(1,i) = numStart;
                        case 'J'
                            numStart = 13;
                            startMat(1,i) = numStart;
                        case 'T'
                            numStart = 17;
                            startMat(1,i) = numStart;
                        case '9'
                            numStart = 21;
                            startMat(1,i) = numStart;
                        case '8'
                            numStart = 25;
                            startMat(1,i) = numStart;
                        case '7'
                            numStart = 29;
                            startMat(1,i) = numStart;
                        case '6'
                            numStart = 33;
                            startMat(1,i) = numStart;
                        case '5'
                            numStart = 37;
                            startMat(1,i) = numStart;
                        case '4'
                            numStart = 41;
                            startMat(1,i) = numStart;
                        case '3'
                            numStart = 45;
                            startMat(1,i) = numStart;
                        case '2'
                            numStart = 49;
                            startMat(1,i) = numStart;
                    end
                end
                
                for p = startMat(1,1):startMat(1,1) + 3
                    if (p ~= heroCardNumbers)
                        if (p ~= commonCardNumbers)
                            for q = startMat(1,2):startMat(1,2) + 3
                                if (q ~= heroCardNumbers)
                                    if (q ~= commonCardNumbers)
                                        if (mod(p,4) ~= mod (q,4)) %check if suited
                                            x(count,:) = [p q];
                                            count = count + 1;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
        end
    end
end
