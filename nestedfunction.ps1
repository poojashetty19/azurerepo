function nestedfunction {
    param (
        [Parameter(Mandatory=$true)]
        [object]$Object,
        [Parameter(Mandatory=$true)]
        [string]$Key
    )

    foreach ($Key in $Key.Split("/")) {
        $Object = $Object[$Key]
    }
    return $Object
}


$nestedObject = @{ "x" = @{ "y" = @{ "z" = "azure" } } }
$key = "x/y/z"

$value = nestedfunction -Object $nestedObject -Key $key

Write-Output $value
