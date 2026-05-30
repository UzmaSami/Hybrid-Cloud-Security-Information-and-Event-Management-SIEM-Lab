Write-Host "⚔️ Initiating Mock Brute Force Attack..." -ForegroundColor Red
1..15 | ForEach-Object {
    net use \\localhost\c$ /user:FakeAttacker "BadPassword123!" 2>&1 | Out-Null
    Write-Host "Failed login attempt $_ generated." -ForegroundColor Yellow
}
Write-Host "Attack simulation complete! Check your SIEM." -ForegroundColor Green

