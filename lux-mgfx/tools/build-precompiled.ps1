param(
  [string]$Luxc = ""
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($Luxc)) {
  if (-not [string]::IsNullOrWhiteSpace($env:LUXC_PATH)) {
    $Luxc = $env:LUXC_PATH
  } else {
    $Luxc = "luxc"
  }
}

$RepoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$SourceProject = Join-Path $RepoRoot "precompiled"
$DistRoot = Join-Path $RepoRoot "dist"
$DistLua = Join-Path $DistRoot "lua"

$ResolvedRepo = [System.IO.Path]::GetFullPath($RepoRoot)
$ResolvedDistLua = [System.IO.Path]::GetFullPath($DistLua)
$separator = [System.IO.Path]::DirectorySeparatorChar
if (-not $ResolvedDistLua.StartsWith($ResolvedRepo + $separator, [System.StringComparison]::OrdinalIgnoreCase)) {
  throw "refusing to clean output outside repository: $ResolvedDistLua"
}

$TempBase = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
$WorkRoot = Join-Path $TempBase ("lux-mgfx-precompiled-" + [guid]::NewGuid().ToString("N"))
$ResolvedWorkRoot = [System.IO.Path]::GetFullPath($WorkRoot)
if (-not $ResolvedWorkRoot.StartsWith($TempBase, [System.StringComparison]::OrdinalIgnoreCase)) {
  throw "refusing to use temp workspace outside temp directory: $ResolvedWorkRoot"
}

try {
  New-Item -ItemType Directory -Path $WorkRoot | Out-Null
  $ProjectRoot = Join-Path $WorkRoot "precompiled"
  Copy-Item -LiteralPath $SourceProject -Destination $ProjectRoot -Recurse

  if (Test-Path -LiteralPath $DistLua) {
    Remove-Item -LiteralPath $DistLua -Recurse -Force
  }
  New-Item -ItemType Directory -Path $DistLua | Out-Null

  & $Luxc install "@lux/mgfx" --from $RepoRoot --project $ProjectRoot
  if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
  }

  & $Luxc gmod build --manifest (Join-Path $ProjectRoot "lux.toml") --out $DistLua
  if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
  }

  Get-ChildItem -LiteralPath $DistLua -Recurse -Filter "*.map.json" |
    Remove-Item -Force

  Write-Host "MGFX precompiled loader written to $DistLua"
} finally {
  if (Test-Path -LiteralPath $WorkRoot) {
    Remove-Item -LiteralPath $WorkRoot -Recurse -Force
  }
}
