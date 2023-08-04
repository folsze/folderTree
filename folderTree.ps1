param(
  [string]$root = ".",
  [string[]]$exclusions = @(),
  [switch]$foldersOnly = $false
)

# Check for unknown arguments
$validArgs = 'root', 'exclusions', 'foldersOnly'
$argsList = $PSBoundParameters.Keys
foreach ($arg in $argsList) {
  if ($arg -notin $validArgs) {
    Write-Error "Unknown argument: -$arg"
    exit 1
  }
}

if (-not (Test-Path $root)) {
  Write-Error "The specified folder $root does not exist."
  exit 1
}

function Print-FolderStructure {
  param(
    [string]$root,
    [int]$level = 0,
    [string[]]$exclusions,
    [switch]$foldersOnly
  )

  $indent = " " * $level * 4
  $items = Get-ChildItem -Path $root

  foreach ($item in $items) {
    if ($item.PSIsContainer) {
      if ($item.Name -in $exclusions) {
        continue
      }

      Write-Host ("{0}{1}/" -f $indent, $item.Name)

      Print-FolderStructure -root $item.FullName -level ($level + 1) -exclusions $exclusions -foldersOnly:$foldersOnly
    } elseif (-not $foldersOnly) {
      Write-Host ("{0}{1}" -f $indent, $item.Name)
    }
  }
}

Print-FolderStructure -root $root -exclusions $exclusions -foldersOnly:$foldersOnly
