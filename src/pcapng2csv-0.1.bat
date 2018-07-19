::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJgZkoaHErSXA==
::ZQ05rAF9IBncCkqN+0xwdVsEAlXMbCXqZg==
::ZQ05rAF9IAHYFVzEqQIgKxpEQgPQP3isZg==
::eg0/rx1wNQPfEVWB+kM9LVsJDBSBPXu0Aecf+/616vKCwg==
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQITJxVCSRaWfHu5B6US76jv4KqEsVt9
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATExFckPVt1XgCLfE+yB6cR6fH6/Ovn
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCqDJHeL4EcjFDRYTQzCGGquB/Ur4fr+/OKGsEYhROE+aIHciLedNtwD6UT0e5F/1WlM1s4UCXs=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
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