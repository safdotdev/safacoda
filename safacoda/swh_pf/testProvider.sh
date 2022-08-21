#!/bin/bash
Errors=0

Green='\033[0;32m'
Red='\033[0;31m'
Color_Off='\033[0m'

Check_Mark='\xE2\x9C\x94'

assert_equals() {
    if [ "$1" = "$2" ]; then
        echo -e "$Green $Check_Mark Success $Color_Off"
    else
        echo -e "$Red Failed $Color_Off"
        echo -e "$Red Expected $1 to equal $2 $Color_Off"
        Errors=$((Errors + 1))
    fi
}

get_json_value() {
    echo $1 | jq -r $2
}

get_json_array_length() {
    echo $1 | jq ". | length"
}

endpoint=$1
echo "### START $endpoint"

echo "When getting a product by id"
response=$(curl -s "$endpoint/product/42")
assert_equals "$(get_json_value "$response" ".id")" "1234"
assert_equals "$(get_json_value "$response" ".type")" "food"
assert_equals "$(get_json_value "$response" ".price")" 42

echo "When getting all products"
response=$(curl -s "$endpoint/products")
assert_equals "$(get_json_value "$response" ".[0].id")" "1234"
assert_equals "$(get_json_value "$response" ".[0].type")" "food"
assert_equals "$(get_json_value "$response" ".[0].price")" 42

echo "When creating a product"
response=$(curl -X POST -s "$endpoint/products" -d '{"id": "1234", "type": "food"}')
assert_equals "$(get_json_value "$response" ".id")" "1234"
assert_equals "$(get_json_value "$response" ".type")" "food"
assert_equals "$(get_json_value "$response" ".price")" 42

echo "### END $endpoint"

if [ "$Errors" -gt "0" ]; then
    exit 1
else
    exit 0
fi
