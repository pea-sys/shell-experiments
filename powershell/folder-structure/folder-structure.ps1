function Truncate([double]$num, [int]$numDigits = 0) {
    $m = [Math]::Pow(10, $numDigits);
    return [Math]::Truncate($num * $m) / $m;
}
function GetGitIgonoreItem([string]$target) {
    $likeIgnores = @{}
    $matchIgnores = @{}
    $lookupTable = @{
        '[' = '\[' 
        ']' = '\]'
    }
    foreach ($g in $(Get-ChildItem $target -File -Recurse -Force -include '.gitignore')) {
        $arr = Get-Content $g | Where-Object { ($_ -notlike '#*') -and ($_ -ne '') }
        $like = $arr.GetEnumerator() | Where-Object { $_.Contains('*') }
        $match = $arr.GetEnumerator() | Where-Object { !($_.Contains('*')) }
        foreach ($l in $lookupTable) {
            $match = $match -replace $l.Key, $l.Value
        }
        $parent = Split-Path -Path $g.FullName -Parent
        
        $likeIgnores.Add($parent , $like)
        $matchIgnores.Add($parent , $match)
    }
    return $likeIgnores, $matchIgnores
}

if ([string]::IsNullorEmpty($Args[0])) {
    Write-Host '[Example]'
    Write-Host  $myInvocation.MyCommand.name '<TargetDirectory>'
    return
}
else {
    $target = $args[0] #C:\Users\user\source\repos\PowerToys
}

$exclude = @()#'.pack'
$ext_sizes = @{}
$total_sizes = 0
$files = Get-ChildItem $target -File -Recurse -Force
$not_calc_threshold = 0.01
$likeIgnores, $matchIgnores = GetGitIgonoreItem($target)
$isGit = $false #experiment
#Grouping extension
foreach ($f in $files) {
    if ($exclude.Contains($f.Extension)) {
        continue
    }

    if ($isGit) {
        #GitIgnore filter
        foreach ($l in $likeIgnores.GetEnumerator()) {
            #target repository
            if ($f.FullName.Contains($l.Key)) {
                $currentName = $f.FullName.Replace($l.Key, '')
                foreach ($i in $l.Value) {
                    if ($currentName -like $i ) {
                        Write-Host $currentName
                        continue
                    }
                }
            }
        }
        foreach ($m in $matchIgnores.GetEnumerator()) {
            #target repository
            if ($f.FullName.Contains($m.Key)) {
                $currentName = $f.FullName.Replace($m.Key, '')
                foreach ($i in $m.Value) {
                    if ($currentName -match $i ) {
                        Write-Host $currentName
                        continue
                    }
                }
            }
        }
    }

    $f_size = (Get-Item $f).Length
    $ext_sizes[$f.Extension] += $f_size
    $total_sizes += $f_size
}
#Merge files under a threshold size into one
$ext_sizes['others'] = 0
foreach ($k in $($ext_sizes.Keys)) {
    $ext_sizes[$k] /= $total_sizes
    $ext_sizes[$k] = Truncate $ext_sizes[$k] 2
    if ($not_calc_threshold -ge $ext_sizes[$k]) {
        $ext_sizes['others'] += $ext_sizes[$k]
        $ext_sizes.Remove($k)
    }
}

$ext_sizes = ($ext_sizes.GetEnumerator() | Sort-Object -Descending -property:Value)
$ext_sizes.GetEnumerator() | Format-Table

$ext_Keys = $ext_sizes.Name
$ext_Values = $ext_sizes.Value

#Create Chart
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms.DataVisualization
$chart = New-Object System.Windows.Forms.DataVisualization.Charting.Chart
$chart_area = New-Object System.Windows.Forms.DataVisualization.Charting.ChartArea
$series = New-Object  System.Windows.Forms.DataVisualization.Charting.Series
$legend = New-Object System.Windows.Forms.DataVisualization.Charting.Legend
$chart.Series.Add($series)
$chart.ChartAreas.Add($chart_area)
$chart.Legends.Add($legend)
$chart.Series["Series1"].LegendText = "#VALX (#VALY)"
$chart.Height *= 2
$chart.Width *= 2
$series.ChartType = [System.Windows.Forms.DataVisualization.Charting.SeriesChartType]::Pie
$series.Points.DataBindXY($ext_Keys, $ext_Values)
$series.IsXValueIndexed = $true
$png_output = (Get-Date -UFormat "%Y%m%d%H%M%S") + '_' + (Split-Path $target -Leaf) + '.png'
$png_output = Join-Path $PSScriptRoot $png_output
$chart.SaveImage($png_output , "png")

