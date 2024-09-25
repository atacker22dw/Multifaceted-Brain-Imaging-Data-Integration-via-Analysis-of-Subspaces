function filledMatrix = fillMissingValuesWithRowMean(inputMatrix)
    % Input: inputMatrix - the matrix with missing values
    % Output: filledMatrix - the matrix with missing values filled with row means
    
    % Find indices of missing values
    missingIndices = isnan(inputMatrix);
    
    % Initialize the output matrix with the same values as the input
    filledMatrix = inputMatrix;
    
    % Iterate through each row
    for i = 1:size(inputMatrix, 1)
        % Find indices of missing values in the current row
        missingInRow = missingIndices(i, :);
        
        % Calculate the mean of the row excluding missing values
        rowMean = mean(inputMatrix(i, ~missingInRow));
        
        % Fill missing values in the row with the calculated mean
        filledMatrix(i, missingInRow) = rowMean;
    end
end
