param(
    [switch]$d,      # Prevent display sleep
    [switch]$i,      # Prevent idle system sleep
    [switch]$m,      # Disk sleep - Not supported
    [switch]$s,      # Prevent sleep due to system idle (same as -i)
    [int]$t = 0      # Timeout in seconds
)

# Add kernel32.dll function for sleep prevention
Add-Type -Namespace Sleeper -Name SleepUtil -MemberDefinition @'
    [DllImport("kernel32.dll")]
    public static extern uint SetThreadExecutionState(uint esFlags);
'@

# Define flags using Convert to ensure uint32 and suppress unwanted output
$ES_CONTINUOUS       = [Convert]::ToUInt32("80000000", 16)
$ES_SYSTEM_REQUIRED  = [Convert]::ToUInt32("00000001", 16)
$ES_DISPLAY_REQUIRED = [Convert]::ToUInt32("00000002", 16)

# Build flags
$flags = $ES_CONTINUOUS

if ($i -or $s) {
    $flags = $flags -bor $ES_SYSTEM_REQUIRED
}
if ($d) {
    $flags = $flags -bor $ES_DISPLAY_REQUIRED
}
if ($m) {
    Write-Warning "-m (disk sleep) is not supported on Windows and will be ignored."
}

# Apply execution state and suppress return value
[Sleeper.SleepUtil]::SetThreadExecutionState($flags) | Out-Null

# Show user info
$hexFlags = $flags.ToString("X")
if ($t -gt 0) {
    Write-Host "Caffeinate active for $t seconds with flags: 0x$hexFlags."
    Start-Sleep -Seconds $t
    [Sleeper.SleepUtil]::SetThreadExecutionState($ES_CONTINUOUS) | Out-Null
    Write-Host "Caffeinate timed out. System sleep behavior restored."
} else {
    Write-Host "Caffeinate active indefinitely with flags: 0x$hexFlags. Press Ctrl+C to stop."
    try {
        while ($true) {
            Start-Sleep -Seconds 60
        }
    } finally {
        [Sleeper.SleepUtil]::SetThreadExecutionState($ES_CONTINUOUS) | Out-Null
        Write-Host "Caffeinate stopped. System sleep behavior restored."
    }
}
