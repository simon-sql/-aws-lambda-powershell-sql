## PowerShell runtime information

See the [PowerShell-runtime](powershell-runtime/) page for more information on how the runtime works, including:

* Variables
* Lambda handler options
* Lambda context object in PowerShell
* PowerShell module support
* Function logging and metrics
* Function errors

### [Examples folder](examples/)

Currently contains a single demo applications to show the PowerShell runtime functionality incorporating the SqlServer Powershell module.

[sqlserver-container-image-sqlserver](examples/sqlserver-container-images-shared) demo application to deploy a PowerShell Lambda function using a [container image](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html). 

The container image can be up to 10Gb in size which allows you to build functions larger than the 256MB limit for .zip archive functions. This allows you to include the entire [AWSTools for PowerShell](https://aws.amazon.com/powershell/) SDK and the [SqlServer PowerShell module](https://www.powershellgallery.com/packages/sqlserver/22.2.0), for example.

## Acknowledgements

This demo builds on the work of [Norm Johanson](https://twitter.com/socketnorm), [Kevin Marquette](https://twitter.com/KevinMarquette), [Andrew Pearce](https://twitter.com/austoonz), Afroz Mohammed, and Jonathan Nunn.

## License

This project is licensed under the Apache-2.0 License.
