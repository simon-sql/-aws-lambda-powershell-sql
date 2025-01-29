#$VerbosePreference = "continue"
#$VerbosePreference = "SilentlyContinue"
Write-Verbose "Run script init tasks before handler"
Write-Verbose "Importing Modules"
Import-Module "SqlServer"

function handler {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        $LambdaInput,

        [Parameter(Mandatory=$true)]
        $LambdaContext
    )

    Write-Verbose "Running handler function..."
    Write-Verbose "Function Remaining Time: $($LambdaContext.GetRemainingTimeInMillis()) ms"

    #Write-Verbose "LambdaInput: $LambdaInput"

    $ErrorActionPreference = 'Stop'

    try {
        # Example: Extract data from LambdaInput

        $sqlInstanceName = $LambdaInput.sqlInstanceName
        if (-not $sqlInstanceName) {
            throw "SQL Server Instance Name not provided in Lambda input."
        }

        $sqlLogin = $LambdaInput.sqlLogin
        if (-not $sqlLogin) {
            throw "Login not provided in Lambda input."
        }

        $sqlPassword = $LambdaInput.sqlPassword
        if (-not $sqlPassword) {
            throw "Password not provided in Lambda input."
        }

        $sqlQuery = 'SELECT @@SERVERNAME AS [server_name]'
        $connectionString = "Server=$sqlInstanceName;Trusted_Connection=no;User Id=sqlLogin;Password=sqlPassword;Trust Server Certificate=true;"

        # Execute SQL Command
        $queryResult = Invoke-Sqlcmd -ConnectionString $connectionString -Query $sqlQuery | ConvertTo-Json
        Write-Output $queryResult
    } catch {
        $errorMessage = "An error occurred while executing the SQL command: $($_.Exception.Message)"
        Write-Output $errorMessage | ConvertTo-Json
    }
}



