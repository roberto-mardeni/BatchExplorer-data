
echo # installing python ...
choco install python -y 
echo # refreshing environment vars ...
call RefreshEnv.cmd
echo # installing azure-batch sdk for python ...
pip install azure-batch==4.1.3
echo Exit Code is %errorlevel%
exit /b %errorlevel%
