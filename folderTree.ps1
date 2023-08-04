param(
  [string]$root = ".",
  [string[]]$exclusions = @(),
  [switch]$foldersOnly = $false
)

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
    $fullPath = (Resolve-Path $item.FullName).Path

    if ($item.PSIsContainer) {
      if ($exclusions -contains $fullPath) {
        continue
      }

      Write-Host ("{0}{1}/" -f $indent, $item.Name)

      # COMMENT: this folder is for domain driven design. I have to implement domain driven design here.
      if ($item.Name -eq "domain") {
        Write-Host ("{0}    {1}" -f $indent, "-- COMMENT: this folder is for domain driven design. I have to implement domain driven design here.")
      }

      Print-FolderStructure -root $item.FullName -level ($level + 1) -exclusions $exclusions -foldersOnly:$foldersOnly
    } elseif (-not $foldersOnly) {
      Write-Host ("{0}{1}" -f $indent, $item.Name)
    }
  }
}

# resolve all the exclusion paths to their absolute paths
$exclusions = $exclusions | ForEach-Object { (Resolve-Path $_).Path }

Print-FolderStructure -root $root -exclusions $exclusions -foldersOnly:$foldersOnly
