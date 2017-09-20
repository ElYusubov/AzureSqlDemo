# Login to Azure account
Login-AzureRmAccount

# Set the resource group name and location for your server
$resourcegroupname = "demoRG-$(Get-Random)"
$location = "eastus2"

# Set elastic poool names
$firstpoolname = "FirstPool"
$secondpoolname = "SecondPool"

# Set an admin login and password for your server
$adminlogin = "ServerAdmin"
$password = "ChangeYourAdminPassword1"

# The logical server name has to be unique in the system
$servername = "demo-server-$(Get-Random)"

# The sample database names
$firstdatabasename = "demoSampleDatabase1"
$seconddatabasename = "demoSampleDatabase2"

# Set ip address range that you want to allow to access your server
$startip = "0.0.0.0"
$endip = "0.0.0.0"

# Create a new resource group
$resourcegroup = New-AzureRmResourceGroup -Name $resourcegroupname -Location $location

# Create a new server with a system wide unique server name
$server = New-AzureRmSqlServer -ResourceGroupName $resourcegroupname `
    -ServerName $servername `
    -Location $location `
    -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminlogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))

# Create a server firewall rule that allows access from the specified IP range
$serverfirewallrule = New-AzureRmSqlServerFirewallRule -ResourceGroupName $resourcegroupname `
    -ServerName $servername `
    -FirewallRuleName "IpAccessRange" -StartIpAddress $startip -EndIpAddress $endip

# Create two elastic database pools
$firstpool = New-AzureRmSqlElasticPool -ResourceGroupName $resourcegroupname `
    -ServerName $servername `
    -ElasticPoolName $firstpoolname `
    -Edition "Standard" `
    -Dtu 50 `
    -DatabaseDtuMin 10 `
    -DatabaseDtuMax 20

$secondpool = New-AzureRmSqlElasticPool -ResourceGroupName $resourcegroupname `
    -ServerName $servername `
    -ElasticPoolName $secondpoolname `
    -Edition "Standard" `
    -Dtu 50 `
    -DatabaseDtuMin 10 `
    -DatabaseDtuMax 50

# Create two blank databases in the first pool
$firstdatabase = New-AzureRmSqlDatabase  -ResourceGroupName $resourcegroupname `
    -ServerName $servername `
    -DatabaseName $firstdatabasename `
    -ElasticPoolName $firstpoolname
$seconddatabase = New-AzureRmSqlDatabase  -ResourceGroupName $resourcegroupname `
    -ServerName $servername `
    -DatabaseName $seconddatabasename `
    -ElasticPoolName $secondpoolname

# Move the database to the second pool
$firstdatabase = Set-AzureRmSqlDatabase -ResourceGroupName $resourcegroupname `
    -ServerName $servername `
    -DatabaseName $firstdatabasename `
    -ElasticPoolName $secondpoolname

# Remove the first pool
# Remove-AzureRmSqlElasticPool -ElasticPoolName $firstpoolname -ResourceGroupName $resourcegroupname -ServerName $servername -Confirm -Force

# Move the database into a standalone performance level
$firstdatabase = Set-AzureRmSqlDatabase -ResourceGroupName $resourcegroupname `
    -ServerName $servername `
    -DatabaseName $firstdatabasename `
    -RequestedServiceObjectiveName "S0"

# Clean up resources 
# Remove-AzureRmResourceGroup -ResourceGroupName $resourcegroupname