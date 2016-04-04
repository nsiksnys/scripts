:: Searches for a function and shows filename(s), line(s) and line number(s)
:: $1 function to be searched for
 @ECHO OFF


SET function=%~1
SET searchDirectory=%USERPROFILE%\Documents\*
SET fileDirectory=%USERPROFILE%\Documents

ECHO detailed_search - Searches for a function and shows filename(s), line(s) and line number(s)
ECHO.

:directoryExists

:: IF [%1] == [] CALL :errorNoFunction

:: IF [%1] == [] CALL :inputFunction

SET /P function="Function: "
IF [%function%] == [] CALL :errorNoFunction
	
SET result=search-%function%

:: ECHO findstr /M /S %function% %searchDirectory%
ECHO Searching for function %function% en %searchDirectory%
ECHO.

CALL :search %function%

:: Error message if no function specified
:errorNoFunction
	ECHO Error: no function specified!
	PAUSE
	EXIT

:: check if directories exist, otherwise show an error message
:directoryExists
	IF NOT EXIST %searchDirectory% ECHO Directory %searchDirectory% does not exist!
	IF NOT EXIST %fileDirectory% ECHO Directory %fileDirectory% does not exist!
	PAUSE
	EXIT

:: write the function name
:inputFunction
	SET /P function="Function to be searched for: "
	IF [%function%] == [] GOTO: inputFunction

:: %1 function to be searched for
:search
	FOR /f %%i IN ('findstr /M /S %function% %searchDirectory%') DO CALL :loopBody %function% %%i
	PAUSE
	EXIT

:: search loop
:: %1 function to be searched for
:: %2 file where the search takes place
:loopBody
			ECHO %2
			:: show matching line(s) and line number(s)
			findstr /N %1 %2
			ECHO.
