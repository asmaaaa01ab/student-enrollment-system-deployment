$ns = "student-enrollment"
# Si le secret existe deja, on ne le change pas (sinon le mot de passe de MySQL ne correspondrait plus)
kubectl get secret app-secrets -n $ns 2>$null | Out-Null
if ($LASTEXITCODE -eq 0) { Write-Host "app-secrets existe deja. Rien a faire."; exit 0 }
function New-RandomString($nbBytes) {
    $b = New-Object byte[] $nbBytes
    $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $rng.GetBytes($b)
    return [Convert]::ToBase64String($b)
}
$dbPassword = (New-RandomString 18) -replace '[^A-Za-z0-9]', 'x'
$jwtSecret  = (New-RandomString 48) -replace '[^A-Za-z0-9]', 'x'
kubectl create secret generic app-secrets -n $ns `
    --from-literal=DB_PASSWORD=$dbPassword `
    --from-literal=JWT_SECRET=$jwtSecret