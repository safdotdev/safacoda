## Workshop Prerequisites - Online

- Nothing! Just you and a bit of time
  - All of the Prerequisites shown in the below section are already added to your online environment.

## Workshop Prerequisites - Locally

- Java 11
- NodeJS 16+ (20 is used in this demo)
- Git
- Docker
- Some experience with command-line tools.

## Goals

Leverage [PactFlow AI](https://docs.pactflow.io/docs/ai) in several scenarios

## Scenarios

1. Setup
   1. Download the `pactflow-ai` cli tool
   2. Setup authentication to your PactFlow account
2. Grab the TypeScript example
3. Lets create some tests - JavaScript / TypeScript
   1. `request-response`:
      1. Generate a Pact from a HTTP request and response pair from curl.
   2. `openapi`:
      1. Generate a Pact from a OpenAPI specification
      2. Improve the output by providing it the client code.
   3. `client-code`
      1. Generate Pact tests from client code.
<!-- 4. Lets create some tests - Java
   1. Grab the Java example project
   2. `client-code`
      1. Generate Pact tests from client code. -->

## Ready to start?

Pick your preferred programming language, or multiple if you want to mix and match.

### Setup your required programming language

Click on the code below, to run the installer in your integrated terminal.

Please wait until it's finished and then you can continue!

#### Java

- Version 17.x

```
apt install openjdk-17-jdk openjdk-17-jre
```{{exec}}

#### Node

- Version 20.x

```
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
```{{exec}}

#### .NET

- Version 8.x

```
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0
```{{exec}}

#### Golang

- Latest

```
release=$(wget -qO- "https://golang.org/VERSION?m=text" | awk '/^go/{print $0}')
release_file="${release}.linux-amd64.tar.gz"
tmp=$(mktemp -d)
cd $tmp || exit 1
curl -OL https://go.dev/dl/$release_file
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf $release_file
rm -rf $tmp
cd ~
```{{exec}}

#### Python

- Version 3.11

```
add-apt-repository -y ppa:deadsnakes/ppa
apt-get install python3.11 -y
```{{exec}}

## Now, you can begin


Thanks and enjoy.

--

The PactFlow Team.
