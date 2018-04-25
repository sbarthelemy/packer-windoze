# fail on error
$ErrorActionPreference = "Stop"

# install chocolatey if needed.
# inspired from https://github.com/ansible/ansible-modules-extras/blob/devel/windows/win_chocolatey.ps1
$ChocoAlreadyInstalled = get-command choco -ErrorAction 0
if ($ChocoAlreadyInstalled -eq $null)
{
  # install chocolatey
  $install_output = (new-object net.webclient).DownloadString("https://chocolatey.org/install.ps1") | powershell -
  if ($LASTEXITCODE -ne 0)
  {
    throw "error installing chocolatey"
  }
}
choco install gitlab-runner -y
choco install git -y
choco install cmake -y --installargs "ADD_CMAKE_TO_PATH=System"
# install python and pip.
# python and pip will be put in PATH, but (as usual)
# will not be available in the current powershell invocation.
choco install python2 -y
choco install visualstudio2017buildtools --params "--add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.VC.140 --add Microsoft.Component.VC.Runtime.UCRTSDK --add Microsoft.VisualStudio.Component.Windows10SDK.16299.Desktop --wait --passive" -y
