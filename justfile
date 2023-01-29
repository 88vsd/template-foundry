alias a := anvil
alias b := build
alias i := install
alias cl := call-local
# TEST CONTRACTS
alias tl := test-local

# Load .env file.
set dotenv-load := true
# Pass justfile recipe args as positional arguments.
set positional-arguments := true

default:
    @just --list

source := "export PATH=$PATH:$HOME/.foundry/bin"

init:
    {{source}} && yarn && forge install

# Run anvil local Ethereum development node.
anvil *args="":
    {{source}} && anvil {{args}}

# Build the project's smart contracts.
build:
    {{source}} && forge build

# Perform a call on an account without publishing a transaction.
call-local contract_addr function_sig:
    {{source}} && cast call {{contract_addr}} "{{function_sig}}" --rpc-url http://127.0.0.1:8545

# Remove the build artifacts and cache directories.
clean:
    {{source}} && forge clean

# Run help for a certain command.
help *commands="":
    {{source}} && {{commands}} --help

# Install solidity dependencies.
install *repositories="":
    {{source}} && forge install {{repositories}}

remove *repositories="":
    {{source}} && forge remove {{repositories}}

# Sign and publish a transaction.
send-local private_key contract_addr function_sig:
    {{source}} && cast send --private-key {{private_key}} {{contract_addr}} "{{function_sig}}" --rpc-url http://127.0.0.1:8545

# Run test scripts locally.
test-local *v="":
    {{source}} && forge test -vvv{{v}}