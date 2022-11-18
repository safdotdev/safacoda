# ./pact_helper.sh doctor
# ./pact_helper.sh install-pact-cli docker
# ./pact_helper.sh uninstall-pact-cli docker
# ./pact_helper.sh install-pact-cli ruby
# ./pact_helper.sh uninstall-pact-cli ruby
# ./pact_helper.sh install-pact-cli standalone
# ./pact_helper.sh uninstall-pact-cli standalone
# ./pact_helper.sh pactflow-login
# ./pact_helper.sh pactflow-generate-project
# ./pact_helper.sh pactflow-generate-project javascript-node-provider-mocha
# ./pact_helper.sh pactflow-download-demo cdct
# ./pact_helper.sh pactflow-download-demo bdct
# ./pact_helper.sh pactflow-download-demo workshops
# ./pact_helper.sh pactflow-download-demo bdct example-bi-directional-consumer-msw
# ./pact_helper.sh pactflow-download-demo bdct all
# ./pact_helper.sh pactflow-download-demo workshops all
# ./pact_helper.sh pactflow-download-demo cdct all
# ./pact_helper.sh publish-pact ./consumer_contracts/pact_bdc_v1.0.3.json v1.0.3
# ./pact_helper.sh publish-provider-contract ./provider_contracts/products_v1.0.4.yml v1.0.5
# ./pact_helper.sh publish-provider-contract ./provider_contracts/products_v1.0.5.yml v1.0.5
# ./pact_helper.sh can-i-deploy v1.0.5
# ./pact_helper.sh can-i-deploy v1.0.3 pactflow-example-consumer
# ./pact_helper.sh record_deployment v1.0.3 pactflow-example-consumer
# ./pact_helper.sh record_deployment v1.0.5

PACT_CLI_STANDALONE_VERSION=1.89.00

branch=pactflow_bdc_demo
provider_name=pactflow_bdc_demo_provider
environment=production
PACT_BIN_PATH=${PACT_BIN_PATH:-'./pact/bin/'}

case $(uname -sm) in
'Linux x86_64')
    os='linux-x86_64'
    ;;
'Darwin x86' | 'Darwin x86_64' | 'Darwin arm64')
    os='osx'
    ;;
'Windows')
    os='win32'
    ;;
esac
DownloadGithubProject() {
    head_repo_branch=(master main)
    for branch in "${head_repo_branch[@]}"; do
        if curl -s --head --request GET https://github.com/${1}/${2}/tree/${branch} | grep "HTTP/2 200" >/dev/null; then
            curl -sLJO https://github.com/${1}/${2}/tarball/${branch}
        fi
    done
}
case "$1" in
can-i-deploy)
    ${PACT_BROKER_COMMAND}
    echo "\n========== STAGE: can-i-deploy? 🌉 ==========\n"
    pact-broker can-i-deploy \
        --pacticipant ${3:-$provider_name} \
        --version $2 \
        --to-environment $environment
    ;;
record_deployment)
    echo "\n========== STAGE: record deployment to production 🚀 ==========\n"
    pact-broker record_deployment \
        --pacticipant ${3:-$provider_name} \
        --version $2 \
        --environment $environment
    ;;
publish-provider-contract)
    echo "\n========== STAGE: publish-provider-contract (spec + results) ==========\n"
    pactflow publish-provider-contract \
        $2 \
        --provider ${4:-$provider_name} \
        --provider-app-version $3 \
        --branch $branch \
        --content-type application/yaml \
        --verification-success \
        --verification-results results.txt \
        --verification-results-content-type text/plain \
        --verifier pactflow_bdc_demo
    ;;
publish-pact)
    echo "\n========== STAGE: publish_pact $2 version $3 branch $==========\n"
    pact-broker publish $2 --consumer-app-version $3 --branch $branch
    ;;
install-pact-cli)
    case $2 in

    'standalone')
        tag=$(basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/pact-foundation/pact-ruby-standalone/releases/latest))
        filename="pact-${tag#v}-${os}.tar.gz"
        curl -LO https://github.com/pact-foundation/pact-ruby-standalone/releases/download/${tag}/${filename}
        case $os in
        'linux-x86_64' | 'osx')
            tar xzf ${filename}
            ;;
        'win32')
            unzip ${filename}
            ext=.bat
            ;;
        esac
        rm ${filename}
        ./pact/bin/pactflow$ext help
        ;;
    'docker')
        docker pull pactfoundation/pact-cli:latest
        docker run --rm \
            -e PACT_BROKER_BASE_URL \
            -e PACT_BROKER_TOKEN \
            pactfoundation/pact-cli:latest \
            pactflow help
        ;;
    'ruby')
        gem install pact_broker-client
        ;;
    *)
        echo "provide a value, standalone, docker or ruby"
        ;;
    esac
    ;;
uninstall-pact-cli)
    case $2 in
    'standalone')
        case $os in
        'linux-x86_64' | 'osx')
            rm -rf pact

            exit
            ;;
        'win32')
            rm -rf pact

            exit
            ;;
        esac
        ;;
    'docker')
        docker image rm pactfoundation/pact-cli

        exit
        ;;
    'ruby')
        gem uninstall -aIx pact_broker-client
        exit
        ;;
    esac
    ;;
doctor)
    echo "We are checking if the pactflow command is available"
    if ! command -v pactflow &>/dev/null; then
        echo "pactflow could not be found on \$PATH"
        echo "trying on \$PACT_BIN_PATH"
        if ! command -v ${PACT_BIN_PATH}pactflow &>/dev/null; then
            echo "pactflow could not be found on \$PACT_BIN_PATH"
            echo "Try setting the path to your pact binaries eg PACT_BIN_PATH=./pact/bin/"
            echo "trying to find docker"
            if ! command -v docker &>/dev/null; then
                echo "docker is not found"
                echo "you can install via install-pact-cli docker|ruby|standalone"
            else
                echo "Docker is installed. try install-pact-cli docker, which will perform the following"
                echo "docker pull pactfoundation/pact-cli:latest"
                echo "docker run --rm pactfoundation/pact-cli:latest pact-broker"
                echo "docker run --rm pactfoundation/pact-cli:latest pactflow"
                docker run --rm pactfoundation/pact-cli:latest pact-broker
                docker run --rm pactfoundation/pact-cli:latest pactflow
            fi
            if ! command -v ruby &>/dev/null; then
                echo "ruby is not found"
                echo "Ruby is not installed. try install-pact-cli standalone"
            else
                echo "Ruby is installed. try install-pact-cli ruby"
            fi
            if ! echo $os &>/dev/null; then
                echo "we cant detect your OS"
                echo "try installing pact-ruby-standalone manually"
            else
                echo "We can detect your OS. try install-pact-cli standalone"
            fi
        else
            echo "Hooray! pactflow command is available under ${PACT_BIN_PATH}pactflow"
            ${PACT_BIN_PATH}pact-broker
            ${PACT_BIN_PATH}pactflow
        fi
    else
        echo "Hooray! pactflow command is available globally!"
        pact-broker
        pactflow
    fi
    ;;
download-pactflow-login-helper)
    curl -LOs https://gist.github.com/YOU54F/534882c5b21db2f4fad5c17a5e64d41a/raw/63880436841fc44f03b9500e2379112df6e316e7/pactflow_login_helper && chmod +x pactflow_login_helper && ./pactflow_login_helper
    ;;
pactflow-login)
    ./pactflow_login_helper --cookie >cookie.txt
    ;;
pactflow-get-rw-token)
    curl -s -b $(cat cookie.txt) $PACT_BROKER_BASE_URL/settings/tokens | jq -r '._embedded| .items | .[] | select(.readOnly == false|.) | .value'
    ;;
pactflow-rotate-rw-token)
    curl -s -b $(cat cookie.txt) $PACT_BROKER_BASE_URL/settings/tokens |
        jq -r '._embedded| .items | .[] | select(.readOnly == false|.) | ._links | ."pb:regenerate" | .href' |
        xargs -I % curl -s -b $(cat cookie.txt) --data '{}' % | jq -r '.value'
    ;;
pactflow-get-ro-token)
    curl -s -b $(cat cookie.txt) $PACT_BROKER_BASE_URL/settings/tokens | jq -r '._embedded| .items | .[] | select(.readOnly == true|.) | .value'
    ;;
pactflow-rotate-ro-token)
    curl -s -b $(cat cookie.txt) $PACT_BROKER_BASE_URL/settings/tokens |
        jq -r '._embedded| .items | .[] | select(.readOnly == true|.) | ._links | ."pb:regenerate" | .href' |
        xargs -I % curl -s -b $(cat cookie.txt) --data '{}' % | jq -r '.value'
    ;;
pactflow-generate-project)
    PactflowGenerateProject() {
        curl -s -b $(cat cookie.txt) --output $1.zip \
            --get \
            --data-urlencode "consumer=foo" \
            --data-urlencode "provider=bar" \
            --data-urlencode "template=$1" \
            --data-urlencode "token=env-var" \
            --data-urlencode "createConsumer=false" \
            --data-urlencode "createProvider=false" \
            $PACT_BROKER_BASE_URL/generate-project.zip
    }
    # https://github.com/pactflow/example-project-templates/blob/main/manifest.json
    # cat pactflow-example-projects.json | jq -r '.exampleTemplates[] | select(.type | contains("consumer"))|{category}|join(" ")'
    all_projects=(
        javascript-node-consumer-mocha
        javascript-node-consumer-jest
        java-gradle-consumer-junit
        java-gradle-consumer-junit5
        javascript-node-provider-mocha
        javascript-node-provider-jest
        java-gradle-provider-spring_junit
        java-gradle-provider-spring_junit5

    )
    if [[ ${all_projects[*]} =~ (^|[[:space:]])$2($|[[:space:]]) ]]; then
        PactflowGenerateProject $2
    else
        echo please pick one of the following options
        for i in "${!all_projects[@]}"; do
            echo "${all_projects[$i]}"
        done
    fi
    ;;
pactflow-download-demo)

    case $2 in
    bdct)
        projects=(
            example-bi-directional-consumer-cypress
            example-bi-directional-provider-postman
            example-bi-directional-consumer-msw
            example-bi-directional-provider-dredd
            example-bi-directional-provider-restassured
            example-bi-directional-consumer-wiremock
            example-bi-directional-consumer-nock
            example-bi-directional-consumer-mountebank
            example-bi-directional-consumer-dotnet
            example-bi-directional-provider-dotnet
        )
        ;;

    cdct)
        projects=(
            example-siren
            example-provider
            example-consumer
            example-consumer-js-kafka
            example-consumer-cypress
            example-consumer-python
            example-consumer-golang
            example-consumer-java-kafka
            example-consumer-java-junit
            example-consumer-java-soap
            example-consumer-dotnet
            example-provider-golang
            example-provider-springboot
            example-provider-java-soap
            example-provider-java-kafka
            example-consumer-js-sns
            example-provider-js-sns
            example-provider-python
            example-consumer-webhookless
            example-provider-dotnet
            pactflow-jsonschema-example
            provider-driven-example
            injected-provider-states-example
        )
        ;;
    workshops)
        projects=(
            pact-workshop-js
            pact-workshop-jvm-spring
            pact-workshop-dotnet-core-v1
            pact-workshop-Maven-Springboot-JUnit5
            pact-workshop-go
        )
        org=pact-foundation
        ;;
    *)
        echo "Sorry, you'll need to an option, try bdct | cdct | workshops"
        exit

        ;;

    esac

    if [[ $3 == all ]]; then
        for i in "${!projects[@]}"; do
            echo downloading "${projects[$i]}"
            DownloadGithubProject ${org:-'pactflow'} ${projects[$i]}
            echo downloaded "${projects[$i]}"
        done
        exit
    fi

    if [[ ${projects[*]} =~ (^|[[:space:]])$3($|[[:space:]]) ]]; then
        echo downloading project $3
        DownloadGithubProject pactflow $3
    else
        echo please pick one of the following options
        for i in "${!projects[@]}"; do
            echo "${projects[$i]}"
        done
    fi
    ;;
pactflow-generate-dotenv)
    echo '
PACT_BROKER_TOKEN='$(./pact_helper.sh pactflow-get-rw-token)'
PACT_BROKER_BASE_URL='$PACT_BROKER_BASE_URL'
' >.pactflow.env
    ;;
bdct-local)
    npx @pactflow/swagger-mock-validator products_v1.0.2.yml pact_bdc_v1.0.0.json | awk '/^{$/{f=1}f{print; if(/^\}$/) f=0}'
    ;;
*)
    echo "\n========== STAGE: Not found! Uh Oh ==========\n"

    echo please provide a valid value, try can-i-deploy or publish_provider_contract

    ;;
esac
