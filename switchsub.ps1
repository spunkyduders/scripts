New-Module -ScriptBlock {

    function Switch-Subscription(

        [string]$s
    ) {
        if ($s -eq 'e') {
            az account set -s "Visual Studio Enterprise"
        }
        elseif ( $s -eq 'p') {
            az account set -s "Visual Studio professional"
        }
        else {
            az account set -s "Visual Studio professional with msdn"
        }


    }
} -name switchsubscription

