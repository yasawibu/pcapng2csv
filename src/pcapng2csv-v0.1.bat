@ECHO OFF

SET /P filter=<filter.txt
SET column_header="No.","Time","Delta Time Displayed","Source","Destination","Protocol","Length","Info"

IF EXIST "C:\Program Files (x86)\Wireshark\tshark.exe" (
   SET tshark="C:\Program Files (x86)\Wireshark\tshark.exe"
) ELSE IF EXIST "C:\Program Files\Wireshark\tshark.exe" (
   SET tshark="C:\Program Files\Wireshark\tshark.exe"
) ELSE (
   ECHO Please install wireshark!
)

SET tshark_cmd=-Y "%filter%" -T fields -E separator=, -E quote=d -e frame.number -e frame.time_relative -e frame.time_delta_displayed -e ip.src -e ip.dst -e _ws.col.Protocol -e frame.len -e _ws.col.Info

IF NOT EXIST csv\ (
   MD csv
)

ECHO Converting pcapng to csv
ECHO --------------------------------
ECHO.

FOR %%F IN (*.pcapng) DO (
   ECHO Processing File: %%F
   ECHO %column_header% > csv/%%~nF.csv
   %tshark% -r %%F %tshark_cmd% >> csv/%%~nF.csv
)

ECHO.
ECHO --------------------------------
ECHO STATUS: Finished!
ECHO.

ECHO Thanks for using this program.
ECHO.
ECHO Created by Putu Ardi Dharmayasa.
ECHO https://github.com/yasawibu
ECHO.

PAUSE